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
    y1=1:v;
    beta_temp=sumt./y1;
    beta(k)=mean(beta_temp);
end
q=reshape(q,[129,133]);
beta=reshape(beta,[129,133]);
b1=65:.25:98;
a1=42:-.25:10;
figure(1)
surf(b1,a1,q)
xlabel("latitude")
ylabel("longitude")
zlabel("deviation to ELA")
colorbar
figure(2)
surf(b1,a1,beta)
xlabel("latitude")
ylabel("longitude")
zlabel("beta")

%geolimits([10 42],[75 88]);
%geobasemap grayterrain
%colorbar
toc
%% Model 2 Precipitation Variation

