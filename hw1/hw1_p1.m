clear all
close all



% from wikipedia
% https://en.wikipedia.org/wiki/Quantization_(signal_processing)#Mid-riser_and_mid-tread_uniform_quantizers


delta = 1;
bits = 5;
range = 1000;
lsb_v = range / (2^bits);

x = bin2dec('10001');
q_mid_rise = delta * (floor(x / delta) + 0.5);
q_mid_rise_min = q_mid_rise * lsb_v - lsb_v/2;
q_mid_rise_max = q_mid_rise * lsb_v + lsb_v/2;

x = bin2dec('10010');
q_mid_tread = delta * (floor((x / delta) + 0.5));
q_mid_tread_min = q_mid_tread * lsb_v - lsb_v/2;
q_mid_tread_max = q_mid_tread * lsb_v + lsb_v/2;

x = bin2dec('10100');
q_mid_tread_cmp = delta * (floor((x / delta) + 0.5));
q_mid_tread_cmp_min = q_mid_tread_cmp * lsb_v - lsb_v/2;
q_mid_tread_cmp_max = q_mid_tread_cmp * lsb_v + lsb_v/2;

x = bin2dec(gray2bin('01101'));
q_mid_rise_gray = delta * (floor(x / delta) + 0.5);
q_mid_rise_gray_min = q_mid_rise_gray * lsb_v - lsb_v/2;
q_mid_rise_gray_max = q_mid_rise_gray * lsb_v + lsb_v/2;
