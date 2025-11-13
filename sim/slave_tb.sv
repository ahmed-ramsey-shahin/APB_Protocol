module slave_tb;
    parameter integer DATA_WIDTH=32;
    parameter integer ADDR_WIDTH=10;
    parameter integer BYTES_PER_WORD=DATA_WIDTH/8;

    bit                        pclk;
    logic                      preset_n;
    logic [ADDR_WIDTH-1:0]     paddr;
    logic [2:0]                pprot;
    logic                      psel;
    logic                      penable;
    logic                      pwrite;
    logic [DATA_WIDTH-1:0]     pwdata;
    logic [BYTES_PER_WORD-1:0] pstrb;
    logic                      slave_data_valid;
    logic [DATA_WIDTH-1:0]     slave_read_data;
    logic                      slave_error;
    logic [ADDR_WIDTH-1:0]     slave_address;
    logic [2:0]                slave_protection;
    logic                      slave_read_write;
    logic [DATA_WIDTH-1:0]     slave_write_data;
    logic [BYTES_PER_WORD-1:0] slave_strobe;
    logic                      pready;
    logic [DATA_WIDTH-1:0]     prdata;
    logic                      pslverr;
    logic                      master_data_ready;

    always #5 pclk = ~pclk;

    APB_Slave #(
		.DATA_WIDTH(DATA_WIDTH),
		.ADDR_WIDTH(ADDR_WIDTH)
    ) DUT (.*);

    initial begin
        preset_n         = 0;
        paddr            = 0;
        pprot            = 0;
        psel             = 0;
        penable          = 0;
        pwrite           = 0;
        pwdata           = 0;
        pstrb            = 0;
        slave_data_valid = 0;
        slave_read_data  = 0;
        slave_error      = 0;
        @(negedge pclk);
        preset_n         = 1;
        repeat(2) @(negedge pclk);
        // Testing started
        // Write trasnfer
        psel             = 1;
		paddr            = 10'd122;
		pprot            = 3'b110;
		pwrite           = 1;
		pwdata           = 32'd2772003;
		pstrb            = 4'b1111;
        @(negedge pclk);
        penable          = 1;
        repeat(4) @(negedge pclk);
        slave_data_valid = 1'b1;
        slave_error      = 1'b1;
        @(negedge pclk);
        penable          = 1'b0;
        psel             = 0;
        repeat(2) @(negedge pclk);
        // Read transfer
        psel             = 1;
		paddr            = 10'd125;
		pprot            = 3'b100;
		pwrite           = 0;
        @(negedge pclk);
        penable          = 1;
        slave_data_valid = 1;
        slave_read_data  = 32'd2772003;
        slave_error      = 1'b0;
        @(negedge pclk);
        penable          = 0;
        // Testing done
        repeat(2) @(negedge pclk);
        $stop();
    end
endmodule
