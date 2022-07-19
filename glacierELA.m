a=latlonTP.lat;
b=latlonTP.lon;
for k=3:14
c = latlonTP{:,k};
d=c;
c1 =latlonTP{:,k+12};
h1=c1;
q=zeros(1,length(d));
m=2;
for i=1:length(d)
    s=0;
    for j=500:-10:-500
        d(i)=d(i)-0.0065*j;
        t=0;
   if d(i)<=0;
       d(i)=0;
       t=1;
   end
   s=s+h1(i)*t-m*d(i);
   if (j>0)&(s<1 & s>-1)
          q(i)=j;
          break;
    end
    end
end
q=q*10e7
q=q/2;
h=geodensityplot(a,b,q,'FaceColor','interp');
%geolimits([10 42],[75 88]);
geobasemap grayterrain
colorbar
%lim=caxis
%caxis([1e-7 8e-7])
saveas(h,sprintf('FIG%d.png',k));
end
