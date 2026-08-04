
module top import riscv_pkg::*; 
#(
    parameter DMemInitFile  = "dmem.mem",       // data memory initialization file
    parameter IMemInitFile  = "imem.mem"        // instruction memory initialization file
)   (
    input  logic             clk_i,       // system clock
    input  logic             rstn_i,      // system reset
    input  logic  [XLEN-1:0] addr_i,      // memory adddres input for reading
    output logic  [XLEN-1:0] data_o,      // memory data output for reading
    output logic             update_o,    // retire signal
    output logic  [XLEN-1:0] pc_o,        // retired program counter
    output logic  [XLEN-1:0] instr_o,     // retired instruction
    output logic  [     4:0] reg_addr_o,  // retired register address
    output logic  [XLEN-1:0] reg_data_o,  // retired register data
    output logic  [XLEN-1:0] mem_addr_o,  // retired memory address
    output logic  [XLEN-1:0] mem_data_o   // retired memory data
);
  logic a;

  assign data_o     = '0;
  assign update_o   = '0;
  assign pc_o       = '0;
  assign instr_o    = '0;
  assign reg_addr_o = '0;
  assign reg_data_o = '0;
  assign mem_addr_o = '0;
  assign mem_data_o = '0;

  // module body
  // use other modules according to the need.

endmodule
