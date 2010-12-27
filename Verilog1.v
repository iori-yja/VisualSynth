
/////////////////////Counter is above. below is InputHandleField field
//module MemoryaddrBridge(input VSYNC, input HREF,input pclk,output reg Sig_En,output reg enC, output[7:0] line, output [7:0] foo);

module clkdivider (input clk, output xclk);
	reg [1:0] t_count = 0;
	always@(posedge clk) t_count[0] <= ~t_count[0];
	always@(posedge t_count[0]) t_count[1] <= ~t_count[1];
	assign xclk = t_count[1];
endmodule

///////////////******************************MAIN(TOP CIRCCUIT)********************************/////////////////
module MemoryaddrBridge (input clk, input pclk,input HREF,input VSYNC, output xclk, output WEb, output BLEb,output BHEb, output [15:0] SRAM_address,output Sig_En );
//wire Sig_En;
//wire WEbpre;
//assign WEb = WEbpre | clk;
TimingManager timemanager(VSYNC, HREF, pclk, Sig_En);
memoryaddressor menaddr(Sig_En,  pclk, WEb,  BLEb, BHEb, SRAM_address);
clkdivider clkdivider0(clk,xclk);
//musimixesim:/TESTr musxer(clk, WEb, SRAM_address
endmodule
