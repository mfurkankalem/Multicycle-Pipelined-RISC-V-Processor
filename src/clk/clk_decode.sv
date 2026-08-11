
module clk_decode import riscv_pkg::*; (
  input  logic             clk, en_d, flush_d,
  input  logic [XLEN-1:0]  inst_di, pc_di, prog_cnt_di,
  output logic [XLEN-1:0]  inst_do, pc_do, prog_cnt_do
);

  always_ff @(posedge clk) begin
    if (en_d) begin
      if(!flush_d) begin
      inst_do <= inst_di;
      pc_do <= pc_di;
      prog_cnt_do <= prog_cnt_di;
      end else begin
      inst_do <= '0;
      pc_do <= '0;
      prog_cnt_do <= '0;
      end
    end
  end

endmodule
