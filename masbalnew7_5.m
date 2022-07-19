opts = spreadsheetImportOptions("NumVariables", 22);

% Specify sheet and range
opts.Sheet = "14_rgi60_SouthAsiaWest";
opts.DataRange = "A2:V27989";

% Specify column names and types
opts.VariableNames = ["RGIId", "GLIMSId", "BgnDate", "EndDate", "CenLon", "CenLat", "O1Region", "O2Region", "Area", "Zmin", "Zmax", "Zmed", "Slope", "Aspect", "Lmax", "Status", "Connect", "Form", "TermType", "Surging", "Linkages", "Name"];
opts.VariableTypes = ["string", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string"];

% Specify variable properties
opts = setvaropts(opts, ["RGIId", "GLIMSId", "Name"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["RGIId", "GLIMSId", "Name"], "EmptyFieldRule", "auto");

% Import the data
SAW = readtable("C:\Users\Sourajit Sahoo\Desktop\Glacier\south asia west\14_rgi60_SouthAsiaWest.xlsx", opts, "UseExcel", false)
%%
a=SAW.CenLon;
b=SAW.CenLat;
c=SAW.Area
geodensityplot(b,a)
geobasemap colorterrain
%geoshow('14_rgi60_SouthAsiaWest.shp','FaceColor', 'none','LineWidth',2)
%%
idc=mod(a,.25)==0 & mod(b,.25)==0
x=find(idc);
kar1=SAW(x,:)