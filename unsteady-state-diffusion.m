%Define all variables
Lx = 1; Ly = 1; Mx = 20; My = 20;
nu = 1; maxIter = 80; dt = 0.0001;
showplot = true;

%Boundary Conditions
tBC = 0; bBC = 0;
lBC = 0; rBC = 0;
xperiodic = false; yperiodic = false;

%Initial condition
uinitial = zeros(Mx, My); uinitial(Mx/2, My/2) = 1;

u = solve_unsteady_diff(uinitial, Lx, Ly, Mx, My, nu, maxIter, dt, xperiodic, yperiodic, tBC, bBC, lBC, rBC, showplot);

function u = solve_unsteady_diff(uinitial, Lx, Ly, Mx, My, nu, maxIter, dt, xperiodic, yperiodic, tBC, bBC, lBC, rBC, showplot)
    %Check inputs are correct format
    attributes = {Lx, Ly, Mx, My, nu, maxIter, dt, tBC, bBC, lBC, rBC};
    for i = 1:numel(attributes)
        validateattributes(attributes{i},{'numeric'},{'size',[1 1]})
    end

    %Error check uinitial is of size Mx by My
    if size(uinitial) ~= [Mx My]
        error('solve_unsteady_diff:DomainSizeError','uinitial does not meet specified size Mx by My')
    end
    
    %Define u to be uinitial
    u = uinitial;

    %Loop over all timesteps
    for it = 1:maxIter
        %Enforce Boundary Conditions
        if xperiodic == true
            u(1,:) = u(end-1,:);
            u(end,:) = u(2,:);
        else
            u(1,:) = lBC; %Left
            u(end,:) = rBC; %Right
        end
        
        if yperiodic == true
            u(:,1) = u(:,end-1);
            u(:,end) = u(:,2);
        else
            u(:,end) = tBC; %Top
            u(:,1) = bBC; %Bottom
        end
        
        %Set u at next timestep (un) to include boundary values
        utp1 = u;
    
        %Loop over all points and update un from 5 point stencil of u values
        dx = Lx/(Mx-1);
        dy = Ly/(My-1);
    
        for j = 2:My - 1
            for i = 2:Mx - 1
                utp1(i,j) = u(i,j) + nu*dt*( (u(i+1,j) - 2*u(i,j) + u(i-1,j))/dx^2 + (u(i,j+1) - 2*u(i,j) + u(i,j-1))/dy^2);
            end
        end
        
        %Overwrite u array with new u at t+1
        u = utp1;
           
        %Plotting
        if (showplot)
            %Note transpose as u arrays defined with Mx x My so flip to plot
            contourf(u'); %surf also possible
            colorbar;
            pause(0.01)
        end
    end
end
