module demux_2b import riscv_pkg::*; (
  input logic [XLEN-1:0] a1,
  input logic [1:0] d_cd,
  output logic [XLEN-1:0] rd1, rd2, rd3, rd4
);
  always_comb begin
    if (d_cd == 2'b00) begin
      rd1 = a1;  rd2 = '0;  rd3 = '0;  rd4 = '0;
    end else if (d_cd == 2'b01) begin
      rd1 = '0;  rd2 = a1;  rd3 = '0;  rd4 = '0;
    end else if (d_cd == 2'b10) begin
      rd1 = '0;  rd2 = '0;  rd3 = a1;  rd4 = '0;
    end else begin
      rd1 = '0;  rd2 = '0;  rd3 = '0;  rd4 = a1;
    end
  end
endmodule
