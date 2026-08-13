

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
    output logic  [4:0]      reg_addr_o,  // log register address
    output logic  [XLEN-1:0] reg_data_o,  // log register data
    output logic  [XLEN-1:0] mem_addr_o,  // retired memory address
    output logic  [7:0]      data_o  [0:XLEN-1], // data memory write
    output logic  [XLEN-1:0] mem_data_o   // retired memory data              //imem için kullanılacak
    
);

logic en_f, en_d, en_e, en_m, en_w, branch_taken, flush_d, flush_e;
logic [1:0] forward_ae, forward_be; 

hazard_unit hazard_unit_0(.clk(clk), .en_f(en_f), .en_d(en_d),
.en_e(en_e), .en_m(en_m), .en_w(en_w), .rstn_i(rstn_i),
.forward_ae(forward_ae), .forward_be(forward_be),
.inst_eo(inst_eo), .inst_wo(inst_wo), .inst_mo(inst_mo),
.ctrl_bits_mo(ctrl_bits_mo), .ctrl_bits_wo(ctrl_bits_wo),
.branch_taken(branch_taken), .flush_d(flush_d), .flush_e(flush_e));

logic [XLEN-1:0] pc_fi, pc_fo, im_rd, pc_p;

clk_fetch clk_fetch_0(.clk(clk), .en_f(en_f), .rstn_i(rstn_i), 
.pc_fi(m4_o), .pc_fo(pc_fo));
prog_cnt prog_cnt_0(.prog_cnt_i(pc_fo), .prog_cnt_o(pc_p));
instruction_memory instruction_memory_0(.im_a(pc_fo), .im_rd(im_rd));


logic [XLEN-1:0] inst_do, pc_do, prog_cnt_do;
logic [XLEN-1:0] r_rd1, r_rd2, e_rd;
ctrl_e ctrl_bits;
logic [2:0] e_cd;
logic [3:0] alu_cd;

clk_decode clk_decode_0(.clk(clk), .inst_di(im_rd), .pc_di(pc_fo), .prog_cnt_di(pc_p),
.inst_do(inst_do), .pc_do(pc_do), .prog_cnt_do(prog_cnt_do), .en_d(en_d), .flush_d(flush_d));
register r_0(.clk(clk), .r_cd(ctrl_bits_wo[CTRLB_R]), .r_a1(inst_do[19:15]), .r_a2(inst_do[24:20]), 
.r_a3(inst_wo[11:7]), .r_wd3(mux2_out), .r_rd1(r_rd1), .r_rd2(r_rd2));
extender e_0(.e_a(inst_do[31:7]), .e_cd(e_cd), .e_rd(e_rd));
control c_0(.op(inst_do[6:0]), .funct3(inst_do[14:12]), .funct7(inst_do[31:25]),
.e_cd(e_cd), .alu_cd(alu_cd), .ctrl_bits(ctrl_bits), .rs2(inst_do[24:20]));


logic [XLEN-1:0] r_rd1_eo, r_rd2_eo, e_rd_eo, inst_eo, pc_eo, prog_cnt_eo,
forward_ae_o, forward_be_o;
ctrl_e ctrl_bits_eo;
logic [3:0] alu_cd_eo; 
logic [XLEN-1:0] alu_a, alu_b, alu_rd, branch_rd;

clk_execute clk_execute_0 (.clk(clk), .en_e(en_e), .ctrl_bits_ei(ctrl_bits), 
.alu_cd_ei(alu_cd), .r_rd1_ei(r_rd1), .r_rd2_ei(r_rd2), .e_rd_ei(e_rd), 
.inst_ei(inst_do),  .pc_ei(pc_do), .prog_cnt_ei(prog_cnt_do), .ctrl_bits_eo(ctrl_bits_eo), 
.alu_cd_eo(alu_cd_eo), .r_rd1_eo(r_rd1_eo), .r_rd2_eo(r_rd2_eo), .e_rd_eo(e_rd_eo), 
.inst_eo(inst_eo), .pc_eo(pc_eo), .prog_cnt_eo(prog_cnt_eo), .flush_e(flush_e));

