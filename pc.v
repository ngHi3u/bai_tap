module pc (
    clk, rst, pcin, pcout
);
input  clk;
input [31:0] pcin;
output [31:0] pcout;

input rst;
reg [31:0] r;

// đầu ra tiếp theo bằng đầu vào hiện tại khi gặp sườn lên của xung clk
always @(posedge clk) begin
	if(rst == 0)
		r <= pcin;
	else 	
		r <= 0;
end

assign pcout = r;

endmodule