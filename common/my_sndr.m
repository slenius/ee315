function r = my_sndr(x, fs)
  % inputs
  % x - signal (vector)
  % fs - sample frequency (scalar)
  
  % calculate fft in decibels from signal
  N = length(x);
  
  % window function to use - matlab uses hamming by default
  window = hamming(N);
  %window = rectwin(N);
  
  % calculate the psd with a rectangular window
  [psd, f] = periodogram(x, window, N, fs);
  
  % find the fundamental
  [~, f_idx] = max(psd);
  fundamental_freq = f(f_idx);

  % remove the fundamental
  psdn = psd;
  for i = f_idx-1:f_idx+1
    psdn(i) = median(psd);
  end
  
  %psd_db = 10*log10(psd);
  %psdn_db = 10*log10(psdn);
 
  sig_pwr = bandpower(psd, f, 'psd');
  noise_pwr = bandpower(psdn, f, 'psd');
  r = 10*log10(sig_pwr / noise_pwr);
  
end