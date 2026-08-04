
module clk_fetch import riscv_pkg::*; (
  input  logic             clk,
  input  logic             rstn_i,
  input  logic [XLEN-1:0]  pc_fi,
  output logic [XLEN-1:0]  pc_fo
);

  always_ff @(posedge clk) begin
    if (rstn_i)
      pc_fo <= pc_fi;
    else
      pc_fo <= 32'h80000000;
  end

endmodule
