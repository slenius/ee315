% ee315 fall 2017
% homework 2 dac problem starter file
clear all;

% design choices 
% YOU MUST MODIFY THESE TWO VALUES!
Bt=3;         % Bt bits in unit element section
Aunit=109.65;     % Unit element area in um^2
%Bt = 9;
%Aunit = 223.15;

% fixed parameters
B=12;         % B bits total resolution
Bb=B-Bt;      % Bb bits binary weighted section
dnlspec=0.5;  % DNL specification
inlspec=0.5;  % INL specification
r=100;        % Number of Monte Carlo runs
ku=6e-2;      % Matching parameter (%-um)

% create random unit elements and break up into thermometer and binary weighted array
% mean=1, standare deviation = ku/sqrt(Aunit)
sigma = ku/sqrt(Aunit);
u= sigma*randn(r, 2^B-1) + 1;
u_bw= u(:, 1:2^Bb-1);
u_th= u(:, 2^Bb:end);

% for the bw array, construct a switch matrix of the form
% MSB.....LSB
%[ ... 000
%  ... 001
%  ... 010
%  ... 011
%  ... 100
%  ... ...]

bsm = zeros(2^Bb, Bb);
for i=1:2^Bb;
    for j=1:Bb
      if mod( floor((i-1)/2^(j-1)) ,2)
        bsm(i,end-j+1)=1;
       end   
    end        
end


% create r transfer functions
for m=1:r
  % assemble binary weights and binary array output codes
  bw = zeros(Bb,1);
  for i=1:Bb
    bw(end-i+1) = sum( u_bw(m, 2^(i-1):2^i-1) );
  end
  bw_codes= bsm*bw;

  % assemble output
  for i=1:2^B
    lsb = bw_codes( mod(i-1, 2^Bb)+1 );
    msbs_on = floor((i-1)/2^Bb);
    if msbs_on
      msb = sum( u_th(m,1:2^Bb*msbs_on) );
    else
      msb=0;
    end  
    code(m, i) = lsb + msb;
  end  
end;


% caculate inl
inl = zeros(r,2^B);
for m=1:r
  avg_width = (code(m, end)-code(m, 1))/(2^B-1);
  inl(m, :)=(code(m,:)-avg_width*[0:2^B-1])./avg_width;
end    

% inl scatter plot
figure(1); clf; hold on;
xlabel('Code');
ylabel('INL [LSB]');
axis([0 2^B-1 -(inlspec+0.05) (inlspec+0.05)]);
line([0 2^B-1], [inlspec inlspec]);
line([0 2^B-1], [-inlspec -inlspec]);

bad_dacs_inl=0;
for m=1:r
  figure(1);
  plot(0:2^B-1, inl(m,:));
  if find(abs(inl(m,:))>inlspec)
      bad_dacs_inl=bad_dacs_inl+1;
  end    
end

figure(1); hold off;
title( sprintf('INL envelope of %d runs. %d bad DAC(s) Bt=%d Au=%0.1fum^2', r, bad_dacs_inl, Bt, Aunit));

% inl rms plot
inl_rms = sqrt(sum( inl.^2, 1 ) ./r);
[maxinlrms imax] = max(inl_rms);
figure(2);
plot(0:2^B-1, inl_rms, imax, maxinlrms, '*');
xlabel('Code');
ylabel('INL [LSB]');
title( sprintf('RMS INL of %d runs. (max=%1.3fLSBrms) Bt=%d Au=%0.1fum^2', r, maxinlrms, Bt, Aunit));
axis([0 2^B-1 0 maxinlrms+0.01]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here

%   only turn in the code below (no need to turn in the given code above)

%   caculate dnl
dnl = zeros(r,(2^B)-1);
%step_avg = zeros(r,1);
for m=1:r
  d = diff(code(m,:));
  step_avg(m) = mean(d);
  dnl(m,:) = (d - step_avg(m)) ./ step_avg(m);
  %avg_width = (code(m, end)-code(m, 1))/(2^B-1);
  %inl(m, :)=(code(m,:)-avg_width*[0:2^B-1])./avg_width;
end  

%   dnl scatter plot

%   dnl rms plot

% dnl scatter plot
figure(3); clf; hold on;
xlabel('Code');
ylabel('DNL [LSB]');
axis([0 2^B-1 -(dnlspec+0.05) (dnlspec+0.05)]);
line([0 2^B-1], [dnlspec dnlspec]);
line([0 2^B-1], [-dnlspec -dnlspec]);

bad_dacs_dnl=0;
for m=1:r
  figure(3);
  plot(0:2^B-2, dnl(m,:));
  if find(abs(dnl(m,:))>dnlspec)
      bad_dacs_dnl=bad_dacs_dnl+1;
  end    
end
figure(3); hold off;
title( sprintf('DNL envelope of %d runs. %d bad DAC(s) Bt=%d Au=%0.1fum^2', r, bad_dacs_dnl, Bt, Aunit));

% dnl rms plot
dnl_rms = sqrt(sum( dnl.^2, 1 ) ./r);
[maxdnlrms dmax] = max(dnl_rms);
h = figure();
plot(0:2^B-2, dnl_rms, dmax, maxdnlrms, '*');
xlabel('Code');
ylabel('DNL [LSB]');
title( sprintf('RMS DNL of %d runs. (max=%1.3fLSBrms) Bt=%d Au=%0.1fum^2', r, maxdnlrms, Bt, Aunit));
axis([0 2^B-1 0 maxdnlrms+0.01]);
