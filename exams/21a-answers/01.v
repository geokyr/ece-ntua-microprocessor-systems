module verilog(F, A, B, C, D, E);
    output F;
    input A, B, C, D, E;
    wire w1, w2, w3, w4, w5, w6;

    not G1 (w1, C);
    and
        G2 (w2, D, C),
        G3 (w3, B, w1);
    
    xor G4 (w4, w2, B);
    and G5 (w5, A, w4);
    or G6 (w6, w5, w3);
    notif(F, w6, Ε);
endmodule

// --------------------

module verilog(F, A, B, C, D, E);
    output F;
    input A, B, C, D, E;
    assign F = (E)?(~((((D&C)^B)&A)|(B&(~C)))):1'bz;
endmodule