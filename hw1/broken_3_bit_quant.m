function q = mid_tread_quant(v, bits, lims)
% https://en.wikipedia.org/wiki/Quantization_(signal_processing)#Mid-riser_and_mid-tread_uniform_quantizers

q = mid_tread_quant(v, bits, lims);

q(q==0) = -1;
q(q==1) = -1;
