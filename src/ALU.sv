

module ALU import riscv_pkg::*; (
    input  logic [XLEN-1:0] alu_a, alu_b,
    input  logic [3:0] alu_cd, 
    output logic [XLEN-1:0] alu_rd
);
logic found;
    always_comb begin
        case (alu_cd)
            ALU_ADD:    alu_rd = alu_a + alu_b;
            ALU_SUB:    alu_rd = alu_a - alu_b;
            ALU_AND:    alu_rd = alu_a & alu_b;
            ALU_OR:     alu_rd = alu_a | alu_b;
            ALU_XOR:    alu_rd = alu_a ^ alu_b;
            ALU_SLL:    alu_rd = alu_a << alu_b[4:0];
            ALU_SRL:    alu_rd = alu_a >> alu_b[4:0];
            ALU_SRA:    alu_rd = $signed(alu_a) >>> alu_b[4:0];
            ALU_SLT:    alu_rd = ($signed(alu_a) < $signed(alu_b)) ? 32'd1 : 32'd0;
            ALU_SLTU:   alu_rd = (alu_a < alu_b) ? 32'd1 : 32'd0;
            ALU_CLZ:    begin alu_rd = XLEN;
                        for (int i = XLEN-1; i >= 0; i--) begin
                            if (alu_a[i]) begin
                                alu_rd = XLEN-1 - i;
                                break;
                        end end end
                        
            default:    alu_rd = 'x;
        endcase
    end

endmodule


