function outx = sinusx(in,f,n)
%
% Extraction of a sinusoidal signal
%
x = 1:n;
sinx=sin(2*pi*f.*x);
cosx=cos(2*pi*f.*x);
in=in(1:n);
a1=2*sinx.*in;
a=sum(a1)/n;
b1=2*cosx.*in;
b=sum(b1)/n;
outx=a.*sinx + b.*cosx;