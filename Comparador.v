module Comparador(clk, filas, columnas, numeros);
//Modulo que compara las columnas con las filas del teclado matricial
//El código esta pensado para que los botones solo entreguen 1 vez el valor
input [3:0]columnas;
input [3:0]filas;
input clk;
//Salida con el valor del teclado
//La salida es de 5 bits, el primero dice si la información del valor es util, los otros 4 son el número
//Esto con el fin de evitar tener un cero constante.
output reg [4:0]numeros;

//Registros
//Num guarda un valor provicional del teclado
reg [4:0]num;
//shift_num guarda el valor de num y luego lo compara
reg [4:0]shift_num;
//Env se utiliza para enviar o no el valor del teclado
reg env;
reg [13:0]delay;
initial begin
num = 0;
end


always @(posedge clk)
begin
//Se suma en 1 el delay y se deja env en 0
delay = delay + 1;
env = 0;

//Se comparan las filas con las columnas
case(columnas)
	4'b0001:
		case(filas)
		//Se guarda un valor provicional en num, si es el mismo que hay guardado en shift num, no se envía nada.
		//Si el valor es diferente, se guarda num en shit_num, se reinicia delay y se envía el valor del boton.
		4'b0001: begin num = 5'h11; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b0010: begin num = 5'h12; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b0100: begin num = 5'h13; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b1000: begin num = 5'h1A; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		endcase
	4'b0010:
		case(filas)
		4'b0001: begin num = 5'h14; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b0010: begin num = 5'h15; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b0100: begin num = 5'h16; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b1000: begin num = 5'h1B; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		endcase
	4'b0100:
		case(filas)
		4'b0001: begin num = 5'h17; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b0010: begin num = 5'h18; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b0100: begin num = 5'h19; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b1000: begin num = 5'h1C; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		endcase
	4'b1000:
		case(filas)
		4'b0001: begin num = 5'h1F; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b0010: begin num = 5'h10; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b0100: begin num = 5'h1E; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end
		4'b1000: begin num = 5'h1D; if(shift_num == num) env = 0; else begin shift_num = num; delay = 0; env = 1; end end 
		endcase	
endcase	

//despues de medio segundo (más de lo que duraria una pulsación normal de un boton),  shift_num se coloca en 0
if(delay == 'd5000) shift_num = 5'h00;
end

always@(posedge clk)begin
//Cuando env es 1, el valor guardado en shift_num se envía. De lo contrario la salida es 0.
if(env == 1) numeros = shift_num;
else numeros = 5'h00;
end
endmodule