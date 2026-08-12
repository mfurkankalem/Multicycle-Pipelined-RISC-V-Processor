

module data_memory import riscv_pkg::*; (
    input logic clk, dm_cd,
    input logic [XLEN-1:0]  dm_a,
    input logic [XLEN-1:0]  dm_wd,
    input logic [6:0] op,
    input datam_e funct3, 
    output logic [XLEN-1:0]  data_dm [0:XLEN-1],
    output logic [XLEN-1:0]  dm_rd 
);
logic [1:0] remainder;

  always_comb begin
  remainder = 0;
    if(op==7'b0000011) begin
      casez (funct3) 
        default:  begin remainder = dm_a[1:0];
                  dm_rd = {{(XLEN-8){data_dm[(dm_a[4:0] & {3'b111, ~remainder})][remainder*8+7]}}, 
                  data_dm[(dm_a[4:0] & {3'b111, ~remainder})][remainder*8 +: 8]}; end
        P_H:      dm_rd = {{((XLEN/2)){data_dm[dm_a][(XLEN/2)-1]}},(data_dm[dm_a] [(XLEN/2)-1:0])};
        P_W:      dm_rd = data_dm[dm_a];
        P_BU:     begin remainder = dm_a[1:0];
                  dm_rd = {{(XLEN-8){1'b0}}, 
                  data_dm[(dm_a[4:0] & {3'b111, ~remainder})][remainder*8 +: 8]}; end
        P_HU:     dm_rd = {{(XLEN/2){1'b0}},(data_dm[dm_a] [(XLEN/2)-1:0])};
    endcase
    end 
    else begin
      dm_rd = 0;
    end
  end

  always @(negedge clk) begin
    if(op==7'b0100011) begin 
      data_dm[dm_a] <= dm_wd;
    end
  end

    

endmodule

