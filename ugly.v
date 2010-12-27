////////////////////////////////////////////////////////////////////////////////////
/*Signal Extraction Layer*/
module Sendbridge (
	input clk,
	input pclk,
	input [15:0]Pushin,
	input Req,
	input SIO
	);
endmodule
////////////////////////////////////////////////////
module InLayer (
	input clk,
	input pclk,
	input [7:0]Din,         //From TM
	input Shoot,
	input Odd,     //From TM
	input Req,            //From XL
	input Greq,
	input Blreq
	);
	wire Remp;
	wire Gemp;
	wire Bemp;
	wire [3:0]RedOt;
   wire [3:0]GreOt;
   wire [3:0]BluOt;
	wire Rful,
        Gful,
        Bful;
Queue	Queue_Red (
	.clock ( clk ),
	.data ( Odd ? Din[3:0] : 4'hz ),
	.rdreq ( Req ),
	.wrreq ( Shoot & Odd ),
	.empty ( Remp ),
	.full ( Rful ),
	.q ( RedOt[3:0] )
	);
Queue	Queue_Gre (
	.clock ( clk ),
	.data ( Odd ? 4'hz : Din[3:0] ),
	.rdreq ( Greq ),
	.wrreq ( Shoot & ~Odd ),
	.empty ( Gemp ),
	.full ( Gful ),
	.q ( GreOt[3:0] )
	);
Queue	Queue_Blu (
	.clock ( clk ),
	.data ( Odd ? 4'hz : Din[7:4] ),
	.rdreq ( Blreq	 ),
	.wrreq ( Shoot & ~Odd ),
	.empty ( Bemp ),
	.full ( Bful ),
	.q ( BluOt[3:0] )
	);

endmodule
/*
module ByteCounter(input ck,input res, output [7:0] Val,input enable);
reg [7:0] q;
initial q <= 8'h0;
always @(posedge ck or posedge res) begin
	if( ck==1'b1 )
		q<=q+8'h1;
	else
		q<=8'h0;
end
assign Val = (enable==1'b1) ? q : 8'b0;
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
endmodule*/
/*
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
*/