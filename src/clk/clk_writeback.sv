module clk_writeback import riscv_pkg::*; (
    input  logic             clk, en_w,
    input  ctrl_e            ctrl_bits_wi,
    input  logic [XLEN-1:0]  branch_rd_wi, dm_rd_wi, demux2_out2_wi,
                             inst_wi, pc_wi, prog_cnt_wi,
    output ctrl_e            ctrl_bits_wo,
    output logic [XLEN-1:0]  branch_rd_wo, dm_rd_wo, demux2_out2_wo,
                             inst_wo, pc_wo, prog_wo
);

    always_ff @(posedge clk) begin
        if (en_w) begin
            ctrl_bits_wo   <= ctrl_bits_wi;
            branch_rd_wo   <= branch_rd_wi;
            dm_rd_wo       <= dm_rd_wi;
            demux2_out2_wo <= demux2_out2_wi;
            inst_wo        <= inst_wi;
            pc_wo          <= pc_wi;
            prog_wo        <= prog_cnt_wi;
        end
    end

endmodule
