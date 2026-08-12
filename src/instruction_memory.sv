//will be changed later


module instruction_memory import riscv_pkg::*; (
    input logic [XLEN-1:0] im_a,
    output logic [XLEN-1:0] im_rd 
);

    logic [XLEN-1:0]  inst [0:XLEN-1];    
    logic [XLEN-1:0] result;              
    
    assign inst[0]  = 32'h14300093; // addi x1, x0, 323
    assign inst[1]  = 32'h030390b7; // lui  x1, 12345
    assign inst[2]  = 32'h00102023; // sw   x1, 0(x0)
    assign inst[3]  = 32'h002020a3; // sw   x2, 1(x0)
    assign inst[4]  = 32'h00000183; // lb   x3, 0(x0)
    assign inst[5]  = 32'h00104203; // lbu  x4, 1(x0)
    assign inst[6]  = 32'h00200283; // lb   x5, 2(x0)
    assign inst[7]  = 32'h00300303; // lb   x6, 3(x0)


    assign result = (im_a - INST_START)>>2;

    assign im_rd = inst[result];

endmodule
