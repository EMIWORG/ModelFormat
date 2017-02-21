CellSizeU = [30000. 25000. 20000. 20000. 20000. 20000. 25000. 30000.];
CellSizeV = [30000. 25000. 20000. 20000. 20000. 20000. 25000. 30000.];
CellSizeW = [20000. 20000. 20000. 20000. 15000. 10000. 10000. 20000. 20000. 20000. 25000.];

NodesU = [0 cumsum(CellSizeU)];
NodesV = [0 cumsum(CellSizeV)];
NodesW = [0 cumsum(CellSizeW)];

NU = length(NodesU);
NV = length(NodesV);
NW = length(NodesW);

AnchorX = 0;
AnchorY = 0;
AnchorZ = 0;
Azimuth = 0;

BlankValue = NaN;
Unit = 'Ohm.m';

CellType = int32(zeros([NU-1 NV-1 NW-1]));
CellType(:,:,7:end) = 1;

Rho = ones([NU-1 NV-1 NW-1]);
Rho(:,:,1:6) = 1e10;
Rho(:,:,7:7) = 10;
Rho(:,:,8:8) = 100;
Rho(:,:,9:end) = 0.1;
Rho(4:4,4:5,7:7) = 1;
Rho(5:5,4:5,7:7) = 100;

%% Write HDF5 file
fname = 'commemi.h5';

% Create an HDF5 file
fcpl = H5P.create('H5P_FILE_CREATE');
fapl = H5P.create('H5P_FILE_ACCESS');
fid = H5F.create(fname,'H5F_ACC_TRUNC',fcpl,fapl);

plist = 'H5P_DEFAULT';
gid = H5G.create(fid,'Georeference',plist,plist,plist);
H5G.close(gid);

H5F.close(fid);

% Write data
h5writeatt(fname,'/','ModelName','COMMEMI3D-2');
h5writeatt(fname,'/','MeshType',1);

h5writeatt(fname,'/Georeference','AnchorX',AnchorX);
h5writeatt(fname,'/Georeference','AnchorY',AnchorY);
h5writeatt(fname,'/Georeference','AnchorZ',AnchorZ);
h5writeatt(fname,'/Georeference','Azimuth',Azimuth);

h5create(fname,'/Geometry/NodesU',NU);
h5write(fname, '/Geometry/NodesU', NodesU);
h5create(fname,'/Geometry/NodesV',NV);
h5write(fname, '/Geometry/NodesV', NodesV);
h5create(fname,'/Geometry/NodesW',NW);
h5write(fname, '/Geometry/NodesW', NodesW);

h5writeatt(fname,'/Geometry','NU',NU);
h5writeatt(fname,'/Geometry','NV',NV);
h5writeatt(fname,'/Geometry','NW',NW);

h5create(fname,'/Properties/CellType',size(CellType),'Datatype','int32');
h5write(fname, '/Properties/CellType', CellType);

h5create(fname,'/Properties/Rho', size(Rho));
h5write(fname, '/Properties/Rho', Rho);

h5writeatt(fname,'/Properties/Rho','Unit',Unit);
h5writeatt(fname,'/Properties/Rho','BlankValue',BlankValue);

% View HDF structure
h5disp(fname)