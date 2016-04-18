// be need in both (pre/post)file
#version 3.7;

#include "colors.inc"

global_settings {
	assumed_gamma 2.2
	max_trace_level 5
}
#declare SD = seed(1278334);

#declare bai = 1.5;//magnify
#declare landsize = 100;

//for anime
#declare tick = clock;
#declare totalSec = (180)/30;// 180 means  (0～1 clock) = 180(+KFF) = 6sec * 30fps.

//for calc volume (light number)
#declare lightN = array[6]{0,0,0,0,0,0};
#declare lightN1 = array[6]{0,0,0,0,0,0};//for light analysis
#declare lightN2 = array[6]{0,0,0,0,0,0};//for light analysis

#declare dbgf =1;
#macro debugPrint(l , vl , l2)
	#if (dbgf = 1)
		#warning concat(l, str(vl,4,0), l2)
	#end
#end
	
//essentially makes buildings here(There  are macro above)
#declare bldgTN = 25;//type variety (not building amount)
#declare building = array[bldgTN+12];   // 3x5 house , park tree
#declare buildingWX = array[bldgTN+12];
#declare buildingWY = array[bldgTN+12];
#declare buildingWZ = array[bldgTN+12];


#declare buildingC = Gray40;


#declare lightRecMax = 2000;
#declare lightRecVec = array [lightRecMax];
#declare lightRecType = array [lightRecMax];
#declare lightRecNum = 0;
#for (ii, 0 , bldgTN-1)
	#declare lightRecType[ii] = 0;
#end
