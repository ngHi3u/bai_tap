module control (
    pcsel,
    inst, rd, rs1, rs2,
    immSel, 
    RegWEn,
    BrUn, BrEq, BrLt,
    ASel, BSel, ALUSel,
    MemRW, 
    WBSel
);

input [31:0] inst;

output [4:0] rs1;
output [4:0] rs2;
output [4:0] rd;

output ASel, BSel;
output [2:0] ALUSel;
output pcsel;
output RegWEn;
output MemRW;
output [1:0] WBSel;
output BrUn;
input BrEq;
input BrLt;
output [2:0] immSel;

reg [2:0] ALUSelR;
reg ASelR, BSelR;
reg pcselR;
reg RegWEnR;
reg MemRWR;
reg [1:0] WBSelR;
reg BrUnR;
reg [2:0] immSelR;

reg [6:0] opcode;
reg [2:0] funct3;
reg [6:0] funct7;


assign rd = inst [11:7];
assign rs1 = inst [19:15];
assign rs2 = inst [24:20];

assign ALUSel = ALUSelR;
assign ASel = ASelR;
assign BSel = BSelR;
assign pcsel = pcselR;
assign RegWEn = RegWEnR;
assign WBSel = WBSelR;
assign BrUn = BrUnR;
assign immSel = immSelR;
assign MemRW = MemRWR;


always @(*) begin
    opcode = inst [6:0];
    funct3 = inst [14:12];
    funct7 = inst [31:25];
    case (opcode)
    7'b0110011: begin // R-format
        ASelR = 0;
        BSelR = 0;
        pcselR = 0;
        RegWEnR = 1;
        WBSelR = 1;
        MemRWR = 0;
        case (funct3)
            3'b000: begin //add-sub
                case (funct7)
                    7'b0000000:  ALUSelR = 2'b00; //add
                    7'b0100000:  ALUSelR = 2'b01; //sub
                endcase
            end
        endcase
    end 
    7'b0010011: begin //I-format arithmetic
        pcselR = 0;
        immSelR = 0;
        RegWEnR = 1;
        ASelR = 0;
        BSelR = 1;
        MemRWR = 0;
        WBSelR = 1;
        case (funct3)
            3'b000: begin //addi
                ALUSelR = 2'b00; //add
            end
        endcase
    end
    7'b0000011: begin //I-format LOAD
        pcselR = 0;
        immSelR = 0;
        RegWEnR = 1;
        ASelR = 0;
        BSelR = 1;
        MemRWR = 0;
        WBSelR = 0;
        ALUSelR = 2'b00;
        case (funct3)
            3'b010: begin //lw
                
            end
        endcase
    end

    7'b0100011: begin //S-format
        pcselR = 0;
        immSelR = 1;
        RegWEnR = 0;
        ASelR = 0;
        BSelR = 1;
        MemRWR = 1;
        WBSelR = 0;
        ALUSelR = 2'b00;
        case (funct3)
            3'b010: begin //sw
                
            end
        endcase
    end
    7'b1100011: begin // B-format
        immSelR = 2;
        RegWEnR = 0;
        ASelR = 1;
        BSelR = 1;
        MemRWR = 0;
        ALUSelR = 2'b00;
        BrUnR = 1;
        case (funct3)
            3'b000: begin //beq
                pcselR = BrEq;
            end
            3'b001: begin //beq
                pcselR = ~BrEq;
            end
             
        endcase
    end
    
    7'b1100111: begin // JALR
        pcselR = 1;
        immSelR = 0;
        RegWEnR = 1;
        ASelR = 0;
        BSelR = 1;
        MemRWR = 0;
        WBSelR = 2;
        ALUSelR = 2'b00;
        
    end    
    7'b1101111: begin // JAL
        pcselR = 1;
        immSelR = 3;
        RegWEnR = 1;
        ASelR = 1;
        BSelR = 1;
        MemRWR = 0;
        WBSelR = 2;
        ALUSelR = 2'b00;        
    end
    7'b0110111: begin // LUI
        pcselR = 0;
        immSelR = 4;
        RegWEnR = 1;
        BSelR = 1;
        MemRWR = 0;
        WBSelR = 1;
        ALUSelR = 4;
    end
    7'b0110111: begin // AUIPC
        pcselR = 0;
        immSelR = 4;
        RegWEnR = 1;
        ASelR = 1;
        BSelR = 1;
        MemRWR = 0;
        WBSelR = 1;
        ALUSelR = 0;
    end

endcase
end


    
endmodule