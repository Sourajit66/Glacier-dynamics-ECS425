opts = spreadsheetImportOptions("NumVariables", 12);

% Specify sheet and range
opts.Sheet = "HMA_GlacierAvg_dH_GeodeticMassB";
opts.DataRange = "A2:L1041";

% Specify column names and types
opts.VariableNames = ["id", "pctDeb", "lon", "lat", "volChj", "volChjSig", "meanElevCh", "meanElev_1", "geoMassBal", "geoMassB_1", "percentCov", "demYears"];
opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "categorical"];

% Specify variable properties
opts = setvaropts(opts, ["id", "pctDeb", "lon", "lat", "volChj", "volChjSig", "meanElevCh", "meanElev_1", "geoMassBal", "geoMassB_1", "percentCov"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["id", "pctDeb", "lon", "lat", "volChj", "volChjSig", "meanElevCh", "meanElev_1", "geoMassBal", "geoMassB_1", "percentCov", "demYears"], "EmptyFieldRule", "auto");

% Import the data
HMAGlacierAvgdHGeodeticMassBalanceHimalayas20002016 = readtable("C:\Users\Sourajit Sahoo\Desktop\Glacier\HMA_GlacierAvg_dH_GeodeticMassBalance_Himalayas_2000-2016.xlsx", opts, "UseExcel", false);
x=HMAGlacierAvgdHGeodeticMassBalanceHimalayas20002016.lat;
y=HMAGlacierAvgdHGeodeticMassBalanceHimalayas20002016.lon;
z=HMAGlacierAvgdHGeodeticMassBalanceHimalayas20002016.volChjSig;
x=str2double(x);
y=str2double(y);
z=str2double(z);
geodensityplot(x,y,z,'FaceColor','interp')
geobasemap grayterrain