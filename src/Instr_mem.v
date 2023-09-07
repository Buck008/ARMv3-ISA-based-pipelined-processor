module Instr_mem(
	input wire	[31:0] 	PC,
	output wire	[31:0] 	Instr	
); 

	reg [31:0]  INSTR_MEM[0:127];
	/*
	initial begin
		$readmemh("instr_mem.txt", INSTR_MEM ); //you should write your own path here

	end
	*/
	integer i;


//斐波那契数列
initial begin
			INSTR_MEM[0] = 32'hE2000000; 
			INSTR_MEM[1] = 32'hE2801001; 
			INSTR_MEM[2] = 32'hE2804000; 
			INSTR_MEM[3] = 32'hE5840000; 
			INSTR_MEM[4] = 32'hE2844001; 
			INSTR_MEM[5] = 32'hE5841000; 
			INSTR_MEM[6] = 32'hE2844001; 
			INSTR_MEM[7] = 32'hE2805016; 
			INSTR_MEM[8] = 32'hE0812000; 
			INSTR_MEM[9] = 32'hE5842000; 
		   INSTR_MEM[10] = 32'hE2844001; 
		   INSTR_MEM[11] = 32'hE2810000; 
		   INSTR_MEM[12] = 32'hE2821000; 
		   INSTR_MEM[13] = 32'hE2555001; 
		   INSTR_MEM[14] = 32'h1AFFFFF8; 
			for(i = 15; i < 128; i = i+1) begin 
				INSTR_MEM[i] = 32'h0; 
			end
end


/*
	//Test_ADD_SUB_AND_ORR
initial begin
			INSTR_MEM[0] = 32'hE2000000; 
			INSTR_MEM[1] = 32'hE2801055; 
			INSTR_MEM[2] = 32'hE28020AA; 
			INSTR_MEM[3] = 32'hE0013002; 
			INSTR_MEM[4] = 32'hE2033000; 
			INSTR_MEM[5] = 32'hE1833001; 
			INSTR_MEM[6] = 32'hE1833002; 
			INSTR_MEM[7] = 32'hE201100C; 
			INSTR_MEM[8] = 32'hE382200F; 
			INSTR_MEM[9] = 32'hE2033000; 
		    INSTR_MEM[10] = 32'hE2022000; 
		    INSTR_MEM[11] = 32'hE2011000; 
		    INSTR_MEM[12] = 32'hE2811001; 
		    INSTR_MEM[13] = 32'hE2822002; 
		    INSTR_MEM[14] = 32'hE2833003; 
		    INSTR_MEM[15] = 32'hE0812002; 
		    INSTR_MEM[16] = 32'hE0823003; 
		    INSTR_MEM[17] = 32'hE2044000; 
		    INSTR_MEM[18] = 32'hE0444003; 
		    INSTR_MEM[19] = 32'hE244400C; 
			for(i = 20; i < 128; i = i+1) begin 
				INSTR_MEM[i] = 32'h0; 
			end
end
*/


