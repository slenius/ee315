%clear all
%close all

n = 10000;
lims = [-1.0 1.0];
ramp = linspace(min(lims)*1.2, max(lims)*1.2, n);
t = linspace(0, 1, n);

bits = 4;

fsr = range(lims);
offset = mean(lims);
codes = 2^bits;
delta = fsr ./ codes;

q = mid_rise_quant(ramp, bits, lims);

err = q - ramp;

figure;

subplot(2,1,1);
hold on
plot(ramp, ramp);
plot(ramp, q);
ylabel('Output Voltage');
title('Q6a - 4 Bit Mid Rise Quantizer Transfer Function')

subplot(2,1,2);
plot(ramp, err);
ylabel('Quantization Error');
xlabel('Input Voltage');


nx = 1:n;

%x = sin(2*pi *0.117*nx);
x = rand(n,1)*2 - 1;
qx = mid_rise_quant(x, bits, lims);
qxerr = qx - x;


pqx = var(qxerr);
pqx_est = delta^2 / 12;

q_6_b_1 = pqx*1000
q_6_b_2 = pqx_est * 1000
q_6_b_3 = deviation(pqx, pqx_est) 

figure;
plot(nx, x);
hold on;
plot(nx, qx, '*');


bits = 2:18;
dev = zeros(1,17);
pqx = zeros(1,17);
pqx_est = zeros(1,17);

for i = 1:length(bits)

  codes = 2^bits(i);
  delta = fsr ./ codes;
  qx = mid_rise_quant(x, bits(i), lims);
  qxerr = qx - x;
  pqx(i) = var(qxerr);
  pqx_est(i) = delta^2 / 12;
  dev_rand(i) = deviation(pqx(i), pqx_est(i));
end


figure;
plot(bits, dev_sine);
hold on;
plot(bits, dev_rand);
xlabel('Bits of Resolution');
ylabel('Percent Deviation');
title('Q6 Quantization Error Estimation vs Bit Resolution')
legend('Sine Input', 'Random Input')