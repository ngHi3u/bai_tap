module cpu (
   clk, rst
//for control logic
//    pcsel, 
//    RegWEn,
//   // ASel, BSel, ALUSel,
//    MemRW, 
//    WBSel,
//    BrUn, BrEq, BrLt,
//    immSel
);

output reg clk;
output reg rst;
// output reg pcsel;
// output reg RegWEn;
// output reg ASel;
// output reg BSel;
// output reg [1:0] ALUSel;
// output reg MemRW;
// output reg [1:0] WBSel;
// output reg BrUn;
// input BrEq;
// input BrLt;
// output reg [2:0] immSel;

wire [31:0] w1; //add_mux1
wire [31:0] w2; //pc_add
wire [31:0] w3; //ALU_mux1
wire [31:0] w4; //mux1_PC
wire [31:0] w5; //instruction
wire [31:0] w6; // Write data to registor
wire [31:0] w7; //Readdata1
wire [31:0] w8; //Readdata2
wire [31:0] w9; //ALU_in1
wire [31:0] w10; //ALU_in2
wire [31:0] w11; //Immgen_out
wire [31:0] w12; //DMEM out

wire wc1;
wire [4:0] wc21;
wire [4:0] wc22;
wire [4:0] wc23;
wire [2:0] wc3;
wire wc4;
wire wc5;
wire wc6;
wire wc7;
wire wc8;
wire wc9;
wire [2:0] wc10;
wire wc11;
wire [1:0] wc12;

add4 add4_1 (
    .add4i(w2),
    .add4o(w1)
);

pc pc_1 (
    .clk(clk),
    .rst(rst),
    .pcin(w4),
    .pcout(w2)
);

mux2 mux_1(
    .muxi0(w1), 
    .muxi1(w3), 
    .muxo(w4), 
    .muxsel(wc1)
);

IMEM imem(
    .address(w2),
    .inst(w5)
);

// instruction_parser ip(
//     .inst(w5),
//     //.opcode(),
//     .rd(w51),
//     //.funct3(),
//     .rs1(w52),
//     .rs2(w53)
//     //.funct7()
// );

registor REG(
    .clk(clk),
    .rst(rst),
    .RegWEn(wc4),
    .Writedata(w6),
    .rs1(wc22),
    .rs2(wc23),
    .rd(wc21),
    .ReadData1(w7),
    .ReadData2(w8)
);

mux2 mux_2(
    .muxi0(w7), 
    .muxi1(w2), 
    .muxo(w9), 
    .muxsel(wc9)
);
mux2 mux_3(
    .muxi0(w8), 
    .muxi1(w11), 
    .muxo(w10), 
    .muxsel(wc8)
);

alu ALU(
    .aluSel(wc10), 
    .aluin1(w9), 
    .aluin2(w10), 
    .aluout(w3)
);

dmem dmem_1(
    .clk(clk), 
    .address(w3), 
    .WriteData(w8), 
    .ReadData(w12),
    .MemRW(wc11)
);

mux4 mux_4(
    .muxi0(w12), 
    .muxi1(w3), 
    .muxi2(w1), 
    //.muxi3(), 
    .muxo(w6), 
    .muxsel(wc12)
);

branchcomp brc(
    .input1(w7), 
    .input2(w8), 
    .BrUn(wc5), 
    .BrEq(wc6), 
    .BrLt(wc7)
);

immgen ig(
    .inst(w5), 
    .immSel(wc3), 
    .immgen(w11)
);

control ctr(
    .inst(w5), 
    .rd(wc21), 
    .rs1(wc22), 
    .rs2(wc23),
    .ASel(wc9), 
    .BSel(wc8), 
    .ALUSel(wc10),
    .pcsel(wc1),
    .immSel(wc3), 
    .RegWEn(wc4),
    .BrUn(wc5),
    .BrEq(wc6),
    .BrLt(wc7),
    .MemRW(wc11), 
    .WBSel(wc12)
);
    
initial begin
rst = 1'b1;
#5 rst = 1'b0;
end

endmodule
