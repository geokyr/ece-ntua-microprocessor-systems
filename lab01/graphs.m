x = 1:1:70000;

a = log(20000./x + 20);
b = log(10000./x + 40);
c = log(100000./x + 4);
d = log(200000./x + 2);

figure(1);
plot(x, a, "linewidth", 1.2, x, b, "linewidth", 1.2, x, c, "linewidth", 1.2, x, d, "linewidth", 1.2);
set(gca, "linewidth", 1.2, "fontsize", 12)
xlabel("Number of pieces");
ylabel("Cost per piece");
title("Cost per piece graphs on logarithmic scale");
legend("Technology 1", "Technology 2", "Technology 3", "Technology 4");

e = 20.*x + 20000;
f = 40.*x + 10000;
g = 4.*x + 100000;
h = 2.*x + 200000;

figure(2);
plot(x, e, "linewidth", 1.2, x, f, "linewidth", 1.2, x, g, "linewidth", 1.2, x, h, "linewidth", 1.2);
set(gca, "linewidth", 1.2, "fontsize", 12)
xlabel("Number of pieces");
ylabel("Total cost");
title("Total cost graphs");
legend("Technology 1", "Technology 2", "Technology 3", "Technology 4");

i = 21.*x + 10000;

figure(3);
plot(x, e, "linewidth", 1.2, x, i, "linewidth", 1.2, x, g, "linewidth", 1.2, x, h, "linewidth", 1.2);
set(gca, "linewidth", 1.2, "fontsize", 12)
xlabel("Number of pieces");
ylabel("Total cost");
title("Total cost graphs with new FPGA Technology");
legend("Technology 1", "New Technology 2", "Technology 3", "Technology 4");