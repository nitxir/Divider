module divider(
input clk,
input reset,
input start,
input [7:0] A,
input [7:0] B,
output [7:0] D,
output [7:0] R,
output ok, // =1 when ready to get result
output err
);
reg active; // true if the divider is running
reg[4:0] cyc; // number of cycles to go
reg[7:0] res; // begin with A, end with D
reg[7:0] den; // B
reg[7:0] work; // running R
// calculate the current digit
wire[7:0] sub = { work[6:0], res[7] } -den;
assign err = !B;
// send the results to master
assign D = res;
assign R = work;
assign ok = ~active;
//state machine
always @(posedge clk , posedge reset) begin
if (reset) begin
active <= 0;
cyc <= 0;
res <= 0;
den <= 0;
end
else if(start) begin
if(active) begin
//run iteration of divide
if(sub[7] == 0) begin
work <=sub[7:0];
res <= {res[6:0],1'b1};
end
else begin
work <= { work[6:0],res[7]};
res <= {res[6:0],1'b0};
end
cyc <= cyc - 5'd1;
end
else begin
//set up for an unsigned divide
cyc <= 5'd31;
res <= A;
den <= B;
work <= 8'b0;
active <= 1;
end
end
end
endmodule
