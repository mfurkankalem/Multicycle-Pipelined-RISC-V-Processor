

module top import riscv_pkg::*; 
#(
    parameter DMemInitFile  = "dmem.mem",       // data memory initialization file
    parameter IMemInitFile  = "imem.mem"        // instruction memory initialization file
)   (
    input  logic             clk,
    input  logic             rstn_i,      // system reset                     //??
    input  logic  [XLEN-1:0] addr_i,      // data memory report
    output logic             update_o,    // log update signal
    output logic  [XLEN-1:0] pc_o,        // log program counter
    output logic  [XLEN-1:0] instr_o,     // log instruction
    output logic  [     4:0] reg_addr_o,  // log register address
    output logic  [XLEN-1:0] reg_data_o,  // log register data
    output logic  [XLEN-1:0] mem_addr_o,  // retired memory address
    output logic  [XLEN-1:0] data_o,      // data memory write
    output logic  [XLEN-1:0] mem_data_o   // retired memory data              //imem için kullanılacak
    
);

logic [XLEN-1:0] pc_fi = 32'h80000000;
logic [XLEN-1:0] pc_fo;

clk_fetch clk_fetch_0(.clk(clk), .rstn_i(rstn_i), .pc_fi(pc_fi), .pc_fo(pc_fo));
prog_cnt prog_cnt_0(.prog_cnt_i(pc_fo), .prog_cnt_o(pc_fi));



  always_ff @(posedge clk) begin 
    update_o   <= ~(update_o);
  end

  assign data_o     = 32'hFF000000;
  assign pc_o       = 32'hFF00FF01;
  assign instr_o    = 32'hFF00FF02;
  assign reg_addr_o = 5'b01010;
  assign reg_data_o = 32'hFF00FF03;
  assign mem_addr_o = 32'h00000003;
  assign mem_data_o = 32'hFF000005;



endmodule


