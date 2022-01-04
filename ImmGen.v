module immgen (
    inst, immSel, immgen
);

input [31:0] inst;
input [2:0] immSel;
output [31:0] immgen;

reg [31:0] immgenR;

always @(*) begin
    
   case (immSel)
    //I-type
    0:  immgenR = {{20{inst[31]}}, inst[31:20]};
    //S-type
    1:  immgenR = {{20{inst[31]}}, inst[31:25], inst[11:7]};
    //B-type
    2:  immgenR = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0} ;
    //J-type
    3:  immgenR = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:25], inst[24:21], 1'b0};
    //U-type
    4:  immgenR = {inst[31:12], {12{1'b0}}};
    default: immgenR = 0;
    endcase 
end

assign immgen = immgenR;
    
endmodule