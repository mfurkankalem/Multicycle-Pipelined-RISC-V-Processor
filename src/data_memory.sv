

module data_memory import riscv_pkg::*; (
    input logic clk, dm_cd,
    input logic [XLEN-1:0]  dm_a,
    input logic [XLEN-1:0]  dm_wd,
    output logic [XLEN-1:0]  dm_rd 
);

logic [XLEN-1:0]  data [0:XLEN-1];            

assign dm_rd = data[dm_a];

  always @(negedge clk) begin
  
    if(dm_cd==1) begin
      data[dm_a] <= dm_wd;
    end
  end

    

endmodule

