module PWM(clk, servo1, servo2, med);
input clk;
input [3:0]med;
output reg servo1;
output reg servo2;

reg [21:0]contador = 0;
reg [1:0]state = 0;


always@(posedge clk)begin

	contador = contador + 1;
	if(contador =='d1_000_000) begin
	contador = 0;
	end
	
	
	case(med)
	
	4'h7: servo1 = (contador < 'd104166) ? 1:0;
	
	4'h8: servo1 = (contador < 'd48611) ? 1:0;
	
	4'h9: servo1 = (contador < 'd83333) ? 1:0;
	
	4'hC: servo1 = (contador < 'd104166) ? 1:0;
	
	default: servo1 = (contador < 'd62500) ? 1:0;
	
	endcase
end
endmodule