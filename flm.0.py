#this code solves one dimensional flowline model using an explicit finite diff method
#transition between steady states
import matplotlib.pyplot as plt
import numpy as np

#constants
rho= 900.0;g= 9.8;A= 1.e-16;n= 3.
c= 0.03125*(2*A/(n+2))*(rho*g)**n
#geometry
dx= 30.; x_steps= 250; X=np.arange(x_steps)*dx
dt= 0.002;t_steps=500001;
s_bed=0.1;z_bed= np.array([6000.-s_bed*dx*i for i in range(x_steps)])
#mass balance parameters
beta= 0.01; ela= 5860.

# intialising storage and plots etc 
t_store=15000; l=np.array([]); e=np.array([])
fig1 = plt.figure(1); plt.xlabel("x (m)");plt.ylabel("z (m)      Q (m$^2$s$^{-1}$)")
fig2 = plt.figure(2); plt.xlabel("x (m)");plt.ylabel("thickness (m)")


#initialisation of ice thickness
h=np.array(np.zeros(x_steps))

# evolve profiles in time
n = 1 # Some counter
m = 1 # Some counter
for t in range(t_steps):
    z_ice=z_bed+h # compute ice surface
    m_b= - beta*(ela-z_ice) # compute surface mass balance
    s_ice=(z_ice[1:]-z_ice[:x_steps-1])/dx #surface slope
    f_ice=-c*(s_ice**3)*(h[1:]+h[:x_steps-1])**5 #ice fluxes
    h[1:x_steps-1]+=((f_ice[:x_steps-2]-f_ice[1:])/dx+m_b[1:x_steps-1])*dt #update ice thickness
    h[0]=h[1]-s_bed*dx #no-flux BC on top
    h.clip(min=0,out=h) # remove negative thickness values
    
    if t % 25000 == 0:
        print(t * dt)

    if (t==int(t_steps/2)): # changing ELA halfway through
        ela+=50
        plt.figure(1); # plotting initial steady state
        plt.plot(X,z_ice-z_bed[x_steps-1],'g--',label="glacier_surface")
        plt.plot(X,np.append([0],f_ice/10),'r--',label="ice_flux/10")

    if(t%t_store==0): # storing and plotting the intermediate profiles etd 
        l=np.append(l,np.count_nonzero(h)) 
        e=np.append(e,ela) 
        plt.figure(2);
        
        if(t<t_steps/2):
            l1 = plt.plot(X,h,'b-') #plot intermediate profiles in blue
            plt.pause(0.1)
            if n == 2:
                plt.legend(l1, "before $t_{1/2}$")
            n += 1
        else:
            l2 = plt.plot(X,h,'r-') #plot intermediate profiles in red
            plt.pause(0.1)
            if m == 2:
                plt.legend(l2, "after $t_{1/2}$")
            m += 1

            
# final plotting
plt.figure(1);
plt.plot(X,z_ice-z_bed[x_steps-1],'g-',label="")
plt.plot(X,np.append([0],f_ice/10),'r-',label="")
plt.plot(X,z_bed-z_bed[x_steps-1],'b-',label="bedrock")
plt.legend()

fig3 = plt.figure(3); plt.xlabel("time (yr)");plt.ylabel("length (m)         ELA (m)")
plt.plot(t_store*dt*(np.arange(l.size)),l*dx,'b*',label="ela")
plt.plot(t_store*dt*(np.arange(l.size)),e,'g-',label="len")
plt.legend()

plt.show()
