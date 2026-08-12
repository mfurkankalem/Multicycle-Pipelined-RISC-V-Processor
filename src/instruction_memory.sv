//will be changed later


module instruction_memory import riscv_pkg::*; (
    input logic [XLEN-1:0] im_a,
    output logic [XLEN-1:0] im_rd 
);

    logic [XLEN-1:0]  inst [0:XLEN-1];    
    logic [XLEN-1:0] result;              
    
assign inst[0] = 32'h60001093; // clz  x1, x0
    assign inst[1] = 32'h7d000113; // addi x2, x0, 2000
    assign inst[2] = 32'h60011193; // clz  x3, x2
    assign inst[3] = 32'hffe00213; // addi x4, x0, -2
    assign inst[4] = 32'h60021293; // clz  x5, x4

    assign result = (im_a - INST_START)>>2;

    assign im_rd = inst[result];

endmodule
