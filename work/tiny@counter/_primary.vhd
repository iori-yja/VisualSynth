library verilog;
use verilog.vl_types.all;
entity tinyCounter is
    port(
        ck              : in     vl_logic;
        res             : in     vl_logic;
        Val             : out    vl_logic_vector(1 downto 0);
        enable          : in     vl_logic
    );
end tinyCounter;
