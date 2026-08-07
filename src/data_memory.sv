

module data_memory import riscv_pkg::*; (
    input logic clk, dm_cd,
    input logic [XLEN-1:0]  dm_a,
    input logic [XLEN-1:0]  dm_wd,
    output logic [XLEN-1:0]  data_dm [0:XLEN-1],
    output logic [XLEN-1:0]  dm_rd 
);

assign dm_rd = data_dm[dm_a];

  always @(negedge clk) begin
  
    if(dm_cd==1) begin
      data_dm[dm_a] <= dm_wd;
    end
  end

    

endmodule

