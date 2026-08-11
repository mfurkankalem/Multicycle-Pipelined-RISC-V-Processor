module clk_memory import riscv_pkg::*; (
    input  logic             clk, en_m,
    input  ctrl_e            ctrl_bits_mi,
    input  logic [XLEN-1:0]  alu_rd_mi,
    r_rd2_mi, inst_mi, pc_mi, prog_cnt_mi,
    output ctrl_e            ctrl_bits_mo,
    output logic [XLEN-1:0]  alu_rd_mo, 
    r_rd2_mo, inst_mo, pc_mo, prog_mo
);

    always_ff @(posedge clk) begin
        if (en_m) begin
            ctrl_bits_mo   <= ctrl_bits_mi;
            alu_rd_mo      <= alu_rd_mi;
            r_rd2_mo       <= r_rd2_mi;
            inst_mo        <= inst_mi;
            pc_mo          <= pc_mi;
            prog_mo        <= prog_cnt_mi;
        end
    end

endmodule

