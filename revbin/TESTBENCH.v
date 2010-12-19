module TEST;
reg VSYNC;
reg HREF;
wire WEb;
wire BHEb;
wire BLEb;
reg pclk;
wire [15:0] SRAM_address;
wire clk;
wire xclk;
//wire [7:0] line,foo;
//wire CEb;
//wire [17:0] adr;
//wire pck;
MemoryaddrBridge i1(clk,pclk,HREF,VSYNC,xclk,WEb,BHEb,BLEb,SRAM_address);

initial pclk <= 1'b0;
initial HREF <= 1'b0;
initial VSYNC <= 1'b1;
initial #9408 VSYNC <= 0;

always begin
#1 pclk <= ~pclk;
end
always begin
  #576 HREF <= 1;
  #2560 HREF <= 0;
end
always begin
  #1589952 VSYNC <= 1;
  #9408 VSYNC <= 0;
end
 initial  $monitor($time,"pclk=%b WEb=%b",pclk,WEb);
endmodule
