module PILLOUT(clk,
					//Teclado
					filas,
					columnas,
					//RFID
					RX,
					TX,
					//Servos
					Servo1,
					Servo2,
					//Bocina
					Bocina,
					//7 segmentos
					HEX0,
					dis,
					//LCD
					LCD_RW, 
					LCD_EN, 
					LCD_RS, 
					LCD_DATA);

//CLK
input	clk;

//Teclado
input  [3:0]filas;
output [3:0]columnas;

//RFID
input RX;
output TX;
reg RST = 1;

//Servos
output Servo1;
output Servo2;

//Bocina
output Bocina;

//7 segmentos
output dis;
output [6:0] HEX0;

//LCD
output  [7:0] LCD_DATA;
output LCD_RW;
output LCD_EN;
output LCD_RS;

//Registros
wire  [719:0] DATOS; //Letras-Números que se muestran en el LCD
wire [4:0]num;
wire Done;
reg [2:0]state=0;
reg [1:0]posi = 0;
reg [2:0]posiH = 0;
reg in;
reg [15:0]contador = 0;


reg [387:0]Base = 0;

wire [3:0] seg1;
wire [3:0] seg2;
wire [3:0] min1;
wire [3:0] min2;
wire [3:0] hora1;
wire [3:0] hora2;
wire [3:0] dia1;
wire [3:0] dia2;

wire [23:0]tiempo;

//Frecuencias
wire DLY_RST;
wire clk_1k;
wire clk_10k;
wire [31:0]tag;
wire done;
reg parar;
wire [4:0]sonar;
reg reset = 0;
reg [3:0]med;

