module APB_Master #(
    parameter integer DATA_WIDTH=32,
    parameter integer ADDR_WIDTH=10,
    parameter integer NO_SLAVES=2,
    parameter integer BYTES_PER_WORD=DATA_WIDTH/8
) (
    input  wire                      pclk,
    input  wire                      preset_n,
    input  wire                      requester_transfer,
    input  wire [ADDR_WIDTH-1:0]     requester_address,
    input  wire [2:0]                requester_protection,
    input  wire [NO_SLAVES-1:0]      requester_select,
    input  wire                      requester_read_write,
    input  wire [DATA_WIDTH-1:0]     requester_write_data,
    input  wire [BYTES_PER_WORD-1:0] requester_strobe,
    input  wire                      pready,
    input  wire [DATA_WIDTH-1:0]     prdata,
    input  wire                      pslverr,
    output reg  [ADDR_WIDTH-1:0]     paddr,
    output reg  [2:0]                pprot,
    output reg  [NO_SLAVES-1:0]      psel,
    output reg                       penable,
    output reg                       pwrite,
    output reg  [DATA_WIDTH-1:0]     pwdata,
    output reg  [BYTES_PER_WORD-1:0] pstrb,
    output reg  [DATA_WIDTH-1:0]     slave_read_data,
    output reg                       slave_error,
    output reg                       slave_data_ready
);
    typedef enum logic [1:0] { IDLE, SETUP, ACCESS } state_e;
    state_e cs, ns;

    assign slave_data_ready = pready;
    assign slave_read_data  = prdata;
    assign slave_error      = pslverr;

    // Current state logic
    always @(posedge pclk) begin
        if (~preset_n) begin
            cs <= IDLE;
        end
        else begin
            cs <= ns;
        end
    end

    // Next state logic
    always_comb begin
        ns = cs;
        case (cs)
            IDLE: begin
                if (requester_transfer) begin
                    ns = SETUP;
                end
            end
            SETUP: begin
                ns = ACCESS;
            end
            ACCESS: begin
                if (pready) begin
                    ns = requester_transfer ? SETUP : IDLE;
                end
            end
            default: begin
                ns = IDLE;
            end
        endcase
    end

    // Data sampling
    always @(posedge pclk) begin
        if (~preset_n) begin
			paddr   <= 0;
			pprot   <= 0;
			psel    <= 0;
			penable <= 0;
			pwrite  <= 0;
            pwdata  <= 0;
			pstrb   <= 0;
        end
        else begin
            case (ns)
                IDLE: begin
                    psel    <= 0;
                    penable <= 0;
                end
                SETUP: begin
                    paddr   <= requester_address;
                    pprot   <= requester_protection;
                    psel    <= requester_select;
                    penable <= 0;
                    pwrite  <= requester_read_write;
                    pwdata  <= requester_write_data;
                    pstrb   <= requester_strobe;
                end
                ACCESS: begin
                    penable <= 1;
                end
                default: begin
                    paddr   <= 0;
                    pprot   <= 0;
                    psel    <= 0;
                    penable <= 0;
                    pwrite  <= 0;
                    pstrb   <= 0;
                end
            endcase
        end
    end
endmodule
