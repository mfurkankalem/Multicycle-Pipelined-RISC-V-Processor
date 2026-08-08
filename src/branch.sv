

module branch import riscv_pkg::*; (
    input  logic [XLEN-1:0] alu_rd, e_rd, program_counter,
    input  logic [6:0] op,
    input  logic [2:0] funct3, 
    input  logic rstn_i,
    output logic [XLEN-1:0] branch_rd
);
logic branch_taken;

always_comb begin
    branch_taken = 1'b0;
    case (funct3)
        3'b000: branch_taken = (alu_rd == 32'd0);        // BEQ
        3'b001: branch_taken = (alu_rd != 32'd0);        // BNE
        3'b100: branch_taken = (alu_rd == 32'd1);        // BLT
        3'b101: branch_taken = (alu_rd == 32'd0);        // BGE
        3'b110: branch_taken = (alu_rd == 32'd1);        // BLTU
        3'b111: branch_taken = (alu_rd == 32'd0);        // BGEU
        default: branch_taken = 1'b0;
    endcase

    if ((branch_taken && (op == 7'b1100011)) | (op == 7'b1100111) | (op == 7'b1101111)) begin
        if ($signed(e_rd) < 0)
            branch_rd = program_counter - 4 + ($signed(e_rd)); // hata olabilir
        else
            branch_rd = program_counter - 4 + e_rd;
    end 
    else begin
        branch_rd = program_counter;
    end


end

endmodule


