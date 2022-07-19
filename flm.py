#this code solves one dimensional flowline model using an explicit finite diff method
#plots the final steady state
import matplotlib.pyplot as plt
import numpy as np

#constants
rho= 900.0;g= 9.8;A= 1.e-16;n= 3.
c= 0.03125*(2*A/(n+2))*(rho*g)**n
#geometry
dx= 30.; x_steps= 250; 
X=np.arange(x_steps)*dx # Total domain of the numerical scheme
dt= 0.002;t_steps=250001;

#Initial geometry of the bed
s_bed=0.1;z_bed= np.array([6000.-s_bed*dx*i for i in range(x_steps)])
#mass balance parameters
beta= 0.01; ela= 5860.

#initialisation. Initial state for ice thickness
h=np.zeros(x_steps)

# evolve profiles
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

#plotting
fig=plt.figure()
ax1 = fig.add_subplot(111)
ax1.plot(X,z_bed-z_bed[x_steps-1],'b-',label="bedrock")
ax1.plot(X,z_ice-z_bed[x_steps-1],'g-',label="glacier_surface")
ax1.set_xlabel("x (m)")
ax1.set_ylabel("z (m)") 
plt.legend(loc=0)

ax2 = ax1.twinx()
ax2.plot(X,np.append([0],f_ice/10),'r-',label="ice_flux/10")
ax2.set_ylabel("Q (m$^2$s$^{-1}$)")
plt.legend(loc=0)
plt.show()
