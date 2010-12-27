library verilog;
use verilog.vl_types.all;
entity WideCounter is
    port(
        ck              : in     vl_logic;
        res             : in     vl_logic;
        Val             : out    vl_logic_vector(15 downto 0);
        enable          : in     vl_logic
    );
end WideCounter;
