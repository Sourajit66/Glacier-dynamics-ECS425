%Written by Sourajit Sahoo
%% part 1 importing
opts = delimitedTextImportOptions("NumVariables", 26);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["lat", "lon", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "VarName19", "VarName20", "VarName21", "VarName22", "VarName23", "VarName24", "VarName25", "VarName26"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Import the data
latlonTP = readtable("C:\Users\Sourajit Sahoo\Desktop\Glacier\lat_lon_T_P.txt", opts);

%Clear temporary variables
clear opts;

%% Model 1 ELA
tic
x=latlonTP.lat<25;
idc=find(x);
latlonTP(x,:)=[];
a=latlonTP.lat; %latitude
b=latlonTP.lon; %longitude

bonds=latlonTP.Variables;

k1=3;
for k=1:size(bonds,1)
    d=bonds(k,3:14);
    d2=bonds(k,15:26);
    v=1;
    sumt=[];
    beta_temp=[];
    for j=10000:-1:-10000     
        sum=0;
        for i=length(d)        
        m=d(i)-j*.0065;
             if m<=0
            sum=sum+m*d2(i);
             else
            sum=sum-k1*d(i);
             end       
        end    
        sumt(v)=sum;
        if (sum<.5 & sum>-.5)
          q(k)=j;
          break;
        end
        v=v+1;
        if j==-10000
            v=v-1;
        end
    end
    y1=v:-1:1;
    beta_temp=sumt./y1;
    beta(k)=mean(beta_temp);
end
%q=reshape(q,[1,9177])
figure(1)
h=geodensityplot(a,b,q,'FaceColor','interp');
geobasemap colorterrain
colorbar;
figure(2)
h=geodensityplot(a,b,beta,'FaceColor','interp');
geobasemap colorterrain
colorbar;
toc
%% Model 2 Precipitation Variation

