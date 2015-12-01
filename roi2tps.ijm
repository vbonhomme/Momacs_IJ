
//empties the Log window
print("\\Clear");
//initializes an array to store ROI indices of curves (if any)
CURVES=newArray();
//loop over ROIs
for (i=0; i<roiManager("count"); i++){
	//selects the i-th ROI
	roiManager("select", i);
	//LM case: concatenates all LMs along ROIs
	if (Roi.getType() == "point") {
		getSelectionCoordinates(LMnewx, LMnewy);
		LMx=Array.concat(LMx, LMnewx);
		LMy=Array.concat(LMy, LMnewy);
	}
	//CURVES case: stores the concerned ROI ids
	if (Roi.getType()=="polyline")Ê{
		CURVES=Array.concat(CURVES, i);
	}
}

//Starts writing the TPS file with the number of LMs
LM="";
print("LM="+((LMx.length)-1));
for (i=1; i<LMx.length; i++)
	print(LMx[i]+" "+LMy[i]);
//If curves have been detected, loop over ids and adds them to Log
if (CURVES.length>0){
	//Prints their number to please TPS format
	print("CURVES="+CURVES.length);
	//Loops over each curve
	for (i=0; i<CURVES.length; i++){
		roiManager("select", CURVES[i]);
		getSelectionCoordinates(CURVESx, CURVESy);
		//Prints the number of coordinates for curve[i]
		print("POINTS=", CURVESx.length);
		//Prints coordinates for curve[i]
		for (j=0; j<CURVESx.length; j++)
			print(CURVESx[j]+" "+CURVESy[j]);
	}
}
//Adds image name
print("IMAGE="+getTitle);

//TPS name = image name - extension + ".tps", in the same folder
    fullname = getTitle;
    dotIndex = indexOf(fullname, ".");
    name = substring(fullname, 0, dotIndex); 
	dir = getDirectory("image");
    index = lastIndexOf(name, "\\"); 
    if (index!=-1) name = substring(name, 0, index); 
    tpspath = dir + name + ".tps";
	txtpath = dir + name + ".txt";

// Writes this beauty
selectWindow("Log"); Ê//select Log-window 
save(txtpath); 
File.rename(txtpath, tpspath);

//getInfo("slice.label");
