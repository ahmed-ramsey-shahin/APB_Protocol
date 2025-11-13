module APB_Slave #(
    parameter integer DATA_WIDTH=32,
    parameter integer ADDR_WIDTH=10,
    parameter integer BYTES_PER_WORD=DATA_WIDTH/8
) (
    input  wire                      pclk,
    input  wire                      preset_n,
    input  wire [ADDR_WIDTH-1:0]     paddr,
    input  wire [2:0]                pprot,
    input  wire                      psel,
    input  wire                      penable,
    input  wire                      pwrite,
    input  wire [DATA_WIDTH-1:0]     pwdata,
    input  wire [BYTES_PER_WORD-1:0] pstrb,
    input  wire                      completer_data_valid,
    input  wire [DATA_WIDTH-1:0]     completer_read_data,
    input  wire                      completer_error,
    output reg  [ADDR_WIDTH-1:0]     slave_address,
    output reg  [2:0]                slave_protection,
    output reg                       slave_read_write,
    output reg  [DATA_WIDTH-1:0]     slave_write_data,
    output reg  [BYTES_PER_WORD-1:0] slave_strobe,
    output reg                       pready,
    output reg  [DATA_WIDTH-1:0]     prdata,
    output reg                       pslverr,
    output reg                       slave_data_ready
);
    always @(posedge pclk) begin
        if (~preset_n) begin
			slave_address     <= 0;
			slave_protection  <= 0;
			slave_read_write  <= 0;
			slave_write_data  <= 0;
			slave_strobe      <= 0;
			pready            <= 0;
			prdata            <= 0;
			pslverr           <= 0;
			slave_data_ready <= 0;
        end
        else begin
            if (psel && !penable) begin
                pready            <= 0;
                slave_data_ready <= 0;
            end
            else if (psel && penable) begin
                slave_address     <= paddr;
                slave_protection  <= pprot;
                slave_read_write  <= pwrite;
                slave_write_data  <= pwdata;
                slave_strobe      <= pstrb;
                slave_data_ready <= 1;
                if (completer_data_valid) begin
                    pready  <= 1;
                    pslverr <= completer_error;
                end
                if (!pwrite) begin
                    prdata  <= completer_read_data;
                end
            end
        end
    end
endmodule
