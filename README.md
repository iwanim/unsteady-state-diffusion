### Numerically modelling unsteady state diffusion

The function models unsteady state diffusion by providing a 2D profile of how concentration varies in space with time, iterating a discretised form of the unsteady state diffusion equation to fill a matrix with decreasing values away from its centre, representing decreasing levels of concentration in the directions of diffusion.

Parameters which can be changed: `Lx` and `Ly`, which specify the domain size; `Mx` and `My`, which specify the number of columns and rows in the matrix, respectively; the viscosity (could also represent solid density) `nu`; the maximum number of iterations in time `maxIter`; the desired time period `dt`; boundary conditions `tBC`, `bBC`, `lBC` and `rBC`, which can be 0 to model a static wall or a number to model a sliding wall (could represent other things, such as temperature at the boundaries if the function was applied to heat diffusion); as booleans, whether to plot a contour map of the field, `showplot`; and whether to apply periodic boundaries in the x, `xperiodic`, and y, `yperiodic`, directions.

Problems which could be solved using this model include the diffusion of one liquid through another, thermal dissipation through a metal, concentration of a chemical in a mixture, stress state in a material, pressure gradients, and electromagnetic fields.

<img align="left" width="45%" src="https://user-images.githubusercontent.com/112774862/193430549-d23b7f2b-49cd-41bf-8e3b-984ab5d86f49.gif">
<img align="right" width="45%" src="https://user-images.githubusercontent.com/112774862/193430572-c2e8affa-40e2-44b7-8a2b-8c57e5e38584.gif">

<br clear="left"/>
<br/>
Including boundary conditions changes the solution as an element of movement is introduced to the edge of the field (above). Changing the viscosity parameter affects the extent of diffusion in the same time. Changing the maximum number of iterations while keeping the time period constant provides a picture further or closer in time of the state of diffusion through the field.
