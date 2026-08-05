
module clk_decode import riscv_pkg::*; (
  input  logic             clk,
  input  logic [XLEN-1:0]  inst_di, pc_di, prog_cnt_di,
  output logic [XLEN-1:0]  inst_do, pc_do, prog_cnt_do
);

  always_ff @(posedge clk) begin
    inst_do <= inst_di;
    pc_do <= pc_di;
    prog_cnt_do <= prog_cnt_di;
  end

endmodule
