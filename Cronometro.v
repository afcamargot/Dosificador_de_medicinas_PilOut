module Cronometro(clk, tiempo);
input clk;//10khz
output reg [23:0] tiempo;

reg [3:0] seg1  = 0;
reg [3:0] seg2  = 0;
reg [3:0] min1  = 0;
reg [3:0] min2  = 0;
reg [3:0] hora1 = 0;
reg [3:0] hora2 = 0;
reg [3:0] dia1  = 0;
reg [3:0] dia2  = 0;


reg [13:0] contador = 0;


always @(posedge clk) begin
tiempo = {dia2, dia1, hora2, hora1, min2, min1};
contador = contador+1;

if(contador == 'd10_000)begin
		seg1 = seg1+1;
		contador = 0;
	end 
	if(seg1 == 4'b1010)begin
		seg1 = 0;
		seg2 = seg2+1;
	end 
	if(seg2 == 4'b0110)begin
		seg2 = 0;
		min1 = min1+1;
	end 
	if(min1 == 4'b1010)begin
		min1 = 0;
		min2 = min2+1;
	end 
	if(min2 == 4'b0110)begin
		min2 = 0;
		hora1 = hora1+1;
	end 
	if(hora1 == 4'b1010)begin
		hora1 = 0;
		hora2 = hora2+1;
	end 
	if(hora1 == 4'b0100 && hora2 == 4'b0010)begin
	hora1 = 0;
	hora2 = 0;
	dia1 = dia1 + 1;
	end
	if(dia1 == 4'b1010)begin
		dia1 = 0;
		dia2 = dia2+1;
	end 
	
	
end
endmodule