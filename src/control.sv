

module control import riscv_pkg::*; (
    input  logic [6:0] op,
    input  logic [2:0] funct3, 
    input logic [6:0] funct7,
    output  logic [2:0] e_cd,
    output  logic [3:0] alu_cd,
    output ctrl_e ctrl_bits
);
logic [16:0] casecode;
assign casecode = {op, funct3, funct7};

    localparam logic [16:0]
        P_   = 17'b0111111???????????,         
        
        // R-type
        P_ADD   = 17'b0110011_000_0000000,
        P_SUB   = 17'b0110011_000_0100000,
        P_AND   = 17'b0110011_111_0000000,
        P_OR    = 17'b0110011_110_0000000,
        P_XOR   = 17'b0110011_100_0000000,
        P_SLL   = 17'b0110011_001_0000000,
        P_SLT   = 17'b0110011_010_0000000,
        P_SLTU  = 17'b0110011_011_0000000,
        P_SRL   = 17'b0110011_101_0000000,
        P_SRA   = 17'b0110011_101_0100000,

        // I-type 
        P_ADDI  = 17'b0010011_000_???????,
        P_ORI   = 17'b0010011_110_???????,
        P_ANDI  = 17'b0010011_111_???????,
        P_XORI  = 17'b0010011_100_???????,
        P_SLTI  = 17'b0010011_010_???????,
        P_SLTIU = 17'b0010011_011_???????,
        P_SLLI  = 17'b0010011_001_0000000,
        P_SRLI  = 17'b0010011_101_0000000,
        P_SRAI  = 17'b0010011_101_0100000,

        // Load
        P_LB    = 17'b0000011_000_???????,    
        P_LH    = 17'b0000011_001_???????,     
        P_LW    = 17'b0000011_010_???????,
        P_LBU   = 17'b0000011_100_???????,     
        P_LHU   = 17'b0000011_101_???????,     

        // Store
        P_SB    = 17'b0100011_000_???????,     
        P_SH    = 17'b0100011_001_???????,     
        P_SW    = 17'b0100011_010_???????,

        // Branch
        P_BEQ   = 17'b1100011_000_???????,
        P_BNE   = 17'b1100011_001_???????,
        P_BLT   = 17'b1100011_100_???????,
        P_BGE   = 17'b1100011_101_???????,
        P_BLTU  = 17'b1100011_110_???????,
        P_BGEU  = 17'b1100011_111_???????,

        // Jump
        P_JALR  = 17'b1100111_000_???????,
        P_JAL   = 17'b1101111_???_???????,

        // U-type
        P_LUI   = 17'b0110111_???_???????,
        P_AUIPC = 17'b0010111_???_???????,

        // Misc-mem / system
        P_FENCE = 17'b0001111_000_???????,
        P_SYS   = 17'b1110011_000_0000000;  
        


    always_comb begin
        casez (casecode)
            // R-type
            P_ADD: begin
                alu_cd    = ALU_ADD;
                e_cd      = IMM_NONE;
                ctrl_bits = CTRL_REG_WRITE;
            end
            P_SUB: begin
                alu_cd    = ALU_SUB;
                e_cd      = IMM_NONE;
                ctrl_bits = CTRL_REG_WRITE;
            end
            P_AND: begin
                alu_cd    = ALU_AND;
                e_cd      = IMM_NONE;
                ctrl_bits = CTRL_REG_WRITE;
            end
            P_OR: begin
                alu_cd    = ALU_OR;
                e_cd      = IMM_NONE;
                ctrl_bits = CTRL_REG_WRITE;
            end
            P_XOR: begin
                alu_cd    = ALU_XOR;
                e_cd      = IMM_NONE;
                ctrl_bits = CTRL_REG_WRITE;
            end
            P_SLL: begin
                alu_cd    = ALU_SLL;
                e_cd      = IMM_NONE;
                ctrl_bits = CTRL_REG_WRITE;
            end
            P_SLT: begin
                alu_cd    = ALU_SLT;
                e_cd      = IMM_NONE;
                ctrl_bits = CTRL_REG_WRITE;
            end
            P_SLTU: begin
                alu_cd    = ALU_SLTU;
                e_cd      = IMM_NONE;
                ctrl_bits = CTRL_REG_WRITE;
            end
            P_SRL: begin
                alu_cd    = ALU_SRL;
                e_cd      = IMM_NONE;
                ctrl_bits = CTRL_REG_WRITE;
            end
            P_SRA: begin
                alu_cd    = ALU_SRA;
                e_cd      = IMM_NONE;
                ctrl_bits = CTRL_REG_WRITE;
            end

            // I-type 
            P_ADDI: begin
                alu_cd    = ALU_ADD;
                e_cd      = IMM_I;
                ctrl_bits = CTRL_REG_WRITE_I;
            end
            P_ORI: begin
                alu_cd    = ALU_OR;
                e_cd      = IMM_I;
                ctrl_bits = CTRL_REG_WRITE_I;
            end
            P_ANDI: begin
                alu_cd    = ALU_AND;
                e_cd      = IMM_I;
                ctrl_bits = CTRL_REG_WRITE_I;
            end
            P_XORI: begin
                alu_cd    = ALU_XOR;
                e_cd      = IMM_I;
                ctrl_bits = CTRL_REG_WRITE_I;
            end
            P_SLTI: begin
                alu_cd    = ALU_SLT;
                e_cd      = IMM_I;
                ctrl_bits = CTRL_REG_WRITE_I;
            end
            P_SLTIU: begin
                alu_cd    = ALU_SLTU;
                e_cd      = IMM_I;
                ctrl_bits = CTRL_REG_WRITE_I;
            end
            P_SLLI: begin
                alu_cd    = ALU_SLL;
                e_cd      = IMM_I;
                ctrl_bits = CTRL_REG_WRITE_I;
            end
            P_SRLI: begin
                alu_cd    = ALU_SRL;
                e_cd      = IMM_I;
                ctrl_bits = CTRL_REG_WRITE_I;
            end
            P_SRAI: begin
                alu_cd    = ALU_SRA;
                e_cd      = IMM_I;
                ctrl_bits = CTRL_REG_WRITE_I;
            end

            // Load
            P_LW: begin
                alu_cd = ALU_ADD;
                e_cd   = IMM_I;
                ctrl_bits = CTRL_LOAD;
            end
                                            //cache

            // Store
            P_SW: begin
                alu_cd = ALU_ADD;
                e_cd   = IMM_S;
                ctrl_bits = CTRL_STORE;
            end
                                            //cache
            
            // Branch
            P_BEQ: begin
                alu_cd    = ALU_SUB;
                e_cd      = IMM_B;
                ctrl_bits = CTRL_BRANCH;
            end
            P_BNE: begin
                alu_cd    = ALU_SUB;
                e_cd      = IMM_B;
                ctrl_bits = CTRL_BRANCH;
            end
            P_BLT: begin
                alu_cd    = ALU_SLT;
                e_cd      = IMM_B;
                ctrl_bits = CTRL_BRANCH;
            end
            P_BGE: begin
                alu_cd    = ALU_SLT;
                e_cd      = IMM_B;
                ctrl_bits = CTRL_BRANCH;
            end
            P_BLTU: begin
                alu_cd    = ALU_SLTU;
                e_cd      = IMM_B;
                ctrl_bits = CTRL_BRANCH;
            end
            P_BGEU: begin
                alu_cd    = ALU_SLTU;
                e_cd      = IMM_B;
                ctrl_bits = CTRL_BRANCH;
            end

            // Jump
            P_JAL: begin
                alu_cd    = ALU_NONE;
                e_cd      = IMM_J;
                ctrl_bits = CTRL_JUMP_LINK;
            end
            P_JALR: begin
                alu_cd    = ALU_ADD;
                e_cd      = IMM_I;
                ctrl_bits = CTRL_JALR;
            end

            // U-Type
            P_LUI: begin
                alu_cd    = ALU_ADD;
                e_cd      = IMM_U;
                ctrl_bits = CTRL_REG_WRITE_I;
            end
            P_AUIPC: begin
                alu_cd    = ALU_ADD;
                e_cd      = IMM_U;
                ctrl_bits = CTRL_AUIPC;
            end
            P_: begin
                alu_cd    = ALU_NONE;
                e_cd      = IMM_NONE;
                ctrl_bits = CTRL_NONE;
            end

            // Default
            default: begin
                alu_cd = ALU_NONE;
                e_cd   = IMM_NONE;
                ctrl_bits = CTRL_NONE;
            end
        endcase
    end


endmodule


