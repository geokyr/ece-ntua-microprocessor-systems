// 4 bit adder subber unsigned

module half_adder(S, C, x, y); 
    input x, y;
    output S, C;
    xor(S, x, y); 
    and(C, x, y); 
endmodule

module full_adder(S, C, x, y, z);
    input x, y, z;
    output  S, C;
    wire S1, C1, C2; 
    half_adder HA1(S1, C1, x, y); 
    half_adder HA2(S, C2, C1, z); 
    or G1(C, C2, C1); 
endmodule

module _4_bit_add_sub(S, C, V, A, B, C0);
    input C0;
    input [3:0] A, B;
    output C, V;
    output [3:0] S;
    wire C1, C2, C3; 
    wire w0, w1, w2, w3; 
    xor G1(w0, B[0], C0); 
    xor G2(w1, B[1], C0); 
    xor G3(w2, B[2], C0); 
    xor G4(w3, B[3], C0); 
    full_adder FA0 (S[0], C1, w0, A[0], C0); 
    full_adder FA1 (S[1], C2, w1, A[1], C1); 
    full_adder FA2 (S[2], C3, w2, A[2], C2); 
    full_adder FA3 (S[3], C, w3, A[3], C3); 
    xor G5(V, C, C3); 
endmodule

// Dataflow

module add_sub (S, C, A, B, C0); 
    output [3: 0] S; 
    output C; 
    input [3: 0] A, B; 
    input C0;
    assign {C, S} = C0 ? A - B : A + B ; 
endmodule