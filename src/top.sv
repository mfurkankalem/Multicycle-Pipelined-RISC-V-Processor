

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

logic [XLEN-1:0] pc_fi, pc_fo, im_rd, pc_p;

clk_fetch clk_fetch_0(.clk(clk), .rstn_i(rstn_i), .pc_fi(pc_p), .pc_fo(pc_fo));
prog_cnt prog_cnt_0(.prog_cnt_i(pc_fo), .prog_cnt_o(pc_p));
instruction_memory instruction_memory_0(.im_a(pc_fo), .im_rd(im_rd));


logic [XLEN-1:0] inst_do, pc_do, prog_cnt_do;
logic [XLEN-1:0] r_rd1, r_rd2, r_wd3, e_rd;
ctrl_e ctrl_bits;
logic [2:0] e_cd;
logic [3:0] alu_cd;

assign r_wd3 = 0;                  //fake

clk_decode clk_decode_0(.clk(clk), .inst_di(im_rd), .pc_di(pc_fo), .prog_cnt_di(pc_p),
.inst_do(inst_do), .pc_do(pc_do), .prog_cnt_do(prog_cnt_do));
register r_0(.clk(clk), .r_cd(ctrl_bits[CTRLB_R]), .r_a1(inst_do[19:15]), .r_a2(inst_do[24:20]), 
.r_a3(inst_do[11:7]), .r_wd3(r_wd3), .r_rd1(r_rd1), .r_rd2(r_rd2));
extender e_0(.e_a(inst_do[31:7]), .e_cd(e_cd), .e_rd(e_rd));
control c_0(.op(inst_do[6:0]), .funct3(inst_do[14:12]), .funct7(inst_do[31:25]),
.e_cd(e_cd), .alu_cd(alu_cd), .ctrl_bits(ctrl_bits));


ctrl_e ctrl_bits_eo; 
logic [3:0] alu_cd_eo; 
logic [XLEN-1:0] r_rd1_eo, r_rd2_eo, e_rd_eo, inst_eo, pc_eo, prog_cnt_eo;

clk_execute clk_execute_0 (.clk(clk), .ctrl_bits_ei(ctrl_bits), .alu_cd_ei(alu_cd), 
.r_rd1_ei(r_rd1), .r_rd2_ei(r_rd2), .e_rd_ei(e_rd), .inst_ei(inst_do), 
.pc_ei(pc_do), .prog_cnt_ei(prog_cnt_do), .ctrl_bits_eo(ctrl_bits_eo), 
.alu_cd_eo(alu_cd_eo), .r_rd1_eo(r_rd1_eo), .r_rd2_eo(r_rd2_eo), .e_rd_eo(e_rd_eo), 
.inst_eo(inst_eo), .pc_eo(pc_eo), .prog_cnt_eo(prog_cnt_eo));

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


