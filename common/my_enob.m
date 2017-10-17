function enob = my_enob(x, fs)
  % inputs
  % x - signal (vector)
  % fs - sample frequency (scalar)
  
  enob = (my_snr(x, fs, 6) - 1.76) / 6.02;
end