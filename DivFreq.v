module DivFreq(clk, newCLK, con);
//Entra el clk de 50 Mhz de la FPGA
input clk;
//Se ingresa el valor maximo del contador dependiendo de la frecuencia que se busca
//Se calcula de la forma con=50Mhz/(2*frecuencia nueva)
input [28:0]con;
//Salida de la nueva frecuencia
output reg newCLK = 0;

reg [28:0] contador = 0;

always @(posedge clk) begin
	//Cuenta hasta el valor de con
	contador = contador + 1'b1;
	if(contador== con) begin
	//Se reinicia el contador y se niega el valor del nuevo clock
	contador = 0;
	newCLK=!newCLK;
	end
end
endmodule