//Frecuencia de operación de todos los modulos
DivFreq 		div0 (clk, clk_10k, 'd2_500);

//Frecuencia para reproducir una nota musical en la bocina
DivFreq 		div1 (clk, clk_440, 'd56_818);

//Modulo del cronometro
Cronometro cronometro1(clk_10k, tiempo);

//Modulo del LCD
LCD_TEXT    LCD1(clk, DLY_RST, LCD_DATA, LCD_RW, LCD_EN, LCD_RS, DATOS, Done);
Reset_Delay r0 (clk,DLY_RST, Done, DATOS);
Pantallas   dis1(clk_10k, DATOS, state, info, user, posi, posiH, in, validate, tiempo[15:0]);

//Modulo del teclado
Barrido 		bar  (clk_10k, columnas);
Comparador  comp (clk_10k, filas, columnas, num);

//Modulo RFID
UART RFID(clk, clk_10k, RX, TX, RST, tag, done);

PWM servos(clk, Servo1, Servo2, med);

//Alarma(clk_10k, clk_440, Bocina, Usuarios, sonar, parar);

BCDSSeg sseg(num[3:0], HEX0);

parameter MenuPrin 	 = 0;
parameter NewUser1 	 = 1;
parameter NewUser2 	 = 2;
parameter RFID1    	 = 3; 
parameter RFID2    	 = 4;
parameter Medicamento = 5;


reg [514:0]Usuarios = 0;
reg [128:0]info = 0;
reg [3:0]  user  = 0;
reg validate = 0;

always@(posedge clk_10k)begin
//parar = 0;
if(state == 0) med = num;

info = 0;
case(user)
		4'h0:   info = Usuarios[128:0];  
		4'h1:   info = Usuarios[257:129];
		4'h2:   info = Usuarios[386:258];
		4'h3:   info = Usuarios[514:387];
endcase

case(state)
	MenuPrin:begin
					if(num == 5'h11) begin
						state = 1;
						info[0] = 1;  
					if(Usuarios[0]   == 0) begin user=4'h0; end
					else if(Usuarios[129] == 0) begin user=4'h1; end
					else if(Usuarios[258] == 0) begin user=4'h2; end
					else if(Usuarios[387] == 0) begin user=4'h3; end
					else state = 0;
					end
					if(num == 5'h12) begin state = 4; RST = 0; end
			end
			
	NewUser1:begin
					
					
				if(in == 0 && num == 5'h1B) begin
					state = 0; 
					posi = 0; 
					posiH = 0; 
					if( validate == 0)info = 0;
					else validate = 0;
				end
				
				if(in == 0)begin
					if(posi == 0 || (num == 5'h1C && posi == 2'b10)) posi = 2'b01;
					else if((num == 5'h1D && posi == 2'b01) || (num == 5'h1c && posi == 2'b11)) posi = 2'b10;
					else if(num == 5'h1D && posi == 2'b10) posi = 2'b11;
				end
				
				if((num == 5'h1A && (posi == 2'b01 || posi == 2'b10))|| in == 1)begin
				in = 1;
					if((num == 5'h1E && posiH == 3'b000) || (num == 5'h1F && posiH == 3'b010)) posiH = 3'b001;
					else if((num == 5'h1E && posiH == 3'b001) || (num == 5'h1F && posiH == 3'b011)) posiH = 3'b010;
					else if((num == 5'h1E && posiH == 3'b010) || (num == 5'h1F && posiH == 3'b100)) posiH = 3'b011;
					else if((num == 5'h1E && posiH == 3'b011) || (num == 5'h1F && posiH == 3'b101)) posiH = 3'b100;
					else if((num == 5'h1E && posiH == 3'b100)) posiH = 3'b101;			
					else if(num == 5'h1F && posiH == 3'b001) posiH = 3'b000;		
					
					if(posi == 2'b01 && num[4]==1'b1 && num[3:0] <= 4'h9)begin
					
						case(posiH)
							3'b000: info[4:1] = num[3:0];
							3'b001: info[8:5] = num[3:0];
							3'b010: if(num[3:0] < 4'h3 && info[16:13] < 4'h4)info[12:9] = num[3:0];
							3'b011: begin 
									  if(info[12:9] != 4'h2) info[16:13] = num[3:0];
										else if(num[3:0] < 4'h4) info[16:13] = num[3:0];
									  end
							3'b100: if(num[3:0] < 4'h6)info[20:17] = num[3:0];		
							3'b101: info[24:21] = num[3:0];				
						endcase						
					end

					if(posi == 2'b10 && num[4]==1'b1 && num[3:0] <= 4'h9)begin
					case(posiH)
						3'b000: info[28:25] = num[3:0];
						3'b001: info[32:29] = num[3:0];
						3'b010: if(num[3:0] < 4'h3 && info[40:37] < 4'h4)info[36:33] = num[3:0];
						3'b011: begin 
									if(info[36:33] != 4'h2) info[40:37] = num[3:0];
									else if(num[3:0] < 4'h4)info[40:37] = num[3:0];
								  end
						3'b100: if(num[3:0] < 4'h6)info[44:41] = num[3:0];
						3'b101: info[48:45] = num[3:0];				
					endcase
					end
					if(num == 5'h1B)begin in=0; posiH = 3'b000; end
				end	
				if(in == 0 && posi==2'b11 && num == 5'h1A)  begin state = 2; posi = 0; posiH = 0;end	
				end
	
	NewUser2:begin
				if(in == 0 && num == 5'h1B) begin
					state = 0; 
					posi = 0; 
					posiH = 0; 
					if( validate == 0)begin
					info = 0;
					end else validate = 0;
				end
				
				if(in ==	0)begin
					if(num == 5'h1C && posi == 2'b01) posi = 2'b00;
					if((num == 5'h1D && posi == 2'b00) || (num == 5'h1C && posi == 2'b10)) posi = 2'b01;
					else if((num == 5'h1D && posi == 2'b01) || (num == 5'h1c && posi == 2'b11)) posi = 2'b10;
					else if(num == 5'h1D && posi == 2'b10 && validate == 0) posi = 2'b11;
				end
				
				if((num == 5'h1A && (posi == 2'b01 || posi == 2'b10)) || in == 1)begin
				in = 1;
					if((num == 5'h1E && posiH == 3'b000) || (num == 5'h1F && posiH == 3'b010)) posiH = 3'b001;
					else if((num == 5'h1E && posiH == 3'b001) || (num == 5'h1F && posiH == 3'b011)) posiH = 3'b010;
					else if((num == 5'h1E && posiH == 3'b010) || (num == 5'h1F && posiH == 3'b100)) posiH = 3'b011;
					else if((num == 5'h1E && posiH == 3'b011) || (num == 5'h1F && posiH == 3'b101)) posiH = 3'b100;
					else if((num == 5'h1E && posiH == 3'b100)) posiH = 3'b101;			
					else if(num == 5'h1F && posiH == 3'b001) posiH = 3'b000;		
					
					if(posi == 2'b01 && num[4]==1'b1 && num[3:0] <= 4'h9)begin
					
						case(posiH)
							3'b000: info[52:49] = num[3:0];
							3'b001: info[56:53] = num[3:0];
							3'b010: if(num[3:0] < 4'h3 && info[64:61] < 4'h4)info[60:57] = num[3:0];
							3'b011: begin 
									  if(info[60:57] != 4'h2) info[64:61] = num[3:0];
										else if(num[3:0] < 4'h4) info[64:61] = num[3:0];
									  end
							3'b100: if(num[3:0] < 4'h6)info[68:65] = num[3:0];		
							3'b101: info[72:69] = num[3:0];				
						endcase
					end

					if(posi == 2'b10 && num[4]==1'b1 && num[3:0] <= 4'h9)begin
					case(posiH)
						3'b000: info[76:73] = num[3:0];
						3'b001: info[80:77] = num[3:0];
						3'b010: if(num[3:0] < 4'h3 && info[88:85] < 4'h4)info[84:81] = num[3:0];
						3'b011: begin 
									if(info[84:81] != 4'h2) info[88:85] = num[3:0];
									else if(num[3:0] < 4'h4)info[88:85] = num[3:0];
								  end
						3'b100: if(num[3:0] < 4'h6)info[92:89] = num[3:0];
						3'b101: info[96:93] = num[3:0];				
					endcase
					end
					
				end
				
				if(num == 5'h1B)begin in=0; posiH = 3'b000; end
				
				if(in == 0 && num == 5'h1A)begin
					
					if(posi==2'b11)begin
					state = 3; 
					RST = 0;
					end else if(posi == 2'b00) state = 1;
					
					posi = 0; posiH = 0;
				end
				end
				
	RFID1: 	begin
					RST = 1;
					if(num == 5'h1b) state = 2;					
					info[128:97] = tag[31:0];
					in = done;
					
						if(in == 1)begin
						contador = contador + 1;
							if(contador == 'd50_000) begin 
							state = 0; 
							contador = 0;
							in = 0;
							end
						end
						
				end
				
	RFID2:	begin
					RST = 1;
					if(num == 5'h1b) state = 0;	
					
					if(done)begin
						case(tag)
							Usuarios[128:97]:  begin user = 4'h0; state = 1; in = 0; validate = 1; info[128:97] = tag[31:0];end
							Usuarios[257:226]: begin user = 4'h1; state = 1; in = 0; validate = 1; info[128:97] = tag[31:0];end
							Usuarios[386:355]: begin user = 4'h2; state = 1; in = 0; validate = 1; info[128:97] = tag[31:0];end
							Usuarios[514:483]: begin user = 4'h3; state = 1; in = 0; validate = 1; info[128:97] = tag[31:0];end
							default: begin
								in = 1;
								RST = 0;
							end
						endcase
					end
				end
endcase
case(user)
	4'h0: Usuarios[128:0]   = info;
	4'h1: Usuarios[257:129] = info;
	4'h2: Usuarios[386:258] = info;
	4'h3: Usuarios[514:387] = info;
endcase
end	

endmodule