module mux_2b import riscv_pkg::*; (
  input logic [XLEN-1:0] a1, a2, a3, a4,
  input logic [1:0] m_cd,
  output logic [XLEN-1:0] m_rd
);
  always_comb begin
    if (m_cd == 2'b00)
      m_rd = a1;
    else if (m_cd == 2'b01)
      m_rd = a2;
    else if (m_cd == 2'b10)
      m_rd = a3;
    else
      m_rd = a4;
  end
endmodule
