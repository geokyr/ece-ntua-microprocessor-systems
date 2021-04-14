// Mealy Machine

module Mealy_Model(y, x, clock, reset);   
    output [1:0] y;
    input x, clock, reset;
    reg [1:0] state;
    parameter a = 2'b00, b = 2'b01, c = 2'b10, d = 2'b11;
    always @(posedge clock, negedge reset)
    if (reset == 0) state <= a;
    else case(state)
    a: if(x) state <= a; else state <= d;
    b: if(x) state <= a; else state <= c;
    c: if(x) state <= d; else state <= b;
    d: if(x) state <= d; else state <= c;
    endcase
    assign y = (state[1] & state[0] & x) | (~state[0] & ~x) | 
               (~state[1] & x);
endmodule