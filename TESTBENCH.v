module TEST;
reg VSYNC;
reg HREF;
wire WEb;
wire BHEb;
wire BLEb;
wire pclk;
wire [15:0] SRAM_address;
reg clk;
wire xclk;
//wire [7:0] line,foo;
//wire CEb;
//wire [17:0] adr;
//wire pck;
assign pclk = ~xclk;
MemoryaddrBridge i1(clk,pclk,HREF,VSYNC,xclk,WEb,BLEb,BHEb,SRAM_address);
initial clk <= 1'b0;
initial HREF <= 1'b0;
initial VSYNC <= 1'b1;
initial #9408 VSYNC <= 0;

always begin
#1 clk <= ~clk;
end
always begin
  #576 HREF <= 1;
  #2560 HREF <= 0;
end
always begin
  #1589952 VSYNC <= 1;
  #9408 VSYNC <= 0;
end
initial $monitor($time, "addr=%h", SRAM_address);

endmodule
