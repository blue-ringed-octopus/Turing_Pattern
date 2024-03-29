clear all;
close all;
n=200;
dh=1;
dt=1;

tStep=1000;

u=ones(n,n,tStep);
v=zeros(n,n,tStep);
% 
% 
% init_spot=50;
% spot_size=3;
% f=0.055;
% k=0.062;
% du=1;
% dv=0.5;

%puffer
init_spot=100;
spot_size=1;
f=0.055;
k=0.062;
du=0.98;
dv=0.5;

% mitosis 
% init_spot=50;
% spot_size=3;
% f=0.036;
% k=0.0649;
% du=1;
% dv=0.5;

%coral 
% init_spot=40;
% spot_size=10;
% f=0.0546;
% k=0.062;
% du=1.1 n;
% dv=0.505;

% v(:,:,1)=rand(n)*0.2;
locx=randi(n-spot_size,[1,init_spot]);
locy=randi(n-spot_size,[1,init_spot]);
for i=1:init_spot
 v(locx(i):locx(i)+spot_size,locy(i):locy(i)+spot_size,1)=1;
end


for t=1:(tStep-1)
    ut=u(:,:,t);
    vt=v(:,:,t);
del_u=laplacian(ut);
del_v=laplacian(vt);
% 
    unew=ut+(-ut.*vt.^2+f.*(1-ut)+du.*del_u).*dt;
    vnew=vt+(+ut.*vt.^2-(k+f).*vt+dv.*del_v).*dt; 
    
%linear model
%         a=0.05;
%     b=-0.05;
%     c=0.03;
%     d=-0.05;
%     h=0;
%     k=0;
%     du=1;
%     dv=0.5;
%     
%      unew=ut+(a*(ut-h)+b*(vt-k)+du*del_u)*dt;
%      vnew=vt+(c*(ut-h)+d*(vt-k)+dv*del_v)*dt;
    unew(unew>1)=1;
    vnew(vnew>1)=1;
    unew(unew<0)=0;
    vnew(vnew<0)=0;
    
    u(:,:,t+1)=unew;
    v(:,:,t+1)=vnew;
end

for t=1:5:tStep
   %  subplot(1,2,1)
   imshow((u(:,:,t)),'InitialMagnification',1000)
    %subplot(1,2,2)
     %imshow((v(:,:,t)),'InitialMagnification',1000)
% image(u(:,:,t),'CDataMapping','scaled')
    title("t="+string(t))
    pause(0.01)
end

function arrOut = laplacian(arrIn)
% Calculates laplacian for a matrix using a 3x3 convolution with edge wrapping
arrOut = -1*arrIn + ...
    0.2*(circshift(arrIn,1)+circshift(arrIn,-1)+circshift(arrIn,-1,2)+circshift(arrIn,1,2)) + ...
    0.05*(circshift(arrIn,[1 1])+circshift(arrIn,[1 -1])+circshift(arrIn,[-1 1])+circshift(arrIn,[-1 -1]));
end