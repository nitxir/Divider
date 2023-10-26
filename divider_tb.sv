module divider_tb;
reg clk;
reg reset;
reg start;
reg [7:0] A;
reg [7:0] B;
wire [7:0] D;
wire [7:0] R;
wire ok;
wire err;
reg [7:0]i,j;
//instantiate
divider uut(clk , reset , start , A , B , D , R , ok , err );

initial begin
clk=0;
forever #50
clk = ~clk;
end

initial begin
reset=0;start=1;
#100 reset=1;start=0;
#100 reset=0;start=1;A=32'd0;i=32'd0;
while(i<=8'd255)
    begin
             #25600 A=i;i=i+1;
    end
end

initial begin
#200  B=32'd0;j=32'd0;
while(j<=8'd255)
      begin
             #100 B=j;j=j+1;
    end
end

endmodule
