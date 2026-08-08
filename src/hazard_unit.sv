

module hazard_unit import riscv_pkg::*; (
    input  logic clk, rstn_i,
    output logic en_f, en_d, en_e, en_m, en_w
);

logic [4:0] en_shift;

    always_ff @(posedge clk) begin
        if (rstn_i) begin
            if (en_shift == 5'b00000)  
            en_shift <= 5'b00011;
            else
            en_shift <= (en_shift << 1) | en_shift;
        end
        else
        en_shift <= 5'b00000;
    end

    assign en_f = en_shift[0];
    assign en_d = en_shift[1];
    assign en_e = en_shift[2]; 
    assign en_m = en_shift[3]; 
    assign en_w = en_shift[4]; 

endmodule


