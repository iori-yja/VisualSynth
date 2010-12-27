library verilog;
use verilog.vl_types.all;
entity musimixer is
    port(
        clk             : in     vl_logic;
        adr             : out    vl_logic_vector(7 downto 0);
        dat             : out    vl_logic_vector(7 downto 0)
    );
end musimixer;
