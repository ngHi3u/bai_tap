module mux2 (
    muxi0, muxi1, muxo, muxsel
);

input [31:0] muxi0, muxi1;
output [31:0] muxo;
input muxsel;

assign muxo = muxsel ? muxi1 : muxi0;
    
endmodule