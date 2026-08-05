//will be changed later


module instruction_memory import riscv_pkg::*; (
    input logic [XLEN-1:0] im_a,
    output logic [XLEN-1:0] im_rd 
);

    logic [XLEN-1:0]  inst [0:XLEN-1];    
    logic [XLEN-1:0] result;              
    
    assign inst[0] = 32'h00200193; // addi x3, x0, 2
    assign inst[1] = 32'h00100113; // addi x2, x0, 1
    assign inst[2] = 32'hffd00093; // addi x1, x0, -3
    assign inst[3] = 32'h00218233; // add x4, x3, x2
    assign inst[4] = 32'h001202b3; // add x5, x4, x1

    assign result = (im_a - 32'h80000000)>>2;

    assign im_rd = inst[result];

endmodule
