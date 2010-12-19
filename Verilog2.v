module Counter(input ck,input res, output [7:0] Val,input enable);
reg [7:0] q;
initial q <= 0;
always @(posedge ck or posedge res) begin
	if( ck==1'b1 )
		q<=q+8'h1;
	else
		q<=8'h0;
end
assign Val = (enable) ? q : 8'b0;
endmodule

module MemoryaddrBridge(input VSYNC, input HREF,input pclk,output reg Sig_En,output reg enC, output[7:0] line, output [7:0] foo);
//module MemoryaddrBridge(input VSYNC, input HREF,input pclk,output reg Sig_En);
//wire [7:0] line,foo;
//reg res,enC;
reg res;
initial begin
	Sig_En <= 1'b1;
end
Counter HrefC (HREF, VSYNC, line[7:0],1'b1);
Counter PixC (pclk,res, foo[7:0],enC&HREF);
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

//module memoryaddressor(input Sig_En, input pclk, output CEb, output BLEb, output BHEb);
