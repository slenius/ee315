clear all
close all

load('hw3_adc_out.mat');

per = 1/fs;
d = adc_output_data_time_domain';


N = length(d);
end_t = per * (N-1);
t = 0:per:end_t;

[s_dbfs, f] = my_psd_dbfs(d, fs, N);

% find frequency from max index of the s array
[val, idx] = max(s_dbfs);
input_freq = f(idx);
fprintf('Input Frequency = %f MHz\n', input_freq/1e6);

figure();

plot(f/1e6, s_dbfs)

title('HW3 P2a');
ylabel('dBFS');
xlabel('Frequency (MHz)')
%x_tick_label = get(gca,'xtick');
%set(gca,'XTickLabel',x_tick_label);

% compute SNR
fprintf('Ref SNR: %0.3fdB\n', snr(d, fs, 6));
fprintf('My SNR: %0.3fdB\n', my_snr(d, fs, 6));

% compute sndr
fprintf('Ref SNDR: %0.3fdB\n', sinad(d, fs));
fprintf('My SNDR: %0.3fdB\n', my_sndr(d, fs));

% compute enob
fprintf('ENOB: %0.3f Bits\n', my_enob(d, fs));

% compute THD
fprintf('Ref THD: %0.3f%%\n', 100 * sqrt(10 ^ (thd(d, fs, 6) / 10)));
fprintf('My THD: %0.3f%%\n', my_thd(d, fs, 6));

% compute SFDR
fprintf('Ref SFDR: %0.3fdB\n', sfdr(d, fs, 6));
fprintf('My SFDR: %0.3fdB\n', my_sfdr(d, fs, 6));

