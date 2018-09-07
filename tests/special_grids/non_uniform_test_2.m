close all
clear

%% testing the non-uniform mesh in real FDFD simulations


%% Set up the domain parameters.
L0 = 1e-6;  % length unit: microns
c0 = 3e8;

%% non-uniform grid specification
% 1) partition into coarse vs fine (vs pml)
% along a line, it looks like Ncoarse, Nfine, Ncoarse
% in this construction scheme, we actually do not set the full domain size
% in the initial case

Nfine = [100,100]; %specify nx, ny for each region
Ncoarse = [50,50];
Ntran =   [10,10];
% 2) specify the dx and dy of each region
dx1 = 0.02; dy1 = 0.02;
dx2 = 0.01; dy2 = 0.01;
dfine = [dx2, dy2];
dcoarse = [dx1, dy1];
dtran = [0 ,0];

% 3) stack the vectors
% drt does not have a value...
Nft = vertcat(Ncoarse, Ntran, Nfine, Ntran, Ncoarse);
drt = vertcat(dcoarse, dtran, dfine, dtran, dcoarse);

% 4) construct scaling vectors from this information
[dx_scale, dy_scale] = generate_nonuniform_scaling(Nft, drt);

%% calculate Ntot and Ltot
N = sum(Nft);
L = Ntot.*sum(drt);
xrange = 0.5*[-L, L];
yrange = 0.5*[-L, L];

%% output is a dxscale...dyscale



%% Set up the permittivity.
wvlen = 1;
omega = 2*pi*c0/wvlen*1e6;
eps = ones(N);
eps(50:150, 50:150) = 6;

%% Set up the magnetic current source density.
Mz = zeros(N);
ind_src = [round(Nx/2),round(Ny/2)];  % (i,j) indices of the center cell; Nx, Ny should be odd
Mz(ind_src(1), ind_src(2)) = 1;

%% Solve TE (photonic), TM (practical), depends on convention equations.
tic
[Hz, Ex, Ey, A_nu,b_nu, Dxf_nu, Dyf_nu] = solveTE_nu(L0, wvlen, xrange, yrange,...
    eps, Mz, Npml, dx_scale, dy_scale);
toc

% figure();
% moviereal(Hz, xrange2, yrange2);

%% uniform
tic
[Hz_u, Ex_u, Ey_u,  A] = solveTE(L0, wvlen, xrange, yrange, eps, Mz, Npml);
toc
%
% figure();
% moviereal(Hz_u, xrange2, yrange2);

figure();
show_grid = 1;
visreal_nu(Hz, xrange_array, yrange_array, show_grid);
title('non-uniform')

figure();
visreal(Hz_u, xrange2, yrange2);
title('uniform')
figure();
visreal(Hz, xrange2, yrange2);
