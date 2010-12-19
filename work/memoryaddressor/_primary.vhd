library verilog;
use verilog.vl_types.all;
entity memoryaddressor is
    port(
        Sig_En          : in     vl_logic;
        pclk            : in     vl_logic;
        WEb             : out    vl_logic;
        BLEb            : out    vl_logic;
        BHEb            : out    vl_logic;
        Address         : out    vl_logic_vector(15 downto 0)
    );
end memoryaddressor;
