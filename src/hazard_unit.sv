

module hazard_unit import riscv_pkg::*; (
    input  logic clk, rstn_i,
    input logic [XLEN-1:0] inst_eo, inst_wo, inst_mo,
    input ctrl_e ctrl_bits_mo, ctrl_bits_wo,
    output logic en_f, en_d, en_e, en_m, en_w,
    output logic [1:0] forward_ae, forward_be
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

    always_ff begin
        if((inst_eo[19:15] == inst_mo[11:7]) & (ctrl_bits_mo[CTRLB_R] == 1) 
        & (inst_eo[19:15] != 0))
            forward_ae = 2'b10;
        else if((inst_eo[19:15] == inst_wo[11:7]) & (ctrl_bits_wo[CTRLB_R] == 1) 
        & (inst_eo[19:15] != 0))
            forward_ae = 2'b01;
        else
            forward_ae = 2'b00;
        if((inst_eo[24:20] == inst_mo[11:7]) & (ctrl_bits_mo[CTRLB_R] == 1) 
        & (inst_eo[19:15] != 0))
            forward_be = 2'b10;
        else if((inst_eo[24:20] == inst_wo[11:7]) & (ctrl_bits_wo[CTRLB_R] == 1) 
        & (inst_eo[19:15] != 0))
            forward_be = 2'b01;
        else
            forward_be = 2'b00;
    end

    assign en_f = en_shift[0];
    assign en_d = en_shift[1];
    assign en_e = en_shift[2]; 
    assign en_m = en_shift[3]; 
    assign en_w = en_shift[4]; 

endmodule