/*
//Test LDR and STR
initial begin
			INSTR_MEM[0] = 32'hE2000000; 
			INSTR_MEM[1] = 32'hE5901001; 
			INSTR_MEM[2] = 32'hE5902002; 
			INSTR_MEM[3] = 32'hE5903003; 
			INSTR_MEM[4] = 32'hE5904004; 
			INSTR_MEM[5] = 32'hE5905005; 
			INSTR_MEM[6] = 32'hE5906006; 
			INSTR_MEM[7] = 32'hE5907007; 
			INSTR_MEM[8] = 32'hE5908008; 
			INSTR_MEM[9] = 32'hE5909009; 
		   INSTR_MEM[10] = 32'hE590A001; 
		   INSTR_MEM[11] = 32'hE590B002; 
		   INSTR_MEM[12] = 32'hE590C003; 
		   INSTR_MEM[13] = 32'hE590D004; 
		   INSTR_MEM[14] = 32'hE590E005; 
		   INSTR_MEM[15] = 32'hE580100E; 
		   INSTR_MEM[16] = 32'hE580200D; 
		   INSTR_MEM[17] = 32'hE580300C; 
		   INSTR_MEM[18] = 32'hE580400B; 
		   INSTR_MEM[19] = 32'hE580500A; 
		   INSTR_MEM[20] = 32'hE5806009; 
		   INSTR_MEM[21] = 32'hE5807008; 
		   INSTR_MEM[22] = 32'hE5808007; 
		   INSTR_MEM[23] = 32'hE5809006; 
		   INSTR_MEM[24] = 32'hE580A005; 
		   INSTR_MEM[25] = 32'hE580B004; 
		   INSTR_MEM[26] = 32'hE580C003; 
		   INSTR_MEM[27] = 32'hE580D002; 
		   INSTR_MEM[28] = 32'hE580E001; 
			for(i = 29; i < 128; i = i+1) begin 
				INSTR_MEM[i] = 32'h0; 
			end
end
*/

/*
//The content of the instr_mem.txt is based on your test ASM code, you can copy and paste the machine code to "instr_mem.txt" after it was generated from Keil
//OR you can copy it here, use “initial…” statement to initialize your instruction memory:
//
//like this:

    initial begin
			INSTR_MEM[0] = 32'hE2000000; 
			INSTR_MEM[1] = 32'hE5901001; 
			INSTR_MEM[2] = 32'hE5902002; 
			INSTR_MEM[3] = 32'hE5903003; 
			INSTR_MEM[4] = 32'hE5904004; 
			INSTR_MEM[5] = 32'hE28F5000; 
			INSTR_MEM[6] = 32'hE0816002; 
			INSTR_MEM[7] = 32'hE0437004; 
			INSTR_MEM[8] = 32'hE1861007; 
			INSTR_MEM[9] = 32'hE0063007; 
			INSTR_MEM[10] = 32'hE0468007; 
			INSTR_MEM[11] = 32'hE5808000; 
			INSTR_MEM[12] = 32'hE2800001; 
			INSTR_MEM[13] = 32'hE2555001; 
			INSTR_MEM[14] = 32'h1AFFFFF6; 
			INSTR_MEM[15] = 32'hE5909000; 
    end 
*/

/*
//Test NZCV
initial begin
			INSTR_MEM[0] = 32'hE2000000; 
			INSTR_MEM[1] = 32'hE0900000; 
			INSTR_MEM[2] = 32'hE2500001; 
			INSTR_MEM[3] = 32'hE5901001; 
			INSTR_MEM[4] = 32'hE2911001; 
			INSTR_MEM[5] = 32'hE5902002; 
			INSTR_MEM[6] = 32'hE2922001; 
			for(i = 7; i < 128; i = i+1) begin 
				INSTR_MEM[i] = 32'h0; 
			end
end
*/

/*
//Test Conditional executions
initial begin
			INSTR_MEM[0] = 32'hE2000000; 
			INSTR_MEM[1] = 32'hE2033000; 
			INSTR_MEM[2] = 32'hE2803001; 
			INSTR_MEM[3] = 32'hE5901000; 
			INSTR_MEM[4] = 32'hE2911001; 
			INSTR_MEM[5] = 32'h02833001; 
			INSTR_MEM[6] = 32'h22833001; 
			INSTR_MEM[7] = 32'h42833001; 
			INSTR_MEM[8] = 32'h62833001; 
			INSTR_MEM[9] = 32'h82833001; 
		   INSTR_MEM[10] = 32'hA2833001; 
		   INSTR_MEM[11] = 32'hC2833001; 
		   INSTR_MEM[12] = 32'hD2833001; 
		   INSTR_MEM[13] = 32'hD2933001; 
			for(i = 14; i < 128; i = i+1) begin 
				INSTR_MEM[i] = 32'h0; 
			end
end
*/

