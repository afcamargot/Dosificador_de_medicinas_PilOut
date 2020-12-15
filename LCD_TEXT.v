module    LCD_TEXT ( //Host Side
                    iCLK,iRST_N,
                    //LCD Side
                    LCD_DATA,LCD_RW,LCD_EN,LCD_RS,
						  DATOS, DONE);
//Host Side
input [719:0]DATOS;
input  iCLK,iRST_N;

//LCD Side
output [7:0] LCD_DATA;
output LCD_RW,LCD_EN,LCD_RS;
output reg DONE;

//Internal Wires/Registers
reg [6:0]  LUT_INDEX;
reg [8:0]  LUT_DATA;
reg [5:0]  mLCD_ST;
reg [17:0] mDLY;
reg        mLCD_Start;
reg [7:0]  mLCD_DATA;
reg        mLCD_RS;
wire       mLCD_Done;

parameter    LCD_INTIAL  = 0;
parameter    LCD_LINE1   = 5;
parameter    LCD_LINE2   = LCD_LINE1+20;
parameter    LCD_LINE3   = LCD_LINE1+40;
parameter    LCD_LINE4   = LCD_LINE1+60;
parameter    LUT_SIZE    = LCD_LINE1+80;

always@(posedge iCLK or negedge iRST_N)
begin
    if(!iRST_N)
    begin
        LUT_INDEX  = 0;
        mLCD_ST    = 0;
        mDLY       = 0;
        mLCD_Start = 0;
        mLCD_DATA  = 0;
        mLCD_RS    = 0;
		  DONE = 0;
    end
    else
    begin
        if(LUT_INDEX<LUT_SIZE)
        begin
            case(mLCD_ST)
            0:    begin
                    mLCD_DATA  = LUT_DATA[7:0];
                    mLCD_RS    = LUT_DATA[8];
                    mLCD_Start = 1;
                    mLCD_ST    = 1;
                end
            1:    begin
                    if(mLCD_Done)
                    begin
                    mLCD_Start = 0;
                    mLCD_ST    = 2;                   
                    end
                end
            2:    begin
                    if(mDLY < 18'h3FFFE) // 5.2ms  //18'h3FFE
                    mDLY = mDLY+1;
                    else
                    begin
                       mDLY    = 0;
                       mLCD_ST = 3;
                    end
                end
            3:    begin
                    LUT_INDEX  = LUT_INDEX+1;
                    mLCD_ST    = 0;
                end
            endcase
        end
		  else DONE = 1;
    end
end

always

begin
    case(LUT_INDEX)
    //Initial
    LCD_INTIAL+0:    LUT_DATA    =    9'h038; //Fun set
    LCD_INTIAL+1:    LUT_DATA    =    9'h00C; //dis on
    LCD_INTIAL+2:    LUT_DATA    =    9'h001; //clr dis
    LCD_INTIAL+3:    LUT_DATA    =    9'h006; //Ent mode
    LCD_INTIAL+4:    LUT_DATA    =    9'h080; //set ddram address
    
	 //Line 1
    LCD_LINE1+0:     LUT_DATA    =    DATOS[8:0];	    
    LCD_LINE1+1:     LUT_DATA    =    DATOS[17:9];   
    LCD_LINE1+2:     LUT_DATA    =    DATOS[26:18];   
    LCD_LINE1+3:     LUT_DATA    =    DATOS[35:27];   
    LCD_LINE1+4:     LUT_DATA    =    DATOS[44:36];   
    LCD_LINE1+5:     LUT_DATA    =    DATOS[53:45];  
    LCD_LINE1+6:     LUT_DATA    =    DATOS[62:54];  
    LCD_LINE1+7:     LUT_DATA    =    DATOS[71:63];   
    LCD_LINE1+8:     LUT_DATA    =    DATOS[80:72];   
    LCD_LINE1+9:     LUT_DATA    =    DATOS[89:81];   
    LCD_LINE1+10:    LUT_DATA    =    DATOS[98:90];  
    LCD_LINE1+11:    LUT_DATA    =    DATOS[109:99];
    LCD_LINE1+12:    LUT_DATA    =    DATOS[116:108];
    LCD_LINE1+13:    LUT_DATA    =    DATOS[125:117];
    LCD_LINE1+14:    LUT_DATA    =    DATOS[134:126];
    LCD_LINE1+15:    LUT_DATA    =    DATOS[143:135];
	 LCD_LINE1+16:    LUT_DATA    =    DATOS[152:144];
	 LCD_LINE1+17:    LUT_DATA    =    DATOS[161:153];
    LCD_LINE1+18:    LUT_DATA    =    DATOS[170:162];
    LCD_LINE1+19:    LUT_DATA    =    DATOS[179:171]; 
    
	 //Line 2
    LCD_LINE3+0:     LUT_DATA    =    DATOS[188:180]; // a
    LCD_LINE3+1:     LUT_DATA    =    DATOS[197:189]; // q
    LCD_LINE3+2:     LUT_DATA    =    DATOS[206:198]; // u
    LCD_LINE3+3:     LUT_DATA    =    DATOS[215:207]; // i
    LCD_LINE3+4:     LUT_DATA    =    DATOS[224:216]; // h
    LCD_LINE3+5:     LUT_DATA    =    DATOS[233:225]; // a
    LCD_LINE3+6:     LUT_DATA    =    DATOS[242:234]; // y
    LCD_LINE3+7:     LUT_DATA    =    DATOS[251:243]; // a
    LCD_LINE3+8:     LUT_DATA    =    DATOS[260:252]; // p
    LCD_LINE3+9:    LUT_DATA    =    DATOS[269:261]; // u
    LCD_LINE3+10:    LUT_DATA    =    DATOS[278:270]; // n
    LCD_LINE3+11:    LUT_DATA    =    DATOS[287:279]; // t
    LCD_LINE3+12:    LUT_DATA    =    DATOS[296:288]; // e
    LCD_LINE3+13:    LUT_DATA    =    DATOS[305:297]; // s
    LCD_LINE3+14:    LUT_DATA    =    DATOS[314:306];
    LCD_LINE3+15:    LUT_DATA    =    DATOS[323:315];
	 LCD_LINE3+16:    LUT_DATA    =    DATOS[332:324]; //
	 LCD_LINE3+17:    LUT_DATA    =    DATOS[341:333]; // e
    LCD_LINE3+18:    LUT_DATA    =    DATOS[350:342]; // r
    LCD_LINE3+19:     LUT_DATA    =    DATOS[359:351]; // o
    
	 //Line 3
    LCD_LINE2+0:     LUT_DATA    =    DATOS[368:360]; // a
    LCD_LINE2+1:     LUT_DATA    =    DATOS[377:369]; // q
    LCD_LINE2+2:     LUT_DATA    =    DATOS[386:378]; // u
    LCD_LINE2+3:     LUT_DATA    =    DATOS[395:387]; // i
    LCD_LINE2+4:     LUT_DATA    =    DATOS[404:396]; // h
    LCD_LINE2+5:     LUT_DATA    =    DATOS[413:405]; // a
    LCD_LINE2+6:     LUT_DATA    =    DATOS[422:414]; // y
    LCD_LINE2+7:     LUT_DATA    =    DATOS[431:423]; // a
    LCD_LINE2+8:     LUT_DATA    =    DATOS[440:432]; // p
    LCD_LINE2+9:     LUT_DATA    =    DATOS[449:441]; // u
    LCD_LINE2+10:    LUT_DATA    =    DATOS[458:450]; // n
    LCD_LINE2+11:    LUT_DATA    =    DATOS[467:459]; // t
    LCD_LINE2+12:    LUT_DATA    =    DATOS[476:468]; // e
    LCD_LINE2+13:    LUT_DATA    =    DATOS[485:477]; // s
    LCD_LINE2+14:    LUT_DATA    =    DATOS[494:486];
    LCD_LINE2+15:    LUT_DATA    =    DATOS[503:495];
	 LCD_LINE2+16:    LUT_DATA    =    DATOS[512:504]; //
	 LCD_LINE2+17:    LUT_DATA    =    DATOS[521:513]; // e
    LCD_LINE2+18:    LUT_DATA    =    DATOS[530:522]; // r
    LCD_LINE2+19:    LUT_DATA    =    DATOS[539:531]; // o
	
	 //Line 4
    LCD_LINE4+0:     LUT_DATA    =    DATOS[548:540]; // a
    LCD_LINE4+1:     LUT_DATA    =    DATOS[557:549]; // q
    LCD_LINE4+2:     LUT_DATA    =    DATOS[566:558]; // u
    LCD_LINE4+3:     LUT_DATA    =    DATOS[575:567]; // i
    LCD_LINE4+4:     LUT_DATA    =    DATOS[584:576]; // h
    LCD_LINE4+5:     LUT_DATA    =    DATOS[593:585]; // a
    LCD_LINE4+6:     LUT_DATA    =    DATOS[602:594]; // y
    LCD_LINE4+7:     LUT_DATA    =    DATOS[611:603]; // a
    LCD_LINE4+8:     LUT_DATA    =    DATOS[620:612]; // p
    LCD_LINE4+9:     LUT_DATA    =    DATOS[629:621]; // u
    LCD_LINE4+10:    LUT_DATA    =    DATOS[638:630]; // n
    LCD_LINE4+11:    LUT_DATA    =    DATOS[647:639]; // t
    LCD_LINE4+12:    LUT_DATA    =    DATOS[656:648]; // e
    LCD_LINE4+13:    LUT_DATA    =    DATOS[665:657]; // s
    LCD_LINE4+14:    LUT_DATA    =    DATOS[674:666];
    LCD_LINE4+15:    LUT_DATA    =    DATOS[683:675];
	 LCD_LINE4+16:    LUT_DATA    =    DATOS[692:684]; //
	 LCD_LINE4+17:    LUT_DATA    =    DATOS[701:693]; // e
    LCD_LINE4+18:    LUT_DATA    =    DATOS[710:702]; // r
    LCD_LINE4+19:    LUT_DATA    =    DATOS[719:711]; // o

    default:         LUT_DATA    =    9'h000;
    endcase
end

LCD_Controller u0 ( //Host Side
                   .iDATA(mLCD_DATA),
                   .iRS(mLCD_RS),
                   .iStart(mLCD_Start),
                   .oDone(mLCD_Done),
                   .iCLK(iCLK),
                   .iRST_N(iRST_N),
                   //LCD Interface
                   .LCD_DATA(LCD_DATA),
                   .LCD_RW(LCD_RW),
                   .LCD_EN(LCD_EN),
                   .LCD_RS(LCD_RS));

endmodule