clc 
clear
set(0,'DefaultFigureWindowStyle','docked')
nx = 100;
ny = 50;
N = 2e3;

V=zeros(nx,ny);

% vr = 0; 
% vl = 1;
vb=0;
vt=0;
vr=1;
vl=1;
dvb=0;
dvt=0;
nx_mid = floor(nx/2);
ny_mid = floor(ny/2);
Vmid(1) = V(nx_mid,ny_mid);

for iter = 1:N
    for m = 2:(nx -1)
        for n = 2:(ny -1)
            V(1,:) = vl;  %left
            V(nx,:) = vr; %right

            if dvb==0 %derivative of the bottom
                V(:,1)=vb; %Bottom
            else
                V(:,1)=V(:,2);
            end
            if dvt==0 %derivative of the top
                V(:,ny)=vt; %Top
            else 
                V(:,ny)=V(:,ny-1);
            end

%           if(vl == 1)
%                 V(1,:) = 1;  
%                 V(nx,:) = 1; 
%                 V(:,ny) = 0; 
%                 V(:,1) = 0; 
            V(m,n) = (V(m+1, n) + V(m-1, n) + V(m,n+1) + V(m,n-1))/4;
 
        end
    end 
    Vmid(iter+1) = V(nx_mid,ny_mid);
    
    if mod(iter, 50) == 0  
        figure(1)
        subplot(2,1,1)
        surf(V')

        subplot(2,1,2)
        plot(Vmid)
        ylabel('Vmid'); xlabel('iter')
    plot(imboxfilt(V,3));
        pause(0.001)
    end
end
    
        [Ex, Ey] = gradient(V);
        figure (2)
        quiver(-Ey', -Ex', 10)
        pause (.001)