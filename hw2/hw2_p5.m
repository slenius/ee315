clear all
close all

inl_spec = 0.5;
dnl_spec = 0.5;
yield_spec = 0.95;
k_u = 0.06;
b = 12;



for i = 1:b+1
  
  b_b(i) = b+1 - i;
  b_t(i) = i-1;
  
  yield_unit(i) = yield_spec^(1/(2^b_t(i)));
  C(i) = sqrt(2) * erfinv(yield_unit(i));
  
  %sigma_unit = dnl_spec / C;
  sigma_unit_dnl(i) = dnl_spec / (C(i)*sqrt(2^(b_b(i)+1)-1));
  sigma_unit_inl(i) = 2*inl_spec / (C(i)*sqrt(2^b));
  sigma_unit(i) = min(sigma_unit_dnl(i), sigma_unit_inl(i));
  a_unit_inl(i) = (k_u / (sigma_unit_inl(i)))^2;
  a_unit_dnl(i) = (k_u / (sigma_unit_dnl(i)))^2;
  a_unit(i) = (k_u / (sigma_unit(i)))^2;
    
  if b_t(i) == 0
    a_decode(i) = 0;
  else
    a_decode(i) = 2^b_t(i) * 2000;
  end
  
  a_total(i) = a_unit(i) * 2^b + a_decode(i);
  
  
end

figure;
semilogy(b_t, 1e-6*a_decode);
hold on;
semilogy(b_t, 1e-6*a_unit_dnl*2^b);
semilogy(b_t, 1e-6*a_unit_inl*2^b);
semilogy(b_t, 1e-6*a_total);
xlabel('Thermometer Bits');
ylabel('Area Required (mm^2)');

legend('Decoder Area', 'DNL Required Area', 'INL Required Area', 'Total');