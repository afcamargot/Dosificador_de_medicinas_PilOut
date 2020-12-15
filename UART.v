module UART(clk, clk10khz, RX, TX, RST, tag, done);
input clk;
input clk10khz;

//transferencia de datos
input RX;
input RST;
output reg TX;
output reg done;

//En tag se almacena el UID del RFID
output reg [0:31]tag = 0;

//Contadores
reg [4:0]contador = 0;
reg [4:0]delayTX=0;
reg [5:0]espacio = 0;

//Algunos estados
reg lector = 0;
reg empezar = 0;


//Divisor de frecuencia 25 veces mayor que la frecuencia a la que envía datos el arduino
wire baud;
DivFreq div1(clk, baud, 'd102);

//Proceso principal
always@(posedge baud)begin
contador = contador + 1;
delayTX = delayTX + 1;

	//Envía 1 por TX al arduino cuando se recibe la orden de leer el UID
	if(RST == 0 && lector == 0)begin
	lector = 1;
	delayTX = 0;
	TX = 1;
	done = 0;
	end

	//Deja de enviar 1 por TX despues de un corto periodo de tiempo
	if(delayTX == 'd31 && lector == 1)begin 
	TX = 0;
	end

	//Detecta cuando se recibe el bit de inicio y coloca a contador en 0 para saber en que parte del bit se esta leyendo
	if(RX == 0 && empezar == 0)begin
		empezar = 1;
		contador = 'd0;
	end

	//Cada 25 ciclos de reloj toma el dato que envía el arduino
	if(lector == 1 && empezar == 1 && contador == 'd25)begin
	contador='d0;
	tag[espacio]= RX;		
	espacio = espacio + 1;
	//Cuando espacio llega a 33 es porque se leyeron todos los datos que envía el arduino y se reinicia la maquina de estados
		if(espacio == 'd33) begin
		espacio = 0;
		empezar = 0;
		lector = 0;
		done = 1;
		end
	end
end

endmodule