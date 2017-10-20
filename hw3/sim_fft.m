clear all;
close all;

% load sim output
vod_=cds_srr('../cadence/simulation/switch_cap_ckt_2/spectre/schematic/psf','tran-tran','vod');

% read into matlab variables
t    = vod_.time;
vod  = vod_.V;
N    = length(t)-1;

% if first and last point don't match within good precison, the fft data is garbage...
delta = vod(1)-vod(end)
if abs(delta)>1e-6
    disp('This looks like inaccurate fft data...');
    beep
end

spectrum = abs(fft(vod(2:end)));
spectrum = 2/N*spectrum(1:N/2+1);
spectrumdb = 20*log10(spectrum+eps);
frequency = 1/N * (0:length(spectrumdb)-1);

[fund, fundidx] = max(spectrum);
funddb=20*log10(fund);
spec_nodc_nofund = [spectrum(2:fundidx-1); spectrum(fundidx+1:end)];
[spur, spuridx] = max (spec_nodc_nofund);

sfdrdb = funddb-20*log10(spur);
sndr = norm(fund)/norm(spec_nodc_nofund);
sndrdb=20*log10(sndr);
funddb=20*log10(norm(fund));
nofunddb=20*log10(norm(spec_nodc_nofund));
norm(fund);
norm(spec_nodc_nofund);

figure(1);
plot(frequency, spectrumdb, '*-', 'linewidth', 2);
string = sprintf('Fundamental=%0.3gdBV, SNDR=%0.3gdB, SFDR=%0.3gdB', funddb, sndrdb, sfdrdb)
title(string);
xlabel('Frequency [f/fs]');
ylabel('Amplitude [dBV]');
axis([0 0.5 -120 0]);
grid;
%savefig('hw3_p6di.fig')
