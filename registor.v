module registor (
    clk, rst, RegWEn, Writedata, rs1, rs2, rd, ReadData1, ReadData2
);

input clk, rst, RegWEn;
input [31:0] Writedata;
input [4:0] rs1, rs2, rd;
output [31:0] ReadData1, ReadData2;

reg [31:0] array [31:0];

// thanh ghi được làm trống sau mỗi lần reset hệ thống

// always @(rs1 or rs2 or rst) begin
//     if(rst) begin
//         array[0] = 32'd0;
//         array[1] = 32'd0;
//         array[2] = 32'd0;
//         array[3] = 32'd0;
//         array[4] = 32'd0;
//         array[5] = 32'd0;
//         array[6] = 32'd0;
//         array[7] = 32'd0;
//         array[8] = 32'd0;
//         array[9] = 32'd0;
//         array[10] = 32'd0;
//         array[11] = 32'd0;
//         array[12] = 32'd0;
//         array[13] = 32'd0;
//         array[14] = 32'd0;
//         array[15] = 32'd0;
//         array[16] = 32'd0;
//         array[17] = 32'd0;
//         array[18] = 32'd0;
//         array[19] = 32'd0;
//         array[20] = 32'd0;
//         array[21] = 32'd0;
//         array[22] = 32'd0;
//         array[23] = 32'd0;
//         array[24] = 32'd0;
//         array[25] = 32'd0;
//         array[26] = 32'd0;
//         array[27] = 32'd0;
//         array[28] = 32'd0;
//         array[29] = 32'd0;
//         array[30] = 32'd0;
//         array[31] = 32'd0;
//     end
// end

assign ReadData1 = array[rs1];
assign ReadData2 = array[rs2];

always @(posedge clk) begin
    if(RegWEn)
        array[rd] = Writedata;   
end

initial begin
        array[0] = 32'd1;
        array[1] = 32'd52;
        array[2] = 32'd3;
        array[3] = 32'd4;
        array[4] = 32'd5;
        array[5] = 32'd6;
        array[6] = 32'd7;
        array[7] = 32'd8;
        array[8] = 32'd9;
        array[9] = 32'd10;
        array[10] = 32'd11;
        array[11] = 32'd12;
        array[12] = 32'd13;
        array[13] = 32'd14;
        array[14] = 32'd15;
        array[15] = 32'd16;
        array[16] = 32'd17;
        array[17] = 32'd18;
        array[18] = 32'd9;
        array[19] = 32'd20;
        array[20] = 32'd21;
        array[21] = 32'd22;
        array[22] = 32'd23;
        array[23] = 32'd24;
        array[24] = 32'd25;
        array[25] = 32'd26;
        array[26] = 32'd27;
        array[27] = 32'd28;
        array[28] = 32'd29;
        array[29] = 32'd30;
        array[30] = 32'd31;
        array[31] = 32'd32;
end

endmodule