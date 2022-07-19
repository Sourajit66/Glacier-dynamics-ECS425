%% written by Sourajit Sahoo
% based on algo by Dr Argha Banerjee
%this code solves one dimensional flowline model using an explicit finite diff method
%transition between steady states


%constants
rho= 900.0;
g= 9.8;
A= 1.e-16;
n= 3;
c= 0.03125*(2*A/(n+2))*(rho*g)^n;
%geometry
dx= 30;
x_steps= 250;
X=[dx:dx:x_steps*dx];
dt= 0.002;
t_steps=500001;
s_bed=0.1;

for i=1:x_steps
z_bed(i)= (6000-(s_bed*dx*i));
end
%mass balance parameters
beta = 0.01;
ela = 5860;

% intialising storage and plots etc 
t_store=15000; 
l=[]; e=[];



%initialisation of ice thickness
h=zeros(1,x_steps);

% evolve profiles in time
n=1;
m=1;
figure(1);
for j=0:3:12;
    ela=5860;
    h=zeros(1,x_steps);
for t=1:t_steps
    z_ice=z_bed+h; % compute ice surface
    m_b= - beta.*(ela-z_ice); % compute surface mass balance
    s_ice=(z_ice(2:end)-z_ice(1:x_steps-1))./dx; %surface slope
    f_ice=-c.*(s_ice.^3).*(h(2:end)+h(1:x_steps-1)).^5; %ice fluxes
    h(2:x_steps-1)=h(2:x_steps-1)+((f_ice(1:x_steps-2)-f_ice(2:end))./dx+m_b(2:x_steps-1)).*dt;%update ice thickness
    h(1)=h(2)-s_bed.*dx; %no-flux BC on top
    h(h<0)=0; % remove negative thickness values
    
    if mod(t,25000) == 0
        disp(t * dt);
    end
    
    if (t==round(t_steps/2)) % changing ELA halfway through
        ela=ela+25+j*10;
        u=[0];
        figure(1);% plotting initial steady state
        plot(X,z_ice-z_bed(x_steps-1),'g--')
        hold on
        plot(X,[u f_ice./10],'r--')
        hold off
    end

    if(mod(t,t_store)==0) % storing and plotting the intermediate profiles etd 
        l=[l nnz(h)]; %storing all non zero values
        e=[e ela] ;
        figure(2+j);
        xlabel("x (m)");
        ylabel("thickness (m)")
        
        if(t<t_steps/2)
            u1=plot(X,h,'b-');
            hold on; %plot intermediate profiles in blue
            
           
        else
            u2=plot(X,h,'r-'); %plot intermediate profiles in red
            
        end
    end
end
            

            
% final plotting
figure(1);
hold on
yyaxis left

plot(X,z_ice-z_bed(x_steps-1),'r-');
plot(X,z_bed-z_bed(x_steps-1),'b-');
ylabel("x(m)");
%yyaxis right
%plot(X,[u f_ice./10],'r-');
xlabel("x (m)");
%ylabel("Q (kg m^-^2 yr^-^1)")
%legend("initial glacier","initial f ice /10","new glacier","new f ice/10","bed rock")
 
figure(2+j);
hold on
legend([u1 u2],"until ela change","after ela change")

%fig3 = figure(3+j);
%xlabel("time (yr)");ylabel("length (m)         ELA (m)");
%hold on
%plot(t_store*dt.*(sort(l)),l.*dx,'k--');
%plot(t_store*dt.*(sort(l)),e,'g-');
%legend("len","ela");
%hold off

end

