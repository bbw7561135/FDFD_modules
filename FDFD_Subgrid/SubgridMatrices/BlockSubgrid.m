%% Test of the Linear interpolation

SingleCellDims = [10,10,10]
Lx = SingleCellDims(1);
Ly = SingleCellDims(2);
Lz = SingleCellDims(3);

numCells = cellx*celly*cellz;

cubeface_f = getCubeFaceCoords(Lx, Ly, Lz)

SingleCellDims = [4,4,4]
Lx = SingleCellDims(1);
Ly = SingleCellDims(2);
Lz = SingleCellDims(3);

cubeface_c = getCubeFaceCoords(Lx, Ly, Lz);

%% map the co-located fine and coarse grid coordinates

C = cubeface_f{6};
C2 = cubeface_c{3};

%% 3 is the coarsening factor
ind1 = mod(C(:,1),3) == 1;
ind2 = mod(C(:,3),3) == 1;
submatrix1 = C(ind1, :);
submatrix2 = C(ind2, :);
frame = horzcat(submatrix1(:,1), 10*ones(length(submatrix1),1), submatrix2(:,3));
frame = unique(frame,'rows')

scatter3(frame(:,1), frame(:,2), frame(:,3));
hold on;
scatter3(C(:,1), C(:,2), C(:,3))

%% at this point, the coarse border and the frame of the fine grid match
% step 1) construct operators on coarse and fine grids

%% Dirichlet Solver
L0 = 1e-6;  % length unit: microns
wvlen = 1.55;  % wavelength in L0
diel = 1;
cellsize = 30;
inclusionSize = cellsize-10;

numcells = 1;
cellx = numcells; celly = numcells; cellz = 1;

Npml = [0 0 0];  % [Nx_pml Ny_pml]
xrange = numcells*[-1 1];  % x boundaries in L0
yrange = numcells*[-1 1];  % y boundaries in L0
zrange = numcells*[-1 1];
%[xrange, yrange, N, dL, Lpml] = domain_with_pml(xrange, yrange, N, Npml);  
% domain is expanded to include PML

%% Set up the permittivity.
SingleCellDims = cellsize*[1, 1, 1];
[eps_r, interiorCoords, borderCoords] = cubeDielectricGrid(cellx, celly,...
cellz, SingleCellDims,...
inclusionSize, diel);
N = size(eps_r);

%% Set up the current source density.
Mz = zeros(N); My = Mz; Mx = Mz;
ind_src = [1 1 1];%ceil(N/2);  % (i,j) indices of the center cell; Nx, Ny should be odd
Mz(ind_src(1), ind_src(2), ind_src(3)) = 1;
JCurrentVector = [Mx; My; Mz];

%% implement an iterative solve for all of the Schur complement elements
%% Wonsoek's scalar parameter 1, -1, or 0
s = -1;

[Af, b, Ao, bo, omega, c0, TepsSuper, TmuSuper] = ...
    solve3D_EigenEngine_Matrices_dirichlet(L0, wvlen, xrange, yrange, zrange, eps_r,...
    JCurrentVector, Npml, s);

[Ac, b, Ao, bo, omega, c0, TepsSuper, TmuSuper] = ...
    solve3D_EigenEngine_Matrices_dirichlet(L0, wvlen, xrange, yrange, zrange, eps_r,...
    JCurrentVector, Npml, s);



