
module clk_fetch import riscv_pkg::*; (
  input  logic             clk, en_f,
  input  logic             rstn_i,
  input  logic [XLEN-1:0]  pc_fi,
  output logic [XLEN-1:0]  pc_fo
);
logic startvalue;

  always_ff @(posedge clk) begin
    if (rstn_i) begin
      if(startvalue) begin
      if (en_f) pc_fo <= pc_fi;
      end
      else begin
      pc_fo <= INST_START;
      startvalue <= 1;
      end
    end else
      pc_fo <= 0;
  end

endmodule
