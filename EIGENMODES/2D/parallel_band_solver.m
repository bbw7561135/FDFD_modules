%% test script for TM Ex Ey eigensolve

close all
clear

%% Set up the domain parameters.
L0 = 1e-6;  % length unit: microns
mu0 = 4*pi*1e-7*L0;
eps0 = 8.854e-12*L0;
c0 = 1/sqrt(eps0*mu0);
num_cells = 2;
xrange = num_cells* 0.1*[-1,1];  % x boundaries in L0
yrange = 1.6*[-1,1];  % y boundaries in L0
L = [diff(xrange), diff(yrange)];
N = [100 160];  % [Nx Ny]
Npml = 1*[0 10];  % [Nx_pml Ny_pml]

[xrange, yrange, N, dL, Lpml] = domain_with_pml(xrange, yrange, N, Npml);  % domain is expanded to include PML
Nx = N(1); Ny = N(2);
cx = round(Nx/2); cy = round(Ny/2);
num_samples = 4;
wvlen_scan = logspace(log10(0.5),log10(4),num_samples);
omega_p =  0.72*pi*1e15;
gamma = 5.5e12;

Kx_structure = cell(1);
mode_storage = cell(1); mode_mod = 10;
omega_scan = 2*pi*c0./wvlen_scan;

parfor c = 1:num_samples
    
    wvlen = wvlen_scan(c)
    %% Set up the permittivity.
    omega = 2*pi*c0/(wvlen);

    epsilon_metal = 1-omega_p^2/(omega^2+1i*gamma*omega);
    epsilon_diel = 16; %epsilon_metal;
    epsilon_diel = epsilon_metal;
    fill_factor = 0.2;
    thickness = 0.3;
    eps = ones(N);
    y_grid_center = L(2)/2;
    y_center = y_grid_center-1;
    eps = hybrid_grating_multi_unit_cell_add(eps,num_cells, N, L, epsilon_diel,...
        epsilon_metal, fill_factor, thickness, y_center);
    y_center = y_grid_center+1;
    eps = hybrid_grating_multi_unit_cell_add(eps,num_cells, N, L, epsilon_diel,...
        epsilon_metal, fill_factor, thickness, y_center);
    xbounds = xrange;
    ybounds = [-1-thickness/2, 1+thickness/2];

    %% eigensolve
    neigs = 60;
    kx_guess = 0*pi/L(1);
    [Ez_modes, Hx_modes, Hy_modes, kx_eigs] = ...
        eigensolve_TM_dispersive_Kx(L0, omega, xrange, yrange, eps, Npml, neigs, kx_guess);
   
    %% apply the filter
    [filtered_modes, filtered_k, mask] = ...
        mode_filtering(Ez_modes, kx_eigs, eps, xbounds, ybounds, L, Npml, 1e-2);
    %filtered_modes = Ez_modes; filtered_k = kx_eigs;
     %% store the requisite data

    if(mod(c,mode_mod) == 0)
        mode_storage{c} = filered_modes;
    end
    Kx_structure{c} = filtered_k;

end

f = figure();
kx_scan = linspace(0, pi/L(1), 1000);
omega_light = c0*kx_scan;
hold on;
plot(kx_scan*L(1)/(2*pi), omega_light);

for i = 1:num_samples
    Kx = Kx_structure{i};
    subplot(121)
    plot(real(Kx)*L(1)/(2*pi), omega_scan(i), '.b');
    xlabel('real K')
    ylabel('omega (rad/s)')
    hold on;
    
    subplot(122)
    plot(real(Kx)*L(1)/(2*pi), omega_scan(i), '.r');
    xlabel('imag K')
    ylabel('omega (rad/s)')
    hold on;
end
plot(kx_scan*L(1)/(2*pi), omega_light);
savefig(f,'dispersive_band_structure.fig')

save('hollow_core_band_solve.mat')

% figure();
% moviereal(filtered_modes{2}, xrange, yrange)

