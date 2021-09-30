module mux2x1 (
    output [3:0] out,
    input [3:0] C, D,
    input select
);

tri out;
bufif0(out, C, select);
bufif1(out, D, select);

endmodule

module LU (
    output [3:0] X,
    input [3:0] A, B,
    input [1:0] C
);
wire w1, w2, w3, w4;

or G1(w1, A, B);
and G2(w2, A, B);
mux2x1 C1(w3, 4'b1111, 4'b0000, C[1]);
mux2x1 C2(w4, w1, w2, C[1]);
mux2x1 C3(X, w3, w4, C[0]);
endmodule