module TimingManager(input VSYNC, input HREF,input pclk,output reg Sig_En);
reg [7:0] line = 0;
reg [7:0] foo = 0;
reg res;
reg enC = 1'b0;
initial begin
	Sig_En <= 1'b1;
end
always @(posedge HREF or posedge VSYNC)begin
  if(HREF == 1'b1)line <= line +1'b1;
  else line = 8'h00;
  end
always @( posedge pclk&enC or posedge res&HREF)begin
  if(pclk&enC == 1'b1)foo <= foo +1'b1;
  else foo = 8'h00;
  end
always @(negedge pclk) begin
	if(line==8'h20 || line==8'h80 || line==8'hF0) begin
		enC<=1'b1;
	end
	else begin
		enC<=1'b0;
	end
	if(foo[6]==1'b1&&HREF==1'b1)begin
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
reg [15:0] preAddress = 16'h0000;
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
//	WideCounter w_count1(Sig_En,1'h0,preAddress,1'h1);
always @(posedge Sig_En)preAddress <= preAddress + 1'b1;
endmodule
/*
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
*/