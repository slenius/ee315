function q = mid_tread_quant(v, bits, lims)
% https://en.wikipedia.org/wiki/Quantization_(signal_processing)#Mid-riser_and_mid-tread_uniform_quantizers

fsr = range(lims);
offset = mean(lims);
codes = double(2^bits);
delta = fsr ./ codes;
q = delta * (floor(v / delta) + 0.5);
q(q<=min(lims)+delta/2) = min(lims)+delta/2;
q(q>=max(lims)-delta/2) = max(lims)-delta/2;