mux_2b mux_forwardae_0 (.a1(r_rd1_eo), .a2(mux2_out), .a3(alu_rd_mo), .a4('0),
.m_cd(forward_ae), .m_rd(forward_ae_o));
mux_2b mux_forwardbe_0 (.a1(r_rd2_eo), .a2(mux2_out), .a3(alu_rd_mo), .a4('0),
.m_cd(forward_be), .m_rd(forward_be_o));

mux mux_3 (.a1(pc_eo), .a2(forward_ae_o), .m_cd(ctrl_bits_eo[CTRLB_M3]), .m_rd(alu_a));
mux mux_1 (.a1(forward_be_o), .a2(e_rd_eo), .m_cd(ctrl_bits_eo[CTRLB_M1]), .m_rd(alu_b));
ALU alu_0(.alu_a(alu_a), .alu_b(alu_b), .alu_cd(alu_cd_eo), .alu_rd(alu_rd));
branch branch_0(.alu_rd(alu_rd), .e_rd(e_rd_eo), .program_counter(prog_cnt_eo),
.op(inst_eo[6:0]), .funct3(inst_eo[14:12]), .branch_rd(branch_rd),
.rstn_i(rstn_i), .m_cd4(m_cd4), .branch_taken(branch_taken));


ctrl_e ctrl_bits_mo;
logic [XLEN-1:0] inst_mo, pc_mo, prog_mo, dm_rd, alu_rd_mo, 
r_rd2_mo, branch_rd_mo;

clk_memory clk_memory_0 (.clk(clk), .en_m(en_m), .ctrl_bits_mi(ctrl_bits_eo), 
.alu_rd_mi(alu_rd), .r_rd2_mi(forward_be_o), .inst_mi(inst_eo), .pc_mi(pc_eo), 
.prog_cnt_mi(prog_cnt_eo), .ctrl_bits_mo(ctrl_bits_mo), 
.alu_rd_mo(alu_rd_mo), .r_rd2_mo(r_rd2_mo), 
.inst_mo(inst_mo), .pc_mo(pc_mo), .prog_mo(prog_mo));
data_memory m_data(.clk(clk), .dm_a(alu_rd_mo), 
.data_dm(data_o), .dm_wd (r_rd2_mo), .dm_rd(dm_rd), .op(inst_mo[6:0]),
.funct3(inst_mo[14:12]));


ctrl_e ctrl_bits_wo;
logic [XLEN-1:0] branch_rd_wo, alu_rd_wo, dm_rd_wo, inst_wo, pc_wo, prog_wo, mux2_out;

clk_writeback clk_writeback_0 (.clk(clk), .en_w(en_w), .ctrl_bits_wi(ctrl_bits_mo), 
.dm_rd_wi(dm_rd), .alu_rd_wi(alu_rd_mo), 
.inst_wi(inst_mo), .pc_wi(pc_mo), .prog_cnt_wi(prog_mo), .ctrl_bits_wo(ctrl_bits_wo), 
.dm_rd_wo(dm_rd_wo), .alu_rd_wo(alu_rd_wo), 
.inst_wo(inst_wo), .pc_wo(pc_wo), .prog_wo(prog_wo));

mux_2b mux_2 (.a1(alu_rd_wo), .a2(dm_rd_wo), .a3(prog_wo), 
.a4('0), .m_cd(ctrl_bits_wo[CTRLB_M2_MSB:CTRLB_M2_LSB]), .m_rd(mux2_out));

logic m_cd4;
logic [XLEN-1:0] m4_o;
mux mux_4 (.a2(branch_rd), .a1(pc_p), .m_cd(m_cd4), .m_rd(m4_o));

  always_comb begin
    if ((en_w) & (pc_wo>(INST_START-1)) & (inst_wo>0))
      update_o   = 1'b1;
    else
      update_o   = 0;
    if ((inst_wo[6:0]==7'b1100011) | (inst_wo[6:0]==7'b0100011))
      reg_addr_o = (inst_wo[19:15]);
    else
      reg_addr_o = (inst_wo[11:7]);
  end

  assign pc_o       = pc_wo;
  assign instr_o    = inst_wo;
  assign reg_data_o = mux2_out;
  assign mem_addr_o = 32'h00000003;
  assign mem_data_o = 32'hFF000005;



endmodule


