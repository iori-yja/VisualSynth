library verilog;
use verilog.vl_types.all;
entity HexCounter is
    port(
        ck              : in     vl_logic;
        res             : in     vl_logic;
        Val             : out    vl_logic_vector(3 downto 0);
        enable          : in     vl_logic
    );
end HexCounter;
