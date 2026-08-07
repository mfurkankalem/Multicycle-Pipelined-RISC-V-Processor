
module clk_fetch import riscv_pkg::*; (
  input  logic             clk, en_f,
  input  logic             rstn_i,
  input  logic [XLEN-1:0]  pc_fi,
  output logic [XLEN-1:0]  pc_fo
);

  always_ff @(posedge clk) begin
    if (rstn_i) begin
      if (en_f) pc_fo <= pc_fi;
    end else
      pc_fo <= INST_START;
  end

endmodule
