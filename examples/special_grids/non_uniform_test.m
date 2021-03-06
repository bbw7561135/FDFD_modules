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
Ntran =   [50,50];
% 2) specify the dx and dy of each region
dx1 = 0.02; dy1 = 0.02;
dx2 = 0.005; dy2 = 0.005;
dfine = [dx2, dy2];
dcoarse = [dx1, dy1];
dtran = [0 ,0];

% 3) stack the vectors
% drt does not have a value...
Nft = vertcat(Ncoarse, Ntran, Nfine, Ntran, Ncoarse);
drt = vertcat(dcoarse, dtran, dfine, dtran, dcoarse);

% scale is arbitrary, just take dcoarse;
dr_reference  = dcoarse;

% 4) construct scaling vectors from this information
[dx_scale, dy_scale] = generate_nonuniform_scaling(Nft, drt./dr_reference);

%% calculate Ntot and Ltot
N = sum(Nft);
Lx = sum(dr_reference(1)*dx_scale);
Ly = sum(dr_reference(2)*dy_scale);
xrange = 0.5*[-Lx, Lx];
yrange = 0.5*[-Ly, Ly];
xrange_array = cumsum(dr_reference(1)*dx_scale)-Lx/2;
yrange_array = cumsum(dr_reference(1)*dy_scale)-Ly/2;
Nx = N(1); Ny = N(2);
%% output is a dxscale...dyscale

%% PML specification
Npml = [20,20];


%% Set up the permittivity.
wvlen = 1;
omega = 2*pi*c0/wvlen*1e6;
eps = ones(N);
thickness = 0.5;

%for a given thickness, we have to find elements in xrange_array closest to
%that
test_indices = find(abs(xrange_array) < 0.5);
xnc = round(Nx/2);
ync = round(Ny/2);
eps(test_indices(1):test_indices(end),:) = 6;

%% Set up the magnetic current source density.
Mz = zeros(N);
ind_src = [round(Nx/2),round(Ny/2)];  % (i,j) indices of the center cell; Nx, Ny should be odd
Mz(ind_src(1), ind_src(2)) = 1;


%% Solve TE (photonic), TM (practical), depends on convention equations.
tic
[Hz, Ex, Ey, A_nu,b_nu, Dxf_nu, Dyf_nu] = solveTE_nu(L0, wvlen, xrange, yrange,...
    eps, Mz, Npml, dx_scale, dy_scale, dr_reference);
toc

% figure();
% moviereal(Hz, xrange2, yrange2);

%% uniform
%on a uniform grid, how do we construct epsilon
dxu = diff(xrange)/Nx;
dyu = diff(yrange)/Ny;
num_cells_x = round(0.5/dxu);
eps_uniform = ones(N);
eps_uniform(xnc-num_cells_x: xnc+num_cells_x,:)= 6;

tic
[Hz_u, Ex_u, Ey_u,  A] = solveTE(L0, wvlen, xrange, yrange, eps_uniform, Mz, Npml);
toc
%
% figure();
% moviereal(Hz_u, xrange2, yrange2);

figure();
show_grid = 1;
visreal_nu(Hz, xrange_array, yrange_array, show_grid);
title('non-uniform')

figure();
visreal(Hz_u, xrange, yrange);
title('uniform')
figure();
visreal_nu(Hz, xrange_array, yrange_array,0);
