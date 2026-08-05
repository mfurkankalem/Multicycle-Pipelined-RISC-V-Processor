module demux import riscv_pkg::*; (
  input logic [XLEN-1:0] a1,
  input logic d_cd,
  output logic [XLEN-1:0] rd1, rd2
);
  always_comb begin
    if (d_cd == 0) begin
      rd1 = a1;
      rd2 = '0;
    end else begin
      rd1 = '0;
      rd2 = a1;
    end
  end
endmodule
