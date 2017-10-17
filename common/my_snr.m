function r = my_snr(x, fs, n_harm)
  % inputs
  % x - signal (vector)
  % fs - sample frequency (scalar)
  % n_harm - number of harmonics to remove
  
  % calculate fft in decibels from signal
  N = length(x);
  
  % calculate the psd with a rectangular window
  [psd, f] = periodogram(x, rectwin(N), N, fs);
  
  % find the fundamental
  [~, f_idx] = max(psd);
  fundamental_freq = f(f_idx);


  % remove the fundamental an n harmonics
  psdn = psd;
  for harmonic = 1:n_harm
    harm_f = harmonic * fundamental_freq;
    harm_idx = harmonic * f_idx;
    for i = harm_idx-harmonic:harm_idx+harmonic
      psdn(i) = median(psd);
    end
  end
  
  %psd_db = 10*log10(psd);
  %psdn_db = 10*log10(psdn);
 
  sig_pwr = bandpower(psd, f, 'psd');
  noise_pwr = bandpower(psdn, f, 'psd');
  r = 10*log10(sig_pwr / noise_pwr);
  
end