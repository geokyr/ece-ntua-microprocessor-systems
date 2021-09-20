module gate_level (A, B, C, D, E, F)
    input A, B, C, D, E;
    output F;

    wire x1, notC, x2, y1, z1, w1;

    and(x1, D, C);
    not(notC, C);
    or(x2, notC, B);
    xor(y1, x1, A);
    and(z1, y1, B);
    or(w1, z1, x2);
    notif0(F, w1, E);
endmodule

module dataflow (A, B, C, D, E, F)
    input A, B, C, D, E;
    output F;

    assign x = D && C;
    assign y = (x ^ A) && B;
    assign z = ~C || B;
    assign w = y && z;
    assign F = E ? ~w : 1'bz;
endmodule