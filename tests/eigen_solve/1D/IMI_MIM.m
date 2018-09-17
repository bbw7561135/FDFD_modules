close all
clear
L0 = 1e-6;

Nx = 500; 
eps0 = 8.854e-12*L0;
eps_diel = 16;
eps_r = eps_diel*ones(Nx,1);
c0 = 3e8;

n = 13;
lattice_constant = 1; 
Lx = lattice_constant; % microns

dx = Lx/Nx; % in microns;
xrange = [-Lx,Lx]/2;
x = linspace(xrange(1), xrange(2), Nx);
yrange = [0,0];

%omega units must be units of L0

%% drude
omega_p = 0.72*pi*1e15;
gamma = 5.5e12;
ky_eigs_store = []; ky_eigs_2 = [];
epsilon_tracker = [];
omega_scan = linspace(1e13, 1.2*omega_p, 100);
c = 0;
Npml = 50;
for omega = linspace(1e13, 1.2*omega_p, 100)
    eps_drude = 1; %1-omega_p^2/(omega^2-1i*gamma*omega);
    epsilon_tracker = [epsilon_tracker, eps_drude];
    eps_r(.4*Nx:.6*Nx) =  eps_drude;
    wvlen = 2*pi*c0/omega*1e6;
    [Hz, ky_eigs_c,A, Dxf, Sxf] = FDFD_1D_Ky_eigensolve(L0, dx, eps_r, omega, Nx, n, Npml);
    if(c<5 && c> 2)
       figure();
       for i = 1:n
            plot(x, real(Hz{i}))
            hold on;
       end
       drawnow();
    end
    ky_eigs_store = [ky_eigs_store,  ky_eigs_c];
    c=c+1;
    
end

figure();
for i = 1:2
    scatter(real(ky_eigs_store(i,:)), omega_scan./(2*pi*c0)*1e-6, '.b')
    hold on;
    scatter(abs(imag(ky_eigs_store(i,:))), omega_scan./(2*pi*c0)*1e-6, '.r')
end

ky_space = linspace(0,60, Nx);
hold on;
omega_med = c0*ky_space/sqrt(eps_diel)/((2*pi*c0));
omega_light = c0*ky_space/((2*pi*c0));

%% plot various light lines
plot(ky_space, omega_med)
plot(ky_space, omega_light);

%% get the plasmon cutoffs
line([0, max(ky_space)], [omega_p, omega_p]/(2*pi*c0)*1e-6)
line([0, max(ky_space)], [omega_p, omega_p]/(2*pi*c0)*1e-6/sqrt(eps_diel+1))


ylabel('frequency/(2*pi*c0)')
xlabel('ky (\mu m^-1)')
title('FDFD IMI even parity band')
legend('real', 'imaginary')


%% plot the skin depth versus depth of actual structure
lambda_scan = 2*pi*c0./omega_scan;
figure();
plot(lambda_scan,(abs(1./imag(ky_eigs_store(1,:)))), 'r', 'linewidth', 2)
hold on
line([0, max(lambda_scan)],([0.2, 0.2]),'color', 'b')
line([1.1,1.1]/1e6,[0,10],'color','g')
line([2.5,2.5]/1e6,[0,10], 'color', 'g')
xlim([0.9, 2.7]/1e6);
ylim([0,1])
xlabel('wavelength')
ylabel('skin depth (microns)')
title('skin depth versus structure thickness')
legend('skin depth', 'structure thickness', 'actual stopgap')

%% SPP
eps2 = eps_diel;
eps1 = 1-omega_p^2./(omega_scan.^2-1i*gamma*omega_scan);
kx = (omega_scan/c0).*sqrt((eps1*eps2)./(eps1+eps2));
N_lossless = sqrt(1-omega_p^2./(omega_scan.^2));
N = sqrt(eps1);
metal_depth = lambda_scan./(2*pi*abs(imag(N)))*1e6;
depth = 1./abs(imag(kx)/1e6);
depth_lossless_metal = lambda_scan./(2*pi*abs(imag(N_lossless)))*1e6;

%% Drude


%% plot the skin depth versus SPP and drude;
lambda_scan = 2*pi*c0./omega_scan;
figure();
plot(lambda_scan/1e-6,(abs(1./imag(ky_eigs_store(1,:)))), 'm', 'linewidth', 2)
hold on
plot(lambda_scan/1e-6,depth, 'linewidth', 1.5)
hold on;
plot(lambda_scan/1e-6, (metal_depth), '.r', 'markersize',20);
plot(lambda_scan/1e-6, (depth_lossless_metal), '.g', 'markersize', 10);


xlim([0.5, 4]);
ylim([0,0.5])
xlabel('wavelength')
ylabel('penetration depth (microns)')
title('Penetration Depth of IMI versus Analytic Systems')

legend('IMI', 'SPP', 'metal', 'lossless metal')
figure();
plot(omega_scan,(abs(1./imag(ky_eigs_store(1,:)))), 'm', 'linewidth', 2)
hold on
plot(omega_scan/1e-6,depth, 'linewidth', 1.5)
hold on;
plot(omega_scan/1e-6, (metal_depth), '.r', 'markersize',20);
plot(omega_scan/1e-6, (depth_lossless_metal), '.g', 'markersize', 10);


ylim([0,0.5])
xlabel('frequency')
ylabel('penetration depth (microns)')
title('Penetration Depth of IMI versus Analytic Systems')

legend('IMI', 'SPP', 'metal', 'lossless metal')


%% get the penetration depths
eps1 =  1-omega_p^2./(omega_scan.^2-1i*gamma*omega);

k0_scan = 2*pi./lambda_scan;
kzm = sqrt(k0_scan.^2.*eps1 - (ky_eigs_store).^2);
kzd = sqrt(k0_scan.^2.*eps_diel - (ky_eigs_store).^2);
figure();
plot(lambda_scan/L0, 1./imag(kzm)*L0);
hold on;
plot(lambda_scan/L0, 1./imag(kzd)*L0);
xlabel('wvlen')
ylabel('penetration (microns)')
legend('metal', 'dielectric')
xlim([1,2.7])
ylim([0,1])