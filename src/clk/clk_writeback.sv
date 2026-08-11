module clk_writeback import riscv_pkg::*; (
    input  logic             clk, en_w,
    input  ctrl_e            ctrl_bits_wi,
    input  logic [XLEN-1:0]  dm_rd_wi, alu_rd_wi,
                             inst_wi, pc_wi, prog_cnt_wi,
    output ctrl_e            ctrl_bits_wo,
    output logic [XLEN-1:0]  dm_rd_wo, alu_rd_wo,
                             inst_wo, pc_wo, prog_wo
);

    always_ff @(posedge clk) begin
        if (en_w) begin
            ctrl_bits_wo   <= ctrl_bits_wi;
            dm_rd_wo       <= dm_rd_wi;
            alu_rd_wo      <= alu_rd_wi;
            inst_wo        <= inst_wi;
            pc_wo          <= pc_wi;
            prog_wo        <= prog_cnt_wi;
        end
    end

endmodule
