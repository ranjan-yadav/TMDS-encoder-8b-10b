module tmds_encoder(disp_ena,control,d_in,clk,q_out);
input disp_ena;
input [1:0]control;
input [7:0]d_in;
input clk;
output reg [9:0]q_out;

reg [3:0]i;
reg [2:0]counter1=0;
reg [2:0]counter0=0;
reg [8:0]q_m;
reg [3:0]counter2=0;
reg [3:0]counter3=0;
reg [3:0]diff_q_m=0;
reg [31:0]disparity=0;

always @(posedge clk)
begin

	for(i=0;i<8;i=i+1)
		begin
			if(d_in[i]==1)
				begin
					counter1=counter1+1;
				end
			else
				begin
					counter0=counter0+1;
				end
		end
		
		disparity=counter1-counter0; ////////running disparity
		
	if((counter1>4)||((counter1==4)&&(d_in[0]==0)))
	begin
		q_m[0]=d_in[0];
		q_m[1]=~(d_in[1]^q_m[0]);
		q_m[2]=~(d_in[2]^q_m[1]);
		q_m[3]=~(d_in[3]^q_m[2]);
		q_m[4]=~(d_in[4]^q_m[3]);
		q_m[5]=~(d_in[5]^q_m[4]);
		q_m[6]=~(d_in[6]^q_m[5]);
		q_m[7]=~(d_in[7]^q_m[6]);
		q_m[8]=1'b0;
	end
	
	else
	begin
		q_m[0]=d_in[0];
		q_m[1]=(d_in[1]^q_m[0]);
		q_m[2]=(d_in[2]^q_m[1]);
		q_m[3]=(d_in[3]^q_m[2]);
		q_m[4]=(d_in[4]^q_m[3]);
		q_m[5]=(d_in[5]^q_m[4]);
		q_m[6]=(d_in[6]^q_m[5]);
		q_m[7]=(d_in[7]^q_m[6]);
		q_m[8]=1'b1;
	end
	     $display("q_m is %b",q_m);
		 
	for(i=0;i<9;i=i+1)
		begin
			if(q_m[i]==1)
				begin
					counter2=counter2+1;
				end
			else
				begin
					counter3=counter3+1;
				end
		end
		
		diff_q_m=counter2-counter3; ///////diff_q_m
		
		
	if(disp_ena==0)
	begin
		case(control)
		2'b00: q_out=10'b1101010100;
		2'b01: q_out=10'b0010101011;
		2'b10: q_out=10'b0101010100;
		2'b11: q_out=10'b1010101011;
		endcase
		disparity=3'b0;
	end
	
	else
	begin
			if((disparity==0)||(counter1==4))
				begin
					if(q_m[8]==0)
						begin
							q_out[9]=1'b1;
							q_out[8]=1'b0;
							q_out[7]=~q_m[7];
							q_out[6]=~q_m[6];
							q_out[5]=~q_m[5];
							q_out[4]=~q_m[4];
							q_out[3]=~q_m[3];
							q_out[2]=~q_m[2];
							q_out[1]=~q_m[1];
							q_out[0]=~q_m[0];
							disparity=disparity-diff_q_m;
						end
					else
						begin
					        q_out[9]=1'b0;
							q_out[8]=1'b1;
							q_out[7]=q_m[7];
							q_out[6]=q_m[6];
							q_out[5]=q_m[5];
							q_out[4]=q_m[4];
							q_out[3]=q_m[3];
							q_out[2]=q_m[2];
							q_out[1]=q_m[1];
							q_out[0]=q_m[0];
							disparity=disparity+diff_q_m;
						end
				end
			
			else
				begin
					if(((disparity>0)&&(counter1>4))||((disparity<0)&&(counter1<4)))
						begin
							if(q_m[8]==0)
								begin
									q_out[9]=1'b1;
									q_out[8]=1'b0;
									q_out[7]=~q_m[7];
									q_out[6]=~q_m[6];
									q_out[5]=~q_m[5];
									q_out[4]=~q_m[4];
									q_out[3]=~q_m[3];
									q_out[2]=~q_m[2];
									q_out[1]=~q_m[1];
									q_out[0]=~q_m[0];
									disparity=disparity-diff_q_m;
								end
						   else
								begin
									q_out[9]=1'b1;
									q_out[8]=1'b1;
									q_out[7]=~q_m[7];
									q_out[6]=~q_m[6];
									q_out[5]=~q_m[5];
									q_out[4]=~q_m[4];
									q_out[3]=~q_m[3];
									q_out[2]=~q_m[2];
									q_out[1]=~q_m[1];
									q_out[0]=~q_m[0];
									disparity=disparity-diff_q_m+2;
								end
						end
				   else
						begin
							if(q_m[8]==0)
								begin
									q_out[9]=1'b0;
									q_out[8]=1'b0;
									q_out[7]=q_m[7];
									q_out[6]=q_m[6];
									q_out[5]=q_m[5];
									q_out[4]=q_m[4];
									q_out[3]=q_m[3];
									q_out[2]=q_m[2];
									q_out[1]=q_m[1];
									q_out[0]=q_m[0];
									disparity=disparity+diff_q_m-2;
								end
						   else
								begin
									q_out[9]=1'b0;
									q_out[8]=1'b1;
									q_out[7]=q_m[7];
									q_out[6]=q_m[6];
									q_out[5]=q_m[5];
									q_out[4]=q_m[4];
									q_out[3]=q_m[3];
									q_out[2]=q_m[2];
									q_out[1]=q_m[1];
									q_out[0]=q_m[0];
									disparity=disparity+diff_q_m;
						       end
				     end
			end
	end
	
	counter0=0;
	counter1=0;
	counter2=0;
	counter3=0;
	q_m=0;
	//disparity=0;
	diff_q_m=0;
			
end
endmodule

