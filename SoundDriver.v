module ymzdriv (
	input clk,
	input [7:0]adr,
	input [11:0]dat,
	output reg A0,
	output reg CS,
	output reg [7:0] Line
);
reg [11:0] array;
reg stat;
    always@(adr or dat)begin
        A0      <= 1'b0;
        stat    <= 1'b0;
        CS      <= 1'b1;
        Line    <= adr;
    end

    always@(negedge clk)begin
        if(A0==1'b0&&stat==1'b0)        stat <= 1'b1;
        else if(A0==1'b0&&stat==1'b1)begin
            if(CS==0) A0 <= 1'b1;
            CS <= ~CS;
        end
        else if(stat==1'b1)begin
            stat <= CS;
            CS   <= ~CS;
            Line <= dat;
        end
        else {A0, CS, Line} <= {10{1'bz}};
    end
endmodule

