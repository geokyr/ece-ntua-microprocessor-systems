// F1 = A(BC + D) + B’C’D’

module circuit_A (A, B, C, D, F1);
    input A, B, C, D;
    output F1;
    wire notB, notC, w, x, y, z;
    not(notC, C);
    not(notB, B);
    and(x, notC, notB, D);
    and(w, C, B);
    or(z, w, D);
    and(y, z, A);
    or(F1, x, y);
endmodule

// F2(A, B, C, D) = Σ (0, 2, 3, 5, 7, 9, 10, 11, 13, 14)

module circuit_B (A, B, C, D, F2);
    input A, B, C, D;
    output F2;
    wire notB, notC, notD, notA, a, b, c, d, e, f, g, h, i, k;
    not(notC, C);
    not(notB, B);
    not(notA, A);
    not(notD, D);
    and(a, notA, notB, notC, notD); 	//0
    and(b, notA, notB, C, notD);    	//2
    and(c, notA, notB, C, D);       	//3
    and(d, notA, B, notC, D);       	//5
    and(e, notA, B, C, D);          	//7
    and(f, A, notB, notC, D);       	//9
    and(g, A, notB, C, notD);       	//10
    and(h, A, notB, C, D);      		//11
    and(i, A, B, notC, D);          	//13
    and(k, A, B, C, notD);          	//14
    or(F2, a, b, c, d, e, f, g, h, i, k);
endmodule

// F3 = ABC + (A + BC)D + (B + C)DE

module circuit_C (A, B, C, D, E, F3);
    input A, B, C, D ,E;
    output F3;
    wire a, b, c, d, e, f, g;
    and(a, A, B, C);
    and(b, B, C);
    or(c, A, b);
    and(d, D, c);
    or(e, B, C);
    and(f, D, E);
    and(g, f ,e);
    or(F3, a, d, g);
endmodule

// F4 = A(B + CD + E) + BCDE

module circuit_D (A, B, C, D, E, F4);
    input A, B, C, D, E;
    output F4;
    wire a, b, c, d;
    and(a, C, D);
    or(b, B, a, E);
    and(c, A, b);
    and(d, B, C, D, E);
    or(F4, c, d);
endmodule

// Dataflow

module dataFlow(A, B, C, D, E, F1, F2, F3);
	    input A, B, C, D, E;
    output F1, F2, F3;
    assign
        F1 = (A & ((B & C) | D)) | (~A & ~B & D) ,

        F2 = (~A & ~B & ~C & ~D) | (~A & ~B & C & ~D) | 
             (~A & ~B & C & D) | (~A & B & ~C & D) | 
             (~A & B & C & D) | (A & ~B & ~C & D) | 
             (A & ~B & C & ~D) | (A & ~B & C & D) | 
             (A & B & ~C & D) | (A & B & C & ~D),

        F3 = (A & B & C) | ((A | (B & C)) & D) | ((B | C) & D & E),

        F4 = (A & (B | (C & D) | E)) | (B & C & D & E);
endmodule