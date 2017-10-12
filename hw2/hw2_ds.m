% First-order, single-bit Delta-Sigma Modulator
% Code is incomplete.
clear all;
close all;

N = 2^12;
%X = 0.8;
samp = 1:N;
cycles = 50;
X = 0.5*sin(cycles*2*pi*samp./(N));
I = zeros(N,1);
Y = ones(N,1);

% Delta-Sigma Block
for i = 1:N-1
    if i > 1
        I(i) = I(i-1) + X(i) - Y(i);
    else
        I(i) = X(i) - Y(i);
    end
    if (I(i) < 0)  
        Y(i+1) = -1;
    else
        Y(i+1) = 1;
    end
end

% Calculate Running Average (W) of output
% Enter Code here:
W = zeros(N,1);
for i = 1:N-1
    W(i) = mean(Y(1:i));
end


% Plot Output
figure(1);
stairs(Y, 'b-');
hold on;
stairs(W,'r-');
stairs(X, 'm-');
%stairs(I,'m-');
legend('Digital Output (Y)', 'Running Average (W)', 'Input (X)');
axis([0 N -1.2 1.2]);
xlabel('Sample Number')
grid on;
title('HW2 P2a');

s = abs(fft(Y));
s = s/(N/2);
s = s(1:N/2);
s_dbfs = 20*log10(s);

figure(2);
f = (1:N/2) ./ (N/2);
semilogx(f, s_dbfs, '-')
title('HW2 P2c');
ylabel('dBFS');
xlabel('Normalized Frequency')

%total_power = sum(s(1:N/(2*20)));

