library verilog;
use verilog.vl_types.all;
entity MemoryaddrBridge is
    port(
        clk             : in     vl_logic;
        pclk            : in     vl_logic;
        HREF            : in     vl_logic;
        VSYNC           : in     vl_logic;
        xclk            : out    vl_logic;
        WEb             : out    vl_logic;
        BLEb            : out    vl_logic;
        BHEb            : out    vl_logic;
        SRAM_address    : out    vl_logic_vector(15 downto 0);
        Sig_En          : out    vl_logic
    );
end MemoryaddrBridge;
