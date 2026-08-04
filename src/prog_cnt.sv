
module prog_cnt import riscv_pkg::*; (
    input logic [XLEN-1:0] prog_cnt_i,
    output logic [XLEN-1:0] prog_cnt_o
);

  always_comb
    prog_cnt_o = prog_cnt_i + 4;

endmodule
