//will be changed later


module instruction_memory import riscv_pkg::*; (
    input logic [XLEN-1:0] im_a,
    output logic [XLEN-1:0] im_rd 
);

    logic [XLEN-1:0]  inst [0:XLEN-1];    
    logic [XLEN-1:0] result;              
    
    assign inst[0] = 32'h00000093; // addi x1, x0, 0
    assign inst[1] = 32'h00108093; // addi x1, x1, 1  
    assign inst[2] = 32'h00200113; // addi x2, x0, 2
    assign inst[3] = 32'hfe209ce3; // bne  x1, x2, -8 
    assign inst[4] = 32'h00500193; // addi x3, x0, 5   
    assign inst[5] = 32'h00000013; // nop

    assign result = (im_a - INST_START)>>2;

    assign im_rd = inst[result];

endmodule
