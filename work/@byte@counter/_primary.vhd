library verilog;
use verilog.vl_types.all;
entity ByteCounter is
    port(
        ck              : in     vl_logic;
        res             : in     vl_logic;
        Val             : out    vl_logic_vector(7 downto 0);
        enable          : in     vl_logic
    );
end ByteCounter;
