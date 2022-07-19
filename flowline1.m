%this code solves one dimensional flowline model using an explicit finite diff method
%plots the final steady state
%written by Sourajit sahoo based on algorithm by Dr Argha Banerjee


%constants
rho= 900.0;
g= 9.8;
A= 1.e-16;
n= 3;
c= 0.03125*(2*A/(n+2))*(rho*g)^n;
%geometry
dx= 30;
x_steps= 250; 
X=[dx:dx:x_steps*dx]; % Total domain of the numerical scheme
dt= 0.002;
t_steps=250001;

%Initial geometry of the bed
s_bed=0.1;
for i=1:x_steps
z_bed(i)= (6000-(s_bed*dx*i));
end
%mass balance parameters
beta= 0.01;
ela= 5860;

%initialisation. Initial state for ice thickness
h=zeros(1,x_steps);
at_least=0;
%% evolve profiles
for t=1:t_steps
    z_ice=z_bed+h; % compute ice surface
    m_b= - beta.*(ela-z_ice); % compute surface mass balance
    s_ice=(z_ice(2:end)-z_ice(1:x_steps-1))./dx; %surface slope
    f_ice=-c.*(s_ice.^3).*(h(2:end)+h(1:x_steps-1)).^5; %ice fluxes
    h(2:x_steps-1)=h(2:x_steps-1)+((f_ice(1:x_steps-2)-f_ice(2:end))./dx+m_b(2:x_steps-1)).*dt ;%update ice thickness
    h(1)=h(2)-s_bed.*dx; %no-flux BC on top
    h(h<0)=0; % remove negative thickness values
    
    if mod(t,25000) == 0
        disp(t * dt);
    end
    
end

%% plotting
yyaxis left
plot(X,z_ice-z_bed(x_steps-1),'g-');
%label="glacier_surface"
hold on
xlabel("x(m)");
ylabel("z(m)");
plot(X,z_bed-z_bed(x_steps-1),'b-');
%label="bedrock"


yyaxis right
u=[0];
plot(X,[u f_ice./10],'r-');
%xlabel("ice flux/10");
ylabel("Q(Kg m^-2 yr^-1)");
legend("glacier surface","bedrock","ice flux/10")

