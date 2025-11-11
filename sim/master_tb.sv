module master_tb;
    parameter integer DATA_WIDTH=32;
    parameter integer ADDR_WIDTH=10;
    parameter integer NO_SLAVES=2;
    parameter integer BYTES_PER_WORD=DATA_WIDTH/8;

    bit                        pclk;
    logic                      preset_n;
    logic                      master_transfer;
    logic [ADDR_WIDTH-1:0]     master_address;
    logic [2:0]                master_protection;
    logic [NO_SLAVES-1:0]      master_select;
    logic                      master_read_write;
    logic [DATA_WIDTH-1:0]     master_write_data;
    logic [BYTES_PER_WORD-1:0] master_strobe;
    logic                      pready;
    logic [DATA_WIDTH-1:0]     prdata;
    logic                      pslverr;
    logic [ADDR_WIDTH-1:0]     paddr;
    logic [2:0]                pprot;
    logic [NO_SLAVES-1:0]      psel;
    logic                      penable;
    logic                      pwrite;
    logic [DATA_WIDTH-1:0]     pwdata;
    logic [BYTES_PER_WORD-1:0] pstrb;
    logic [DATA_WIDTH-1:0]     slave_read_data;
    logic                      slave_error;
    logic                      slave_data_ready;

    always #5 pclk = ~pclk;

    APB_Master #(
		.DATA_WIDTH(DATA_WIDTH),
		.ADDR_WIDTH(ADDR_WIDTH),
		.NO_SLAVES(NO_SLAVES)
    ) DUT (.*);

    initial begin
		preset_n          = 0;
		master_transfer   = 0;
		master_address    = 0;
		master_protection = 0;
		master_select     = 0;
		master_read_write = 0;
		master_write_data = 0;
		master_strobe     = 0;
		pready            = 0;
		prdata            = 0;
		pslverr           = 0;
        @(negedge pclk);
        preset_n          = 1;
        @(negedge pclk);
        // Testing started
        // Write with no wait states
        master_transfer   = 1;
        master_address    = 10'd125;
        master_protection = 3'b0001;
        master_select     = 2'b01;
        master_read_write = 1'b1;
        master_write_data = 32'd2772003;
        master_strobe     = 4'b1111;
        @(negedge pclk);
        master_transfer   = 1'b0;
        pready            = 1'b1;
        pslverr           = 1'b0;
        repeat(2) @(negedge pclk);
        // Write with wait states
        master_transfer   = 1;
        master_address    = 10'd126;
        master_protection = 3'b101;
        master_select     = 2'b10;
        master_read_write = 1'b0;
        master_strobe     = 4'b1111;
        pready            = 1'b0;
        @(negedge pclk);
        master_transfer   = 1'b0;
        repeat(3) @(negedge pclk);
        pready            = 1'b1;
        prdata            = 32'd1234;
        pslverr           = 1'b1;
        @(negedge pclk);
        // Testing done
        repeat(2) @(negedge pclk);
        $stop();
    end
endmodule
