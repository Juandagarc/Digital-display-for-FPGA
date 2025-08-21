module translator (
    input  wire [9:0] binary_in,
    output reg  [15:0] bcd_out
);

    integer i, j;
    reg [15:0] bcd_temp;
    reg [9:0]  bin_temp;

    always @(*) begin
        bcd_temp = 16'd0;
        bin_temp = binary_in;
        
        for (i = 0; i < 10; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                if (bcd_temp[j*4 +: 4] > 4) begin
                    bcd_temp[j*4 +: 4] = bcd_temp[j*4 +: 4] + 3;
                end
            end
            
            bcd_temp = {bcd_temp[14:0], bin_temp[9]}; 
            bin_temp = {bin_temp[8:0], 1'b0};
        end
        
        bcd_out = bcd_temp;

    end

endmodule