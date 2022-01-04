module alu (
    aluSel, aluin1, aluin2, aluout
);

input [2:0] aluSel;
input [31:0] aluin1, aluin2;
output [31:0] aluout;
reg [31:0] r;

always @(*) begin
    case (aluSel)
        1: r = aluin1 - aluin2; //sub
        4: r = aluin2; // for lui
        default: r = aluin1 + aluin2;//add 
    endcase
end

assign aluout = r;

endmodule