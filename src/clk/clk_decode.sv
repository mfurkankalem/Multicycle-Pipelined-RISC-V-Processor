
module clk_decode import riscv_pkg::*; (
  input  logic             clk,
  input  logic [XLEN-1:0]  inst_di, pc_di, pc_pdi,
  output logic [XLEN-1:0]  inst_do, pc_do, pc_pdo
);

  always_ff @(posedge clk) begin
    inst_do <= inst_di;
    pc_do <= pc_di;
    pc_pdo <= pc_pdi;
  end

endmodule
