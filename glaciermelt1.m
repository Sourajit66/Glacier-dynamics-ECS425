a=latlonTP.lat; %latitude
b=latlonTP.lon; %longitude
%latlonTP.TestAvg1 = mean(latlonTP{:,3:14},2);
%d=latlonTP.TestAvg1;
%latlonTP.TestAvg2 = mean(latlonTP{:,15:26},2);
%h1=latlonTP.TestAvg2;
K=21 % picture save counter
m=2;% ablation factor
for i=1:length(a)
    d=latlonTP(i,3:14);
    d=table2array(d);
    d1=latlonTP(i,15:26);
    d1=table2array(d1);
    z=zeros(1,length(d));
   for j=1:length(d)
   if d(j)>0;
       z(j)=d(j);
       d(j)=0;
   else
       d(j)=d(j)-1;
   end
   end
   r(i)=sum(d.*abs(d1))-sum(m*z);
end
r=(abs(r).*10e5); % adjustment factor for thickness
h=geodensityplot(a,b,r,'FaceColor','interp');
geolimits([0 42],[70 89]);
geobasemap grayterrain
colorbar
saveas(h,sprintf('FIG%d.png',K));