/*
//test YZS
initial begin
			INSTR_MEM[0] = 32'hE2000000; 
			INSTR_MEM[1] = 32'hE2011000; 
			INSTR_MEM[2] = 32'hE2022000; 
			INSTR_MEM[3] = 32'hE2033000; 
			INSTR_MEM[4] = 32'hE2044000; 
			INSTR_MEM[5] = 32'hE2055000; 
			INSTR_MEM[6] = 32'hE2066000; 
			INSTR_MEM[7] = 32'hE2077000; 
			INSTR_MEM[8] = 32'hE2088000; 
			INSTR_MEM[9] = 32'hE2099000; 
			INSTR_MEM[10] = 32'hE20AA000; 
			INSTR_MEM[11] = 32'hE5911004; 
			INSTR_MEM[12] = 32'hE7821003; 
			INSTR_MEM[13] = 32'hE2822002; 
			INSTR_MEM[14] = 32'hE0833001; 
			INSTR_MEM[15] = 32'hE2522001; 
			INSTR_MEM[16] = 32'h1AFFFFFC; 
			INSTR_MEM[17] = 32'hE7914001; 
			INSTR_MEM[18] = 32'hE0845004; 
			INSTR_MEM[19] = 32'hE0846004; 
			INSTR_MEM[20] = 32'hE0847004; 
			INSTR_MEM[21] = 32'hE0878007; 
			INSTR_MEM[22] = 32'hE0879007; 
			INSTR_MEM[23] = 32'hE087A007; 
			for(i = 24; i < 128; i = i+1) begin 
				INSTR_MEM[i] = 32'h0; 
			end
end
*/

/*
//Test data forwarding
initial begin
			INSTR_MEM[0] = 32'hE2000000; 
			INSTR_MEM[1] = 32'hE2801001; 
			INSTR_MEM[2] = 32'hE2802002; 
			INSTR_MEM[3] = 32'hE2803003; 
			for(i = 4; i < 128; i = i+1) begin 
				INSTR_MEM[i] = 32'h0; 
			end
end
*/

/*
//Test Memory-Memory copy
initial begin
			INSTR_MEM[0] = 32'hE2000000; 
			INSTR_MEM[1] = 32'hE5901000; 
			INSTR_MEM[2] = 32'hE5801001; 
			for(i = 3; i < 128; i = i+1) begin 
				INSTR_MEM[i] = 32'h0; 
			end
end
*/

/*
//Test Load and Use
initial begin
			INSTR_MEM[0] = 32'hE2000000; 
			INSTR_MEM[1] = 32'hE2022000; 
			INSTR_MEM[2] = 32'hE5901000; 
			INSTR_MEM[3] = 32'hE2812001; 
			INSTR_MEM[4] = 32'hE0802001; 
			INSTR_MEM[5] = 32'hE0812001; 
			for(i = 6; i < 128; i = i+1) begin 
				INSTR_MEM[i] = 32'h0; 
			end
end
*/

/*
//Test Early BIA
initial begin
			INSTR_MEM[0] = 32'hE2000000; 
			INSTR_MEM[1] = 32'hE2900005; 
			INSTR_MEM[2] = 32'hE2500001; 
			INSTR_MEM[3] = 32'h1AFFFFFD; 
			INSTR_MEM[4] = 32'hE2011000; 
			INSTR_MEM[5] = 32'hE2911005; 
			INSTR_MEM[6] = 32'h0A000001; 
			INSTR_MEM[7] = 32'hE2511001; 
			INSTR_MEM[8] = 32'hEAFFFFFC; 
			for(i = 9; i < 128; i = i+1) begin 
				INSTR_MEM[i] = 32'h0; 
			end
end
*/
	assign Instr = ( (PC >= 32'h00000000) & (PC <= 32'h000001FC) ) ? // To check if PC is in the valid range, assuming 128 word memory. 
                 INSTR_MEM[PC[8:2]] : 32'h00000000 ; 

endmodule