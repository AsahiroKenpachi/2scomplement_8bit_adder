// The MSB is the sign bit
// this is for 8 bit signed number
// 127 is the higest possibe magnitude
// Overflow flag is used to check out off bounds


module adder8bit_signed (
    input [7:0] inp1,inp2,
    input enable,reset,
    output reg overflow_flag,
    output reg[7:0] sum
);
    reg pos1,pos2,sign1,sign2;
    reg [6:0] mag1,mag2,intr1,intr2;
    reg [6:0] intr_mag;
    reg sign_bit;
    always @(*) begin
        if(reset==1) begin
            sum<=0;
            overflow_flag<=0;
        end
        else begin
           if (enable==1) begin
        sign1<=inp1[7];
        sign2<=inp2[7];
        mag1<=inp1[6:0];
        mag2<=inp2[6:0];
        pos1<=(sign1==0);
        pos2<=(sign2==0);
            if(pos1 & pos2)
            begin
                {overflow_flag,intr_mag}<=mag1+mag2;
                sign_bit<=0;
                sum[6:0]<=intr_mag;
                sum[7]<=0;
            end
            else if((pos1 & ~pos2))
            begin
                intr2<=(255-mag2)+1;
                {sign_bit,intr_mag}<=mag1-intr2;
                if (sign_bit==1) begin
                    sum[6:0]<=256-intr_mag;
                    sum[7]<=1;
                end
                else if (sign_bit==0) begin
                    sum[6:0]<=intr_mag;
                    sum[7]<=0;
                end
            end
            else if ((~pos1&pos2)) begin
                intr1<=(255-mag1)+1;
                {sign_bit,intr_mag}<=mag2-intr1;
                if (sign_bit==1) begin
                    sum[6:0]<=256-intr_mag;
                    sum[7]<=1;
                end
                else if (sign_bit==0) begin
                    sum[6:0]<=intr_mag;
                    sum[7]<=0;
                end
            end
            else if ((~pos1)&(~pos2)) begin
                intr2<=(255-mag2)+1;
                intr1<=(255-mag1)+1;
                {overflow_flag,intr_mag}<=intr1+intr2;
                sum[6:0]<=256-intr_mag;
                sum[7]<=1;
            end
        end 
        end
    end 
endmodule
