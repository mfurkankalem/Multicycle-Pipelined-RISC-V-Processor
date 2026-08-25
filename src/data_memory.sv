

module data_memory import riscv_pkg::*; (
    input logic clk,
    input logic [XLEN-1:0] dm_a,
    input logic [XLEN-1:0] dm_wd,
    input logic [6:0] op,
    input datam_e funct3,
    output logic [7:0] data_dm [0:XLEN-1],
    output logic [XLEN-1:0] dm_rd
);
    always_comb begin
        if(op==7'b0000011) begin
            casez (funct3)
                P_B: dm_rd = {{(XLEN-8){data_dm[dm_a][7]}}, data_dm[dm_a]};
                P_H: dm_rd = {{(XLEN-16){data_dm[dm_a+1][7]}}, data_dm[dm_a], data_dm[dm_a+1]};
                P_W: dm_rd = {data_dm[dm_a], data_dm[dm_a+1], data_dm[dm_a+2], data_dm[dm_a+3]};
                P_BU: dm_rd = {{(XLEN-8){1'b0}}, data_dm[dm_a]};
                P_HU: dm_rd = {{(XLEN-16){1'b0}}, data_dm[dm_a], data_dm[dm_a+1]};
                default: dm_rd = {{(XLEN-8){1'b0}}, data_dm[dm_a]};
            endcase
        end
        else begin
            dm_rd = 0;
        end
    end

    always @(negedge clk) begin
        if(op==7'b0100011) begin
            casez (funct3) 
                P_B: data_dm[dm_a] <= dm_wd[7:0];
                P_H: begin data_dm[dm_a] <= dm_wd[7:0]; data_dm[dm_a+1] <= dm_wd[15:8]; end
                P_W: begin data_dm[dm_a] <= dm_wd[7:0]; data_dm[dm_a+1] <= dm_wd[15:8];
                    data_dm[dm_a+2] <= dm_wd[23:16]; data_dm[dm_a+3] <= dm_wd[31:24];
                end
            endcase
        end
    end
endmodule

