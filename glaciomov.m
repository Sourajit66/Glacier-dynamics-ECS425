a=latlonTP.lat;
b=latlonTP.lon;
for k=3:14
c = latlonTP{:,k};
d=c;
c1 =latlonTP{:,k+12};
h1=c1;
z=zeros(1,length(d))
for i=1:length(d)
   if d(i)>0;
       z(i)=d(i);
       d(i)=0;
   else
       d(i)=d(i)-1;
   end
end
d1=abs(d);
d2=h1-d1;
h=geodensityplot(a,b,d2);
geolimits([10 42],[75 88]);
geobasemap colorterrain
saveas(h,sprintf('FIGc%d.png',k));
end
