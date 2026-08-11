module clk_execute import riscv_pkg::*; (
    input  logic             clk, en_e, flush_e,
    input  ctrl_e            ctrl_bits_ei,
    input  logic [3:0]       alu_cd_ei,
    input  logic [XLEN-1:0]  r_rd1_ei, r_rd2_ei, e_rd_ei, inst_ei, pc_ei, prog_cnt_ei,
    output ctrl_e            ctrl_bits_eo,
    output logic [3:0]       alu_cd_eo,
    output logic [XLEN-1:0]  r_rd1_eo, r_rd2_eo, e_rd_eo, inst_eo, pc_eo, prog_cnt_eo
);
    always_ff @(posedge clk) begin
        if (en_e) begin
            if(!flush_e) begin
            ctrl_bits_eo <= ctrl_bits_ei;
            alu_cd_eo    <= alu_cd_ei;
            r_rd1_eo     <= r_rd1_ei;
            r_rd2_eo     <= r_rd2_ei;
            e_rd_eo      <= e_rd_ei;
            inst_eo      <= inst_ei;
            pc_eo        <= pc_ei;
            prog_cnt_eo  <= prog_cnt_ei;
            end else begin
            ctrl_bits_eo <= riscv_pkg::CTRL_NONE;
            alu_cd_eo    <= '0;
            r_rd1_eo     <= '0;
            r_rd2_eo     <= '0;
            e_rd_eo      <= '0;
            inst_eo      <= '0;
            pc_eo        <= '0;
            prog_cnt_eo  <= '0;
            end
        end
    end

endmodule

