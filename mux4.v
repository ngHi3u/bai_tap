module mux4 (
    muxi0, muxi1, muxi2, muxi3, muxo, muxsel
);

input [31:0] muxi0, muxi1, muxi2, muxi3;
output [31:0] muxo;
input [1:0] muxsel;

assign muxo = muxsel[1] ? (muxsel[0] ? muxi3 : muxi2) : (muxsel[0] ? muxi1 : muxi0);
    
endmodule