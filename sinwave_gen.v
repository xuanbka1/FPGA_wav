module sinwave_gen(clock_50M,wav_data,dacclk,bclk,dacdat,myvalid);

/* tin hieu vao */
	input clock_50M;       
    input  [15:0]wav_data;
    input dacclk; 
	input bclk;	
	
/* tin hieu dau ra*/	
    output dacdat;
    
    output reg myvalid;
	 
	 reg dacdat;
    //reg dacclk;
    reg [11:0]dacclk_cnt;
    //reg bclk;
    reg [11:0]bclk_cnt;
	 
    reg [4:0]data_num;
    reg [15:0]sin_out;
   
   
    parameter CLOCK_REF=50000000;
    parameter CLOCK_SAMPLE=44100;
	 
   reg dacclk_a,dacclk_b;
	
   //dacclk phat hien qua trinh chuyen doi
   always@(posedge clock_50M )  
	begin
		dacclk_a<=dacclk;
		dacclk_b<=dacclk_a;
	end
	
   always@(posedge clock_50M )    
    begin
		if(dacclk_a!=dacclk_b)
         begin

				myvalid<=1'b1;      //dacclk nhay , doc RAM
				
         end
       else
			begin
				myvalid<=1'b0;

			end
     end  

	 
	// phat hien su thay doi cua clock bclk
   reg bclk_a,bclk_b;
     always@(posedge clock_50M ) 
	  begin
		bclk_a<=bclk;
		bclk_b<=bclk_a;
	  end
	  
    always@(posedge clock_50M )    
    begin
		if(dacclk_a!=dacclk_b)             //gui cac kenh ben trai va ben phai 16bit
			data_num<=31;
		else if(!bclk_a &&bclk_b)           //bclk suon xuong , thay doi du lieu        
			data_num<=data_num-1'b1;
	 end
			

			
  //posedge clock_50M
     always@(*) 
     begin
	     
        dacdat<=wav_data[data_num];     //DA chuyn doi tao ra du lieu ki thuat so
	  
     end
	 
endmodule

