

module extender import riscv_pkg::*; (
    input  logic [24:0] e_a,
    input  imm_src_e      e_cd, 
    output logic [XLEN-1:0] e_rd
);

  always_comb begin
      casez (e_cd)
          IMM_I:   e_rd = {{20{e_a[24]}}, e_a[24:13]};
          IMM_J:   e_rd = {{11{e_a[24]}}, e_a[24], e_a[12:5], e_a[13], e_a[23:14], 1'b0};
          IMM_U:   e_rd = {e_a[24:5], 12'b0};
          IMM_S:   e_rd = {{20{e_a[24]}}, e_a[24:18], e_a[4:0]};
          IMM_B:   e_rd = {{19{e_a[24]}}, e_a[24], e_a[0], e_a[23:18], e_a[4:1], 1'b0};
          default: e_rd = '0;
      endcase
  end

endmodule


