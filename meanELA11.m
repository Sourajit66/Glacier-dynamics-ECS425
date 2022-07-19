%% written by Sourajit Sahoo

a=latlonTP.lat;
b=latlonTP.lon;
latlonTP.TestAvg1 = mean(latlonTP{:,3:14},2);
d=latlonTP.TestAvg1;
latlonTP.TestAvg2 = mean(latlonTP{:,15:26},2);
h1=latlonTP.TestAvg2;
q=zeros(1,length(d));
K=111
for i=1:length(d)
    s=0;    
    for j=10000:-1:-10000
        d1=d(i);
        d1=d1-0.0065*j;
        if d1>-.005 & d1<.005
            q(i)=j;
            break;
        end
    end
end
%q=q*10e8;
h=geodensityplot(a,b,q,'FaceColor','interp');
geolimits([10 42],[65 105]);
geobasemap grayterrain
colorbar
saveas(h,sprintf('FIG%d.png',K));
