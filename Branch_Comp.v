module branchcomp (
    input1, input2, BrUn, BrEq, BrLt
);
input [31:0] input1;
input [31:0] input2;
input BrUn;
output BrEq, BrLt;

reg BrEqR, BrLtR;
reg [31:0] r1, r2;
reg [30:0] ru1, ru2;
reg r1_31, r2_31;

always @(*) begin
    r1 = input1;
    r2 = input2;
    ru1 = input1 [30:0];
    ru2 = input2 [30:0];
    r1_31 = input1[31];
    r2_31 = input2[31];
    
    // trường hợp so sánh hai số không dấu
    if(BrUn) begin
        if(r1 != r2) begin
            BrEqR = 0;
            BrLtR = (r1 < r2) ? 1 : 0; 
        end
        else BrEqR = 1;
    end
    else begin // trường hợp so sánh hai số có dấu, bit 31 là bit dấu
        if(r1_31 != r2_31) begin 
            if(ru1 == 0 && ru2 == 0) BrEqR = 1;
            else begin
                BrEqR = 0;
                if(r1_31 == 1) BrLtR = 1;
                else  BrLtR = 0;
            end 
        end
        else begin
            if(ru1 != ru2) begin
                BrEqR = 0;
                if(r1_31 == 1) BrLtR = (ru1 > ru2) ? 1 : 0; 
                else           BrLtR = (ru1 < ru2) ? 1 : 0;  
            end
            else BrEqR = 1;
        end
    end
end

assign BrEq = BrEqR;
assign BrLt = BrLtR;

endmodule