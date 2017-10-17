function r = my_thd(x, fs, n_harm)
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
  
  % calculate the power of the fundamental and n harmonics
  for harmonic = 1:n_harm
    h_idx = harmonic * f_idx;
    p_h(harmonic) = bandpower(psd, f, [f(h_idx-harmonic) f(h_idx+harmonic)], 'psd');
  end

  r = 100 * sqrt(sum(p_h(2:end)) / p_h(1));
end