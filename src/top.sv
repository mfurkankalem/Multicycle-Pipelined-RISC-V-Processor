

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
    output logic  [XLEN-1:0] data_o [0:XLEN-1], // data memory write
    output logic  [XLEN-1:0] mem_data_o   // retired memory data              //imem için kullanılacak
    
);

logic [XLEN-1:0] pc_fi, pc_fo, im_rd, pc_p;

clk_fetch clk_fetch_0(.clk(clk), .rstn_i(rstn_i), .pc_fi(branch_rd_wo), .pc_fo(pc_fo));
prog_cnt prog_cnt_0(.prog_cnt_i(pc_fo), .prog_cnt_o(pc_p));
instruction_memory instruction_memory_0(.im_a(pc_fo), .im_rd(im_rd));


logic [XLEN-1:0] inst_do, pc_do, prog_cnt_do;
logic [XLEN-1:0] r_rd1, r_rd2, r_wd3, e_rd;
ctrl_e ctrl_bits;
logic [2:0] e_cd;
logic [3:0] alu_cd;

clk_decode clk_decode_0(.clk(clk), .inst_di(im_rd), .pc_di(pc_fo), .prog_cnt_di(pc_p),
.inst_do(inst_do), .pc_do(pc_do), .prog_cnt_do(prog_cnt_do));
register r_0(.clk(clk), .r_cd(ctrl_bits_wo[CTRLB_R]), .r_a1(inst_do[19:15]), .r_a2(inst_do[24:20]), 
.r_a3(inst_wo[11:7]), .r_wd3(r_wd3), .r_rd1(r_rd1), .r_rd2(r_rd2));
extender e_0(.e_a(inst_do[31:7]), .e_cd(e_cd), .e_rd(e_rd));
control c_0(.op(inst_do[6:0]), .funct3(inst_do[14:12]), .funct7(inst_do[31:25]),
.e_cd(e_cd), .alu_cd(alu_cd), .ctrl_bits(ctrl_bits));


logic [XLEN-1:0] r_rd1_eo, r_rd2_eo, e_rd_eo, inst_eo, pc_eo, prog_cnt_eo;
ctrl_e ctrl_bits_eo; 
logic [3:0] alu_cd_eo; 
logic [XLEN-1:0] alu_a, alu_b, alu_rd, branch_rd;
logic [XLEN-1:0] demux1_out1, demux1_out2, demux2_out1, demux2_out2, demux2_out3;
logic [XLEN-1:0] empty;

clk_execute clk_execute_0 (.clk(clk), .ctrl_bits_ei(ctrl_bits), .alu_cd_ei(alu_cd), 
.r_rd1_ei(r_rd1), .r_rd2_ei(r_rd2), .e_rd_ei(e_rd), .inst_ei(inst_do), 
.pc_ei(pc_do), .prog_cnt_ei(prog_cnt_do), .ctrl_bits_eo(ctrl_bits_eo), 
.alu_cd_eo(alu_cd_eo), .r_rd1_eo(r_rd1_eo), .r_rd2_eo(r_rd2_eo), .e_rd_eo(e_rd_eo), 
.inst_eo(inst_eo), .pc_eo(pc_eo), .prog_cnt_eo(prog_cnt_eo));

mux mux_3 (.a1(pc_eo), .a2(r_rd1_eo), .m_cd(ctrl_bits_eo[CTRLB_M3]), .m_rd(alu_a));
demux demux_1 (.a1(r_rd2_eo), .d_cd(ctrl_bits_eo[CTRLB_D1]), .rd1(demux1_out1), .rd2(demux1_out2));
mux mux_1 (.a1(demux1_out1), .a2(e_rd_eo), .m_cd(ctrl_bits_eo[CTRLB_M1]), .m_rd(alu_b));
ALU alu_0(.alu_a(alu_a), .alu_b(alu_b), .alu_cd(alu_cd_eo), .alu_rd(alu_rd));
demux_2b demux_2 (.a1(alu_rd), .d_cd(ctrl_bits_eo[CTRLB_D2_MSB:CTRLB_D2_LSB]), 
.rd1(demux2_out1), .rd2(demux2_out2), .rd3(demux2_out3), .rd4(empty));
branch branch_0(.alu_rd(alu_rd), .e_rd(e_rd_eo), .program_counter(prog_cnt_eo),
.op(inst_eo[6:0]), .funct3(inst_eo[14:12]), .branch_rd(branch_rd));


ctrl_e ctrl_bits_mo;
logic [XLEN-1:0] demux2_out1_mo, demux2_out2_mo, branch_rd_mo, demux1_out2_mo, 
inst_mo, pc_mo, prog_mo, dm_rd;

clk_memory clk_memory_0 (.clk(clk), .ctrl_bits_mi(ctrl_bits_eo), 
.demux2_out1_mi(demux2_out1), .demux2_out2_mi(demux2_out2), .branch_rd_mi(branch_rd), 
.demux1_out2_mi(demux1_out2), .inst_mi(inst_eo), .pc_mi(pc_eo), 
.prog_cnt_mi(prog_cnt_eo), .ctrl_bits_mo(ctrl_bits_mo), 
.demux2_out1_mo(demux2_out1_mo), .demux2_out2_mo(demux2_out2_mo), 
.branch_rd_mo(branch_rd_mo), .demux1_out2_mo(demux1_out2_mo), 
.inst_mo(inst_mo), .pc_mo(pc_mo), .prog_mo(prog_mo));
data_memory m_data(.clk(clk), .dm_cd(ctrl_bits_mo[CTRLB_DM]), .dm_a(demux2_out1_mo), 
.data_dm(data_o), .dm_wd (demux1_out2_mo), .dm_rd(dm_rd));


ctrl_e ctrl_bits_wo;
logic [XLEN-1:0] branch_rd_wo, dm_rd_wo, demux2_out2_wo, inst_wo, pc_wo, prog_wo;

clk_writeback clk_writeback_0 (.clk(clk), .ctrl_bits_wi(ctrl_bits_mo), 
.branch_rd_wi(branch_rd_mo), .dm_rd_wi(dm_rd), .demux2_out2_wi(demux2_out2_mo), 
.inst_wi(inst_mo), .pc_wi(pc_mo), .prog_cnt_wi(prog_mo), .ctrl_bits_wo(ctrl_bits_wo), 
.branch_rd_wo(branch_rd_wo), .dm_rd_wo(dm_rd_wo), .demux2_out2_wo(demux2_out2_wo), 
.inst_wo(inst_wo), .pc_wo(pc_wo), .prog_wo(prog_wo));

mux_2b mux_2 (.a1(demux2_out2_wo), .a2(dm_rd_wo), .a3(prog_wo), 
.a4('0), .m_cd(ctrl_bits_wo[CTRLB_M2_MSB:CTRLB_M2_LSB]), .m_rd(r_wd3));

  always_comb begin
    if (pc_wo>(INST_START-1))
      update_o   = 1'b1;
    else
      update_o   = 0;
  end

  assign pc_o       = pc_wo;
  assign instr_o    = inst_wo;
  assign reg_addr_o = (inst_wo[11:7]);
  assign reg_data_o = r_wd3;
  assign mem_addr_o = 32'h00000003;
  assign mem_data_o = 32'hFF000005;



endmodule


