clear all
close all


spectre = '/afs/ir.stanford.edu/class/ee/cadence/MMSIM10/tools/spectre/matlab';

old_path = path;
path(old_path, spectre);

data_dir = '../cadence/simulation/switch_cap_ckt/spectre/schematic/psf';

s = cds_srr(data_dir, 'tran-tran', 'vod');
vod = s.V;
t_ns = s.time*1e9;

s = cds_srr(data_dir, 'tran-tran', 'vid');
vid = s.V;

s = cds_srr(data_dir, 'tran-tran', 'p1');
phi_1 = s.V;

s = cds_srr(data_dir, 'tran-tran', 'p1e');
phi_1_early = s.V;

s = cds_srr(data_dir, 'tran-tran', 'p2');
phi_2 = s.V;


figure();
plot(t_ns, vid);
hold on;
plot(t_ns, vod);

phi_1 = phi_1 * 0.005/1.8 - 0.01;
phi_1_early = phi_1_early * 0.005/1.8 - 0.016;
phi_2 = phi_2 * 0.005/1.8 - 0.022;

plot(t_ns, phi_1);
plot(t_ns, phi_1_early);
plot(t_ns, phi_2);

xlim([-1 51]);
ylim([-0.025, 0.012]);
xlabel('Time (ns)');
ylabel('Voltage');
legend('Vid', 'Vod', '\phi1', '\phi1e', '\phi2');

title('HW3 P6a');

savefig('hw3_p6a.fig');



