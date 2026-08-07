module clk_memory import riscv_pkg::*; (
    input  logic             clk, en_m,
    input  ctrl_e            ctrl_bits_mi,
    input  logic [XLEN-1:0]  demux2_out1_mi, demux2_out2_mi, branch_rd_mi, 
    demux1_out2_mi, inst_mi, pc_mi, prog_cnt_mi,
    output ctrl_e            ctrl_bits_mo,
    output logic [XLEN-1:0]  demux2_out1_mo, demux2_out2_mo, branch_rd_mo, 
    demux1_out2_mo, inst_mo, pc_mo, prog_mo
);

    always_ff @(posedge clk) begin
        if (en_m) begin
            ctrl_bits_mo   <= ctrl_bits_mi;
            demux2_out1_mo <= demux2_out1_mi;
            demux2_out2_mo <= demux2_out2_mi;
            branch_rd_mo   <= branch_rd_mi;
            demux1_out2_mo <= demux1_out2_mi;
            inst_mo        <= inst_mi;
            pc_mo          <= pc_mi;
            prog_mo        <= prog_cnt_mi;
        end
    end

endmodule

