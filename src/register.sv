

module register import riscv_pkg::*; (
    input  logic clk, r_cd,
    input  logic [4:0]  r_a1,
    input  logic [4:0]  r_a2,
    input  logic [4:0]  r_a3,
    input  logic [XLEN-1:0] r_wd3,
    output logic [XLEN-1:0] r_rd1,
    output logic [XLEN-1:0] r_rd2
);

logic [XLEN-1:0] register [0:XLEN-1];

assign r_rd1 = register[r_a1];
assign r_rd2 = register[r_a2];

  always @(posedge clk) begin
  
    if(r_cd==1) begin
      if(r_a3==0)
        register[0] <= 0;
      else
      register[r_a3] <= r_wd3;
    end

  end
endmodule


