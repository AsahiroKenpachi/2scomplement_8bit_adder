`include "adder.v"
module tb ();
    reg [7:0] inp1,inp2;
    reg enable,reset;
    wire overflow_flag;
    wire[7:0] sum;
    adder8bit_signed b1(inp1,inp2,enable,reset,overflow_flag,sum);
    initial begin
        reset=1;
        #2
        reset=0;
        enable=1;
        #2;
        inp1=1;inp2=-1;
        #2;
        inp1=8'b01111111;inp2=8'b00000001;
        #2;
        // inp1=8'b00000001;inp2=8'b00000011;
        // #2;
        // inp1=8'b11111001;inp2=8'b11111111;
        // #2;
        // inp1=8'b10000001;inp2=8'b11111111;
        // #2;
        $finish();
    end
    initial begin
        $dumpfile("signal.vcd");
        $dumpvars(0,tb);
    end
    
endmodule
