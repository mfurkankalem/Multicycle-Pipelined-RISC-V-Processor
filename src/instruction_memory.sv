//will be changed later


module instruction_memory import riscv_pkg::*; (
    input logic [XLEN-1:0] im_a,
    output logic [XLEN-1:0] im_rd 
);

    logic [XLEN-1:0]  inst [0:XLEN-1];    
    logic [XLEN-1:0] result;              
    
    assign inst[0] = 32'h00200193; // addi x3, x0, 2
    assign inst[1] = 32'h00100113; // addi x2, x0, 1
    assign inst[2] = 32'hffe00093; // addi x1, x0, -2
    assign inst[3] = 32'h00218233; // add x4, x3, x2
    assign inst[4]  = 32'h001202b3; // add x5, x4, x1
    assign inst[5]  = 32'h00000013; // nop (addi x0, x0, 0)
    assign inst[6]  = 32'h00502023; // sw x5, 0(x0)
    assign inst[7]  = 32'h00228293; // addi x5, x5, 2
    assign inst[8]  = 32'h00000013; // nop (addi x0, x0, 0)
    assign inst[9]  = 32'h005020a3; // sw x5, 1(x0)
    assign inst[10] = 32'h00002203; // lw x4, 0(x0)
    assign inst[11] = 32'h00102183; // lw x3, 1(x0)

    assign result = (im_a - INST_START)>>2;

    assign im_rd = inst[result];

endmodule
