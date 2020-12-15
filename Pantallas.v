module Pantallas(clk, DATOS, state, Usuarios, user, posi, posiH, in, validate, tiempo);
input clk;
input [2:0]state;
input [128:0]Usuarios;
input [3:0]user;
output reg [719:0]DATOS;
input validate;
input [1:0]posi;
input [2:0]posiH;
input in;
input [15:0]tiempo;

reg [3:0]x;
reg [3:0]shift;

parameter MenuPrin = 0;
parameter NewUser1 = 1;
parameter NewUser2 = 2;
parameter RFID1    = 3; 
parameter RFID2    = 4;


always@(posedge clk)begin
case(state)

	MenuPrin:	begin
						//Line 4
						DATOS[8:0]    =9'h120;//	    
						DATOS[17:9]   =9'h120;//   
						DATOS[26:18]  =9'h120;//   
						DATOS[35:27]  =9'h120;//		
						DATOS[44:36]  =9'h120;//   
						DATOS[53:45]  =9'h120;//  
						DATOS[62:54]  =9'h150;//P
						DATOS[71:63]  =9'h149;//I 
						DATOS[80:72]  =9'h14C;//L
						DATOS[89:81]  =9'h14C;//L
						DATOS[98:90]  =9'h120;//
						DATOS[109:99] =9'h14F;//O
						DATOS[116:108]=9'h155;//U
						DATOS[125:117]=9'h154;//T
						DATOS[134:126]=9'h120;//
						DATOS[143:135]=9'h120;//
						DATOS[152:144]=9'h120;//
						DATOS[161:153]=9'h120;//
						DATOS[170:162]=9'h120;//
						DATOS[179:171]=9'h120;//
						 
						//Line 3
						DATOS[188:180]=9'h120;
						DATOS[197:189]=9'h131;//1
						DATOS[206:198]=9'h12E;//.
						DATOS[215:207]=9'h14E;//N
						DATOS[224:216]=9'h175;//u
						DATOS[233:225]=9'h165;//e
						DATOS[242:234]=9'h176;//v
						DATOS[251:243]=9'h16F;//o
						DATOS[260:252]=9'h120;
						DATOS[269:261]=9'h120;				
						DATOS[278:270]=9'h120;
						DATOS[287:279]=9'h132;//2
						DATOS[296:288]=9'h12E;//.
						DATOS[305:297]=9'h145;//E
						DATOS[314:306]=9'h164;//d
						DATOS[323:315]=9'h169;//i
						DATOS[332:324]=9'h174;//t
						DATOS[341:333]=9'h161;//a
						DATOS[350:342]=9'h172;//r
						DATOS[359:351]=9'h120;
						
						
						//Line 2
						DATOS[368:360]=9'h120;
						DATOS[377:369]=9'h120;
						DATOS[386:378]=9'h175;//u
						DATOS[395:387]=9'h173;//s
						DATOS[404:396]=9'h175;//u
						DATOS[413:405]=9'h161;//a
						DATOS[422:414]=9'h172;//r
						DATOS[431:423]=9'h169;//i
						DATOS[440:432]=9'h16F;//o
						DATOS[449:441]=9'h120;
						DATOS[458:450]=9'h120;
						DATOS[467:459]=9'h120;
						DATOS[476:468]=9'h120;
						DATOS[485:477]=9'h120;
						DATOS[494:486]=9'h120;
						DATOS[503:495]=9'h120;
						DATOS[512:504]=9'h120;
						DATOS[521:513]=9'h120;
						DATOS[530:522]=9'h120;
						DATOS[539:531]=9'h120;
						
						//Line 1
						DATOS[548:540]=9'h120;//
						DATOS[557:549]=9'h120;//
						DATOS[566:558]=9'h120;//
						DATOS[575:567]=9'h120;//
						DATOS[584:576]=9'h120;//
						DATOS[593:585]=9'h148;//
						DATOS[602:594]=9'h16F;//
						DATOS[611:603]=9'h172;//
						DATOS[620:612]=9'h161;//
						DATOS[629:621]=9'h120;//
						DATOS[638:630]={5'h13, tiempo[15:12]};//H
						DATOS[647:639]={5'h13, tiempo[11:8]};//H
						DATOS[656:648]=9'h13A;//:
						DATOS[665:657]={5'h13, tiempo[7:4]};//M
						DATOS[674:666]={5'h13, tiempo[3:0]};//M
						DATOS[683:675]=9'h120;//
						DATOS[692:684]=9'h120;//
						DATOS[701:693]=9'h120;//
						DATOS[710:702]=9'h120;//
						DATOS[719:711]=9'h120;//
				end
				
				
	NewUser1:begin
				
						//Line 4
						DATOS[8:0]    =9'h155;//U
						DATOS[17:9]   =9'h173;//s
						DATOS[26:18]  =9'h175;//u
						DATOS[35:27]  =9'h161;//a
						DATOS[44:36]  =9'h172;//r
						DATOS[53:45]  =9'h169;//i
						DATOS[62:54]  =9'h16F;//o
						DATOS[71:63]  =9'h120;//
						DATOS[80:72]  ={5'h13, user[3:0]};// Numero de usuario
						DATOS[89:81]  =9'h120;//
						DATOS[98:90]  =9'h120;
	
						DATOS[125:117]=9'h120;

						DATOS[152:144]=9'h120;

						DATOS[179:171]=9'h120;
					
				
						
						DATOS[109:99] =9'h144;
						DATOS[116:108]=9'h144;
						DATOS[134:126]=9'h148;
						DATOS[143:135]=9'h148;
						DATOS[161:153]=9'h14D;
						DATOS[170:162]=9'h14D;	
						 
						//Line 3
						DATOS[188:180]=9'h120;
						DATOS[197:189]=9'h14D;//M
						DATOS[206:198]=9'h165;//e
						DATOS[215:207]=9'h164;//d
						DATOS[224:216]=9'h12E;//.
						DATOS[233:225]=9'h131;//1
						DATOS[242:234]=9'h120;
						DATOS[251:243]=9'h120;
						DATOS[260:252]=9'h120;
						DATOS[269:261]=9'h120;				
						DATOS[278:270]=9'h120;
						
						DATOS[287:279]={5'h13, Usuarios[4:1]};
						DATOS[296:288]={5'h13, Usuarios[8:5]};

						DATOS[305:297]=9'h13A; //:
						
						DATOS[314:306]={5'h13, Usuarios[12:9]};
						DATOS[323:315]={5'h13, Usuarios[16:13]};

						DATOS[332:324]=9'h13A; //:
						
						DATOS[341:333]={5'h13, Usuarios[20:17]};
						DATOS[350:342]={5'h13, Usuarios[24:21]};
						
						DATOS[359:351]=9'h120; 
						
						//Line 2						
						DATOS[368:360]=9'h120;
						DATOS[377:369]=9'h14D;//M
						DATOS[386:378]=9'h165;//e
						DATOS[395:387]=9'h164;//d
						DATOS[404:396]=9'h12E;//.
						DATOS[413:405]=9'h132;//2
						DATOS[422:414]=9'h120;
						DATOS[431:423]=9'h120;
						DATOS[440:432]=9'h120;
						DATOS[449:441]=9'h120;
						DATOS[458:450]=9'h120;
						
						DATOS[467:459]={5'h13, Usuarios[28:25]};
						DATOS[476:468]={5'h13, Usuarios[32:29]};
					
						DATOS[485:477]=9'h13A; //:
						
						DATOS[494:486]={5'h13, Usuarios[36:33]};
						DATOS[503:495]={5'h13, Usuarios[40:37]};

						DATOS[512:504]=9'h13A; //:
						
						DATOS[521:513]={5'h13, Usuarios[44:41]};
						DATOS[530:522]={5'h13, Usuarios[48:45]};
						
						DATOS[539:531]=9'h120; 
						
						
						//Line 1
						DATOS[548:540]=9'h120;
						DATOS[557:549]=9'h153;//S
						DATOS[566:558]=9'h169;//i
						DATOS[575:567]=9'h167;//g
						DATOS[584:576]=9'h12E;//.
						DATOS[593:585]=9'h150;//P
						DATOS[602:594]=9'h161;//a
						DATOS[611:603]=9'h167;//g
						DATOS[620:612]=9'h120;
						DATOS[629:621]=9'h120;
						DATOS[638:630]=9'h120;
						DATOS[647:639]=9'h143;//C
						DATOS[656:648]=9'h161;//a
						DATOS[665:657]=9'h16E;//n
						DATOS[674:666]=9'h163;//c
						DATOS[683:675]=9'h165;//e
						DATOS[692:684]=9'h16C;//l
						DATOS[701:693]=9'h161;//a
						DATOS[710:702]=9'h172;//r
						DATOS[719:711]=9'h120;
						
						
						//Posición
					if(posi == 2'b01)DATOS[188:180]=9'h12A;

					if(posi == 2'b10)DATOS[368:360]=9'h12A;
					
					if(posi == 2'b11)DATOS[548:540]=9'h12A;
					
					if(in)begin
						if(posiH == 3'b000) DATOS[109:99] =9'h121;//!												
						if(posiH == 3'b001) DATOS[116:108]=9'h121;//!			
						if(posiH == 3'b010) DATOS[134:126]=9'h121;//!
						if(posiH == 3'b011) DATOS[143:135]=9'h121;//!	
						if(posiH == 3'b100) DATOS[161:153]=9'h121;//!
						if(posiH == 3'b101) DATOS[170:162]=9'h121;//!
					end		
		

					if(validate == 1)begin
						DATOS[647:639]=9'h120;//
						DATOS[656:648]=9'h147;//G
						DATOS[665:657]=9'h175;//u
						DATOS[674:666]=9'h161;//a
						DATOS[683:675]=9'h172;//r
						DATOS[692:684]=9'h164;//d
						DATOS[701:693]=9'h161;//a
						DATOS[710:702]=9'h172;//r
						DATOS[719:711]=9'h120;//					
					end
				end
				
	NewUser2:begin
				
						//Line 4
						DATOS[8:0]    =9'h120;//
						DATOS[17:9]   =9'h150;//P
						DATOS[26:18]  =9'h161;//a
						DATOS[35:27]  =9'h167;//g
						DATOS[44:36]  =9'h12E;//.
						DATOS[53:45]  =9'h161;//a
						DATOS[62:54]  =9'h16E;//n
						DATOS[71:63]  =9'h174;//t
						DATOS[80:72]  =9'h120;// 
						DATOS[89:81]  =9'h120;//
						DATOS[98:90]  =9'h120;
	
						DATOS[125:117]=9'h120;

						DATOS[152:144]=9'h120;

						DATOS[179:171]=9'h120;
					
				
						
						DATOS[109:99] =9'h144;
						DATOS[116:108]=9'h144;
						DATOS[134:126]=9'h148;
						DATOS[143:135]=9'h148;
						DATOS[161:153]=9'h14D;
						DATOS[170:162]=9'h14D;	
						 
						//Line 3
						DATOS[188:180]=9'h120;
						DATOS[197:189]=9'h14D;//M
						DATOS[206:198]=9'h165;//e
						DATOS[215:207]=9'h164;//d
						DATOS[224:216]=9'h12E;//.
						DATOS[233:225]=9'h133;//3
						DATOS[242:234]=9'h120;
						DATOS[251:243]=9'h120;
						DATOS[260:252]=9'h120;
						DATOS[269:261]=9'h120;				
						DATOS[278:270]=9'h120;
						
						DATOS[287:279]={5'h13, Usuarios[52:49]};
						DATOS[296:288]={5'h13, Usuarios[56:53]};

						DATOS[305:297]=9'h13A; //:
						
						DATOS[314:306]={5'h13, Usuarios[60:57]};
						DATOS[323:315]={5'h13, Usuarios[64:61]};

						DATOS[332:324]=9'h13A; //:
						
						DATOS[341:333]={5'h13, Usuarios[68:65]};
						DATOS[350:342]={5'h13, Usuarios[72:69]};
						
						DATOS[359:351]=9'h120; 
						
						//Line 2						
						DATOS[368:360]=9'h120;
						DATOS[377:369]=9'h14D;//M
						DATOS[386:378]=9'h165;//e
						DATOS[395:387]=9'h164;//d
						DATOS[404:396]=9'h12E;//.
						DATOS[413:405]=9'h134;//4
						DATOS[422:414]=9'h120;
						DATOS[431:423]=9'h120;
						DATOS[440:432]=9'h120;
						DATOS[449:441]=9'h120;
						DATOS[458:450]=9'h120;
						
						DATOS[467:459]={5'h13, Usuarios[76:73]};
						DATOS[476:468]={5'h13, Usuarios[80:77]};
					
						DATOS[485:477]=9'h13A; //:
						
						DATOS[494:486]={5'h13, Usuarios[84:81]};
						DATOS[503:495]={5'h13, Usuarios[88:85]};

						DATOS[512:504]=9'h13A; //:
						
						DATOS[521:513]={5'h13, Usuarios[92:89]};
						DATOS[530:522]={5'h13, Usuarios[96:93]};
						
						DATOS[539:531]=9'h120; 
						
						
						//Line 1
						DATOS[548:540]=9'h120;
						DATOS[557:549]=9'h143;//C
						DATOS[566:558]=9'h16F;//o
						DATOS[575:567]=9'h16E;//n
						DATOS[584:576]=9'h166;//f
						DATOS[593:585]=9'h169;//i
						DATOS[602:594]=9'h172;//r
						DATOS[611:603]=9'h16D;//m
						DATOS[620:612]=9'h161;//a
						DATOS[629:621]=9'h172;//r
						DATOS[638:630]=9'h120;
						DATOS[647:639]=9'h143;//C
						DATOS[656:648]=9'h161;//a
						DATOS[665:657]=9'h16E;//n
						DATOS[674:666]=9'h163;//c
						DATOS[683:675]=9'h165;//e
						DATOS[692:684]=9'h16C;//l
						DATOS[701:693]=9'h161;//a
						DATOS[710:702]=9'h172;//r
						DATOS[719:711]=9'h120;
						
						
						//Posición
					if(posi == 2'b00)DATOS[8:0]=9'h12A;
					
					if(posi == 2'b01)DATOS[188:180]=9'h12A;

					if(posi == 2'b10)DATOS[368:360]=9'h12A;
					
					if(posi == 2'b11)DATOS[548:540]=9'h12A;
					
					if(in)begin
						if(posiH == 3'b000) DATOS[109:99] =9'h121;//!												
						if(posiH == 3'b001) DATOS[116:108]=9'h121;//!			
						if(posiH == 3'b010) DATOS[134:126]=9'h121;//!
						if(posiH == 3'b011) DATOS[143:135]=9'h121;//!	
						if(posiH == 3'b100) DATOS[161:153]=9'h121;//!
						if(posiH == 3'b101) DATOS[170:162]=9'h121;//!
					end

					
					if(validate == 1)begin
						DATOS[548:540]=9'h120;
						DATOS[557:549]=9'h120;//
						DATOS[566:558]=9'h120;//
						DATOS[575:567]=9'h120;//
						DATOS[584:576]=9'h120;//
						DATOS[593:585]=9'h120;//
						DATOS[602:594]=9'h120;//
						DATOS[611:603]=9'h120;//
						DATOS[620:612]=9'h120;//
						DATOS[629:621]=9'h120;//
						DATOS[638:630]=9'h120;
						DATOS[647:639]=9'h120;//
						DATOS[656:648]=9'h147;//G
						DATOS[665:657]=9'h175;//u
						DATOS[674:666]=9'h161;//a
						DATOS[683:675]=9'h172;//r
						DATOS[692:684]=9'h164;//d
						DATOS[701:693]=9'h161;//a
						DATOS[710:702]=9'h172;//r
						DATOS[719:711]=9'h120;//					
					end
				end
				
	RFID1:begin
							
						//Line 4
						DATOS[8:0]    =9'h155;//U
						DATOS[17:9]   =9'h173;//s
						DATOS[26:18]  =9'h175;//u
						DATOS[35:27]  =9'h161;//a
						DATOS[44:36]  =9'h172;//r
						DATOS[53:45]  =9'h169;//i
						DATOS[62:54]  =9'h16F;//o
						DATOS[71:63]  =9'h120;//
						DATOS[80:72]  ={5'h13, user[3:0]};// Numero de usuario
						DATOS[89:81]  =9'h120;//
						DATOS[98:90]  =9'h120;//  
						DATOS[109:99] =9'h120;//
						DATOS[116:108]=9'h120;//
						DATOS[125:117]=9'h156;//V
						DATOS[134:126]=9'h16F;//o
						DATOS[143:135]=9'h16C;//l
						DATOS[152:144]=9'h176;//v
						DATOS[161:153]=9'h165;//e
						DATOS[170:162]=9'h172;//r
						DATOS[179:171]=9'h120; 
						 
						 
						//Line 3
						DATOS[188:180]=9'h120;
						DATOS[197:189]=9'h150;//P
						DATOS[206:198]=9'h161;//a
						DATOS[215:207]=9'h173;//s
						DATOS[224:216]=9'h165;//e
						DATOS[233:225]=9'h120;//
						DATOS[242:234]=9'h16C;//l
						DATOS[251:243]=9'h161;//a
						DATOS[260:252]=9'h120;//
						DATOS[269:261]=9'h174;//t				
						DATOS[278:270]=9'h161;//a
						DATOS[287:279]=9'h172;//r
						DATOS[296:288]=9'h16A;//j
						DATOS[305:297]=9'h165;//e
						DATOS[314:306]=9'h174;//t
						DATOS[323:315]=9'h161;//a
						DATOS[332:324]=9'h120;
						DATOS[341:333]=9'h120;
						DATOS[350:342]=9'h120;
						DATOS[359:351]=9'h120;
						
						
						//Line 2
						DATOS[368:360]=9'h120;//
						DATOS[377:369]=9'h120;//
						DATOS[386:378]=9'h120;//
						DATOS[395:387]=9'h120;//
						DATOS[404:396]=9'h120;//
						DATOS[413:405]=9'h128;//(
						DATOS[422:414]=9'h128;//(
						DATOS[431:423]=9'h128;//(
						DATOS[440:432]=9'h128;//(
						DATOS[449:441]=9'h12D;//-
						DATOS[458:450]=9'h12D;//-
						DATOS[467:459]=9'h129;//)
						DATOS[476:468]=9'h129;//)
						DATOS[485:477]=9'h129;//)
						DATOS[494:486]=9'h129;//)
						DATOS[503:495]=9'h120;//
						DATOS[512:504]=9'h120;//
						DATOS[521:513]=9'h120;//
						DATOS[530:522]=9'h120;//
						DATOS[539:531]=9'h120;//
						
						//Line 1
						DATOS[548:540]=9'h120;//
						DATOS[557:549]=9'h149;//I
						DATOS[566:558]=9'h144;//D
						DATOS[575:567]=9'h13A;//:
						DATOS[584:576]=9'h120;
						DATOS[593:585]=9'h120;
						DATOS[602:594]=9'h120;
						DATOS[611:603]=9'h120;
						DATOS[620:612]=9'h120;
						DATOS[629:621]=9'h120;
						DATOS[638:630]=9'h120;
						DATOS[647:639]=9'h120;
						DATOS[656:648]=9'h120;
						DATOS[665:657]=9'h120;
						DATOS[674:666]=9'h120;
						DATOS[683:675]=9'h120;
						DATOS[692:684]=9'h120;
						DATOS[701:693]=9'h120;
						DATOS[710:702]=9'h120;
						DATOS[719:711]=9'h120;	
					
						
						
						if(in == 1)begin
						DATOS[197:189]=9'h147;//G
						DATOS[206:198]=9'h172;//r
						DATOS[215:207]=9'h161;//a
						DATOS[224:216]=9'h163;//c
						DATOS[233:225]=9'h169;//i
						DATOS[242:234]=9'h161;//a
						DATOS[251:243]=9'h173;//s
						DATOS[260:252]=9'h121;//!
						DATOS[269:261]=9'h120;//				
						DATOS[278:270]=9'h120;//
						DATOS[287:279]=9'h120;//
						DATOS[296:288]=9'h120;//
						DATOS[305:297]=9'h120;//
						DATOS[314:306]=9'h120;//
						DATOS[323:315]=9'h120;//
						
						
												//Sistema de conversión de números hexadecimales a valores ASCII del LCD
						if(Usuarios[100:97] > 4'h9)  begin x = 4'h4; shift = Usuarios[100:97]  - 9; end else begin x=4'h3; shift = Usuarios[100:97];  end	
						DATOS[584:576]={1'h1, x, shift};
						if(Usuarios[104:101] > 4'h9) begin x = 4'h4; shift = Usuarios[104:101] - 9; end else begin x=4'h3; shift = Usuarios[104:101]; end
						DATOS[593:585]={1'h1, x, shift}; 
						if(Usuarios[108:105] > 4'h9) begin x = 4'h4; shift = Usuarios[108:105] - 9; end else begin x=4'h3; shift = Usuarios[108:105]; end
						DATOS[602:594]={1'h1, x, shift};
						if(Usuarios[112:109] > 4'h9) begin x = 4'h4; shift = Usuarios[112:109] - 9; end else begin x=4'h3; shift = Usuarios[112:109]; end
						DATOS[611:603]={1'h1, x, shift}; 
						if(Usuarios[116:113] > 4'h9) begin x = 4'h4; shift = Usuarios[116:113] - 9; end else begin x=4'h3; shift = Usuarios[116:113]; end
						DATOS[620:612]={1'h1, x, shift};
						if(Usuarios[120:117] > 4'h9) begin x = 4'h4; shift = Usuarios[120:117] - 9; end else begin x=4'h3; shift = Usuarios[120:117]; end
						DATOS[629:621]={1'h1, x, shift};
						if(Usuarios[124:121] > 4'h9) begin x = 4'h4; shift = Usuarios[124:121] - 9; end else begin x=4'h3; shift = Usuarios[124:121]; end
						DATOS[638:630]={1'h1, x, shift};
						if(Usuarios[128:125] > 4'h9) begin x = 4'h4; shift = Usuarios[128:125] - 9; end else begin x=4'h3; shift = Usuarios[128:125]; end
						DATOS[647:639]={1'h1, x, shift}; 
						end
						
			end
			
	RFID2:begin
				//Line 4
				DATOS[8:0]    =9'h120;//	    
				DATOS[17:9]   =9'h120;//E
				DATOS[26:18]  =9'h120;//r
				DATOS[35:27]  =9'h120;//r
				DATOS[44:36]  =9'h120;//o
				DATOS[53:45]  =9'h120;//r
				DATOS[62:54]  =9'h120;//!
				DATOS[71:63]  =9'h120;//!
				DATOS[80:72]  =9'h120;//  
				DATOS[89:81]  =9'h120;//
				DATOS[98:90]  =9'h120;//  
				DATOS[109:99] =9'h120;//
				DATOS[116:108]=9'h120;//
				DATOS[125:117]=9'h156;//V
				DATOS[134:126]=9'h16F;//o
				DATOS[143:135]=9'h16C;//l
				DATOS[152:144]=9'h176;//v
				DATOS[161:153]=9'h165;//e
				DATOS[170:162]=9'h172;//r
				DATOS[179:171]=9'h120; 
				 
				 
				//Line 3
				DATOS[188:180]=9'h120;
				DATOS[197:189]=9'h150;//P
				DATOS[206:198]=9'h161;//a
				DATOS[215:207]=9'h173;//s
				DATOS[224:216]=9'h165;//e
				DATOS[233:225]=9'h120;//
				DATOS[242:234]=9'h16C;//l
				DATOS[251:243]=9'h161;//a
				DATOS[260:252]=9'h120;//
				DATOS[269:261]=9'h174;//t				
				DATOS[278:270]=9'h161;//a
				DATOS[287:279]=9'h172;//r
				DATOS[296:288]=9'h16A;//j
				DATOS[305:297]=9'h165;//e
				DATOS[314:306]=9'h174;//t
				DATOS[323:315]=9'h161;//a
				DATOS[332:324]=9'h120;
				DATOS[341:333]=9'h120;
				DATOS[350:342]=9'h120;
				DATOS[359:351]=9'h120;
				
				
				//Line 2
				DATOS[368:360]=9'h120;//
				DATOS[377:369]=9'h120;//
				DATOS[386:378]=9'h120;//
				DATOS[395:387]=9'h120;//
				DATOS[404:396]=9'h120;//
				DATOS[413:405]=9'h128;//(
				DATOS[422:414]=9'h128;//(
				DATOS[431:423]=9'h128;//(
				DATOS[440:432]=9'h128;//(
				DATOS[449:441]=9'h12D;//-
				DATOS[458:450]=9'h12D;//-
				DATOS[467:459]=9'h129;//)
				DATOS[476:468]=9'h129;//)
				DATOS[485:477]=9'h129;//)
				DATOS[494:486]=9'h129;//)
				DATOS[503:495]=9'h120;//
				DATOS[512:504]=9'h120;//
				DATOS[521:513]=9'h120;//
				DATOS[530:522]=9'h120;//
				DATOS[539:531]=9'h120;//
				
				//Line 1
				DATOS[548:540]=9'h120;
				DATOS[557:549]=9'h120;
				DATOS[566:558]=9'h120;
				DATOS[575:567]=9'h120;
				DATOS[584:576]=9'h120;
				DATOS[593:585]=9'h120;
				DATOS[602:594]=9'h120;
				DATOS[611:603]=9'h120;
				DATOS[620:612]=9'h120;
				DATOS[629:621]=9'h120;
				DATOS[638:630]=9'h120;
				DATOS[647:639]=9'h120;
				DATOS[656:648]=9'h120;
				DATOS[665:657]=9'h120;
				DATOS[674:666]=9'h120;
				DATOS[683:675]=9'h120;
				DATOS[692:684]=9'h120;
				DATOS[701:693]=9'h120;
				DATOS[710:702]=9'h120;
				DATOS[719:711]=9'h120;	
				
				if(in == 1)begin
				DATOS[17:9]   =9'h145;//E
				DATOS[26:18]  =9'h172;//r
				DATOS[35:27]  =9'h172;//r
				DATOS[44:36]  =9'h16F;//o
				DATOS[53:45]  =9'h172;//r
				DATOS[62:54]  =9'h121;//!
				DATOS[71:63]  =9'h121;//!
				end
			end
				
endcase
end
endmodule