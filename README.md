Common Model Format for EM modeling and inversion v0.1

This repository contains document with specification of the format as well as a number of examples to write and visualize obtained models.

The format can accommodate general 3D (including 1D/2D as a special cases) models defined on various types of meshes: structured rectilinear, tetrahedral, hexahedral and non-conforming (sometimes called octree). 

The format uses HDF5 data model and optional XDMF as an XML scheme description, which allows external general-purpose visualization packages (such as Paraview and VisIt) to render models.