clear all
close all


spectre = '/afs/ir.stanford.edu/class/ee/cadence/MMSIM10/tools/spectre/matlab';

old_path = path;
path(old_path, spectre);

data_dir = '../cadence/simulation/p3/spectre/schematic/psf';

s = cds_srr(data_dir, 'dc-dc', 'MN:gds')
g_ds_n = s.S;
r_ds_n = 1 ./ g_ds_n;

s = cds_srr(data_dir, 'dc-dc', 'MP:gds')
g_ds_p = s.S;
r_ds_p = 1 ./ g_ds_p;

r_par = 1 ./ (1./r_ds_p + 1./r_ds_n);

v_in = s.vin;

figure;
plot(v_in, r_ds_n, 'b-');
hold on;
plot(v_in, r_ds_p, 'r-');
plot(v_in, r_par, 'm-');

ylim([0, 1000]);

ylabel('RDS Resistance (Ohms)');
xlabel('Input Voltage (V)');
legend('MN', 'MP', 'MN || MP');
savefig('hw3_p3b.fig')

% Output table
fprintf('r on (MN) @ V in =0V: %f\n', r_ds_n(1))
fprintf('r on (MN||MP) @ V in =0V: %f\n', r_par(1))
fprintf('r on (MP) @ V in =V DD: %f\n', r_ds_p(end))
fprintf('r on (MN||MP) @ V in =V DD: %f\n', r_par(end))
fprintf('Maximum r on (MN||MP) within V in =0...V DD: %f\n', max(r_par))


