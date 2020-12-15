module    Reset_Delay(iCLK,oRESET, DONE, DATOS);
input        iCLK;
input DONE;
output reg    oRESET;
input [719:0] DATOS;

reg [719:0] shift_DATA;
reg [19:0]Cont = 0;

always@(posedge iCLK)
begin
    if(Cont!=20'hFFFFF)   //21ms
    begin
        Cont    =    Cont+1;
        oRESET    =    1'b0;
    end
    else begin
	 oRESET    =    1'b1;
	 end
	 if(DONE==1 && shift_DATA!=DATOS) Cont = 0;
	 shift_DATA = DATOS;
end

endmodule