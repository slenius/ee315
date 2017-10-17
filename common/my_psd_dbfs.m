function [s_dbfs, f] = my_psd_dbfs(x, fs, N)

  % Compute periodogram
  [psd, f] = periodogram(x, rectwin(N), N, fs);
  
  % Convert to decimals
  psd_db = 10*log10(psd);
  
  % Normalize to 0dB
  s_dbfs = psd_db - max(psd_db);
  
  % FFT based method
  %s = abs(fft(x));
  %s = s/(N/2);
  %s = s(1:N/2);
  %s_dbfs = 20*log10(s);
  %f = my_fft_freq(fs, N);
  
end