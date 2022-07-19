function latlonTP = importfile('lat_lon_T_P.txt')
a=latlonTP.lat;
b=latlonTP.lon;
latlonTP.TestAvg1 = mean(latlonTP{:,3:14},2);
d=latlonTP.TestAvg1;
latlonTP.TestAvg2 = mean(latlonTP{:,15:26},2);
h1=latlonTP.TestAvg2;
K=20
for i=1:length(d)
   if d(i)>0;
       d(i)=0;
   else
       d(i)=d(i)-1;
   end
end
d1=abs(d);
d2=d1.*h1;
h=geodensityplot(a,b,d2,'FaceColor','interp');
geolimits([0 42],[70 89]);
geobasemap grayterrain
colorbar
saveas(h,sprintf('FIG%d.png',K));
