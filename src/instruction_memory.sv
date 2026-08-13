//will be changed later


module instruction_memory import riscv_pkg::*; (
    input logic [XLEN-1:0] im_a,
    output logic [XLEN-1:0] im_rd 
);

    logic [XLEN-1:0]  inst [0:XLEN-1];    
    logic [XLEN-1:0] result;              
    
    assign inst[0]  = 32'h05A00093; // addi x1, x0, 90
    assign inst[1]  = 32'h12300113; // addi x2, x0, 291
    assign inst[2]  = 32'h030391B7; // lui  x3, 12345
    assign inst[3]  = 32'h00100023; // sb   x1, 0(x0)
    assign inst[4]  = 32'h00201123; // sh   x2, 2(x0)
    assign inst[5]  = 32'h00302223; // sw   x3, 4(x0)
    assign inst[6]  = 32'h00000203; // lb   x4, 0(x0)
    assign inst[7]  = 32'h00201283; // lh   x5, 2(x0)
    assign inst[8]  = 32'h00304303; // lbu  x6, 3(x0)
    assign inst[9]  = 32'h00402383; // lw   x7, 4(x0)


    assign result = (im_a - INST_START)>>2;

    assign im_rd = inst[result];

endmodule
