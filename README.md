Common Model Format for EM modeling and inversion v0.1

This repository contains document with specification of the format as well as a number of examples to write and visualize obtained models.

The format can accommodate general 3D (including 1D/2D as special cases) models defined on various types of meshes: structured rectilinear, tetrahedral, hexahedral and non-conforming (sometimes called octree). 

The format uses [HDF5](https://support.hdfgroup.org/HDF5/) data model and optional [XDMF](http://www.xdmf.org/index.php/XDMF_Model_and_Format) as an XML scheme description, which allows external general-purpose visualization packages (such as [Paraview](http://www.paraview.org/) and [VisIt](https://wci.llnl.gov/simulation/computer-codes/visit)) to render models.