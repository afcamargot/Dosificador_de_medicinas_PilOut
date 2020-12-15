module Barrido(clk, columnas);
//Modulo para el barrido de columnas para el teclado matricial
input clk;
output reg [3:0] columnas;

reg [1:0]selector;

initial begin
columnas = 0;
selector = 0;
end

always @(posedge clk)
begin
//Con un contador, envía una señal a cada una de las columnas una por una
selector = selector + 1; 

	case (selector)
		2'b00: begin columnas = 4'b0001; end
		2'b01: begin columnas = 4'b0010; end
		2'b10: begin columnas = 4'b0100; end
		2'b11: begin columnas = 4'b1000; end
		
		default:
		begin columnas = 4'b0000; end
	endcase
end
endmodule