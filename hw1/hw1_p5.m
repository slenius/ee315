clear all
close all

n = 10000;
lims = [-4.5 3.5];
%lims = [0, 2];
ramp = linspace(min(lims), max(lims), n);
t = linspace(0, 1, n);

bits = 3;
codes = 2^bits;



fsr = range(lims);
offset = mean(lims);

%q = mid_tread_quant(ramp, bits, lims);
q = broken_3_bit_quant(ramp, bits, lims);

err = q - ramp;

figure();
plot(ramp, ramp)
hold on
plot(ramp, q)

figure();
plot(t, err)

p_err = var(err)


