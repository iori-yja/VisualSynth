library verilog;
use verilog.vl_types.all;
entity ymzdriv is
    port(
        clk             : in     vl_logic;
        adr             : in     vl_logic_vector(7 downto 0);
        dat             : in     vl_logic_vector(11 downto 0);
        A0              : out    vl_logic;
        CS              : out    vl_logic;
        Line            : out    vl_logic_vector(7 downto 0)
    );
end ymzdriv;
