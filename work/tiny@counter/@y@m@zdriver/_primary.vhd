library verilog;
use verilog.vl_types.all;
entity YMZdriver is
    port(
        clk             : in     vl_logic;
        A0              : out    vl_logic;
        cs              : out    vl_logic;
        data            : out    vl_logic_vector(7 downto 0)
    );
end YMZdriver;
