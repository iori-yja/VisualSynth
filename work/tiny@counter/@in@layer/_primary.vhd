library verilog;
use verilog.vl_types.all;
entity InLayer is
    port(
        clk             : in     vl_logic;
        pclk            : in     vl_logic;
        Din             : in     vl_logic_vector(7 downto 0);
        Shoot           : in     vl_logic;
        Odd             : in     vl_logic;
        Req             : in     vl_logic;
        Greq            : in     vl_logic;
        Blreq           : in     vl_logic
    );
end InLayer;
