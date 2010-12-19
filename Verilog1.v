module ByteCounter(input ck,input res, output [7:0] Val,input enable);
reg [7:0] q;
initial q <= 8'h0;
always @(posedge ck or posedge res) begin
	if( ck==1'b1 )
		q<=q+8'h1;
	else
		q<=8'h0;
end
assign Val = (enable) ? q : 8'b0;
endmodule

module tinyCounter(input ck,input res, output [1:0] Val,input enable);
reg [1:0] q;
initial q <= 2'h0;
always @(posedge ck or posedge res) begin
	if( ck==1'b1 )
		q<=q+2'h1;
	else
		q<=2'h0;
end
assign Val = (enable) ? q : 2'b0;
endmodule

module WideCounter(input ck,input res, output [15:0] Val,input enable);
reg [15:0] q ;
initial q <= 16'h0;
always @(posedge ck or posedge res) begin
	if( ck==1'b1 )
		q<=q+16'h1;
	else
		q<=16'h0;
end
assign Val = (enable) ? q : 16'b0;
endmodule
/////////////////////Counter is above. below is VirtualRAM field
//module MemoryaddrBridge(input VSYNC, input HREF,input pclk,output reg Sig_En,output reg enC, output[7:0] line, output [7:0] foo);
module TimingManager(input VSYNC, input HREF,input pclk,output reg Sig_En);
wire [7:0] line,foo;
reg res,enC;
initial begin
	Sig_En <= 1'b1;
end
ByteCounter HrefC (HREF, VSYNC, line[7:0],1'b1);
ByteCounter PixC (pclk,res, foo[7:0],enC&HREF);
	//always @(negedge VSYNC) begin
//	res<=1'b0;
//end
always @(negedge pclk) begin
	if(line==8'h20 || line==8'h80 || line==8'hF0) begin
		enC<=1'b1;
	end
	else begin
		enC<=1'b0;
	end
	if(foo[6]==1'b1)begin
		Sig_En<=1'b1;
		res<=1'b1;
	end
	else begin
		Sig_En<=1'b0;
		res<=1'b0;
	end
end
endmodule

module memoryaddressor(input Sig_En, input pclk, output  WEb, output reg BLEb, output reg BHEb, output [15:0] Address);
reg write_state = 0;
//wire state = 0;
//assign WEb = state | pclk;
wire [15:0] preAddress;
assign Address = (WEb) ? 16'hzzzz : preAddress ;

assign WEb = ((~Sig_En) & write_state) | pclk;

always@(posedge pclk)begin
		if(Sig_En==1'b1)begin
				write_state <= 1'b0;
		end
		else if(write_state==1'b0)begin
				write_state <= write_state + 1'b1;
		end
		else write_state<=write_state;
end

always @(Sig_En)begin
		BLEb <= (Sig_En) ? 1'b0 : 1'b1;
		BHEb <= (Sig_En) ? 1'b1 :1'b0;
	end
	WideCounter w_count1(Sig_En,1'h0,preAddress,1'h1);
endmodule

module clkdivider (input clk, output xclk);
	wire [1:0] t_count;
	tinyCounter t_Counter(clk, 1'b0, t_count, 1'b1);
	assign xclk = (t_count == 2'h3) ? 1'b1:1'b0;
endmodule
///////////////******************************MAIN(TOP CIRCCUIT)********************************/////////////////
module MemoryaddrBridge (input clk, input pclk,input HREF,input VSYNC, output xclk, output WEb, output BLEb,output BHEb, output [15:0] SRAM_address );
	wire Sig_En;
TimingManager timemanager(VSYNC, HREF, pclk,  Sig_En);
memoryaddressor menaddr(Sig_En,  pclk,   WEb, BLEb,   BHEb, SRAM_address);
clkdivider clkdivider0(clk,xclk);
endmodule
