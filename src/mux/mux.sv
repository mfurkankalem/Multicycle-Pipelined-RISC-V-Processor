module mux import riscv_pkg::*; (
  input logic [XLEN-1:0] a1, a2,
  input logic m_cd,  
  output logic [XLEN-1:0] m_rd
);
  always_comb begin
    if(m_cd==0)
      m_rd = a1;
    else
      m_rd = a2;
  end
endmodule
