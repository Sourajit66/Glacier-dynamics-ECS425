g=load('lat_lon_T_P.txt'); % to read the .txt file
x=g(:,1); % latitude as x 
y=g(:,2); % longitude as y

l=length(x);
p=ones(12,1);
t=p; pr=t; tm=t; f=t;
fn=ones(1,l);
T=fn; P=T; st=T; sp=st;

for j=1:l
    
    f1=0;   
    for k= 3:14
       q=1;
       k
        p(q)=g(j,k);
        t(q)=g(j,k+12);
        
        if t(q)<1
            t1(q)=1;
        else
            t1(q)=0;
        end
        
        pr(q)=p(q)*t1(q);
        tm(q)=t(q)*t1(q);
        
        f(q)= 10*pr(q) + tm(q);
       
        
        f1=f1+f(q);
     
       q=q+1; 
    end
    
    fn(j)=f1;
    
    g1=g(j,3:14);
    g2=g(j,15:26);
    T(j)=mean(g1);
    P(j)=mean(g2);
    
    st(j)=std(g1);
    sp(j)=std(g2);
end
    
    
        
    