//NIGHT BUILDING
//  recommend BackGround Music
//    - Gerry Mulligan  "Night Lights"
//    - Ramsey Lewis Trio The In Crowd Album

//object is mainly made <0,,0> to <+,,+> so pay attention when you rotate/scale objects.

//[Overall Structure] 4 parts
// - prepare (this) file
//     "nightbuilding_pre.pov"
// - include file (used pre/post both)
//      "nightbuilding.inc"
// - post file (draw and anime)
//     "nightbuilding_post.pov"
//     make car,house, lights, street lights and anime&camera
// - object scene (written at pre , used at post)
//     "nightbuilding_scene_temp.inc"
//     road,building(with some lights,kanban)



//[Overall Structure(this file)] 4 Sections
//(1)init
//(2)make building objects
//(3)make Road
//(4)place building at each area & pass forward



// todo : #local
// just in case  use diffrent i,j (such ia , ic ...)  at for loop

#version 3.7;
//---------------------------------------
// [Section 1] init 
//---------------------------------------

// be need in both (pre/post)file
#include "nightbuilding.inc"

#fopen OF "nightbuilding_scene_temp.inc" write
//write down buildings and address of land (and lights location)

//---------------------------------------
// [Section 2] building
//---------------------------------------


#declare xdg = .32;
#declare ydg = .5;
#declare zdg = .2;

#declare wdwsw = .22;
#declare wdwsh = .22;

#declare wdwgsw = .32;
#declare wdwgsh = .21;

#declare kanbanRec = "";

// main ( following in this section)
//   call makeBuildingInner
//    ...(body,roof,light,window)
//     call light
//     call windowXFixLine :lightup(window)


#macro makeBuilding(X,Y,Z,sx,sy,sz)
	#declare buildingWX[ii] = sx;
	#declare buildingWY[ii] = sy;
	#declare buildingWZ[ii] = sz;

	makeBuildingInner(X*bai+.05*(sx+sy),Y,Z*bai+.05*(sx+sy)
					,sx*bai-.1*(sx+sy),sy,sz*bai-.1*(sx+sy))
					
	//debugPrint("ii",ii,"")
	//debugPrint("buildingWX",buildingWX[ii],"")
#end

#macro setLight(lt,x1,y1,z1)
	#if (lightFN < maxLightFN)
		#declare light[ii][lightFN] = <x1,y1,z1>;
		#declare lightF[ii][lightFN] = lt;
		#declare lightFN = lightFN +1;
	#end
#end

#macro makeBuildingInner(X,Y,Z,sx,sy,sz)
#write(OF,"
union{
	//main body
	box {<",X,",",Y,",",Z,"> <",X+sx,",",Y+sy,",",Z+sz,">")
		#if (rand(SD)>.92 & sy > 10)
			#write(OF,"pigment {color .97}
			finish{reflection .8 ambient .9 diffuse .3}
			interior{ior 0.02}")
		#else
			#write(OF,"pigment {color buildingC}
			finish{reflection .045 ambient .04 diffuse .7 crand .05}
			interior{ior 0}")
		#end
	#write(OF,"}\n\n")
	
	//kanban
	#if (rand(SD) > .42 & sx > 10 & sy >= 8)
		#write(OF,"polygon{5,<0,0><0,1><1,1><1,0><0,0>
			pigment {image_map {png ")
				#declare kanbanID = int(rand(SD)*3);
				#declare kanbanRec = concat(kanbanRec, str(kanbanID,1,0));
				#switch (kanbanID)
					#case (0)
						#write(OF,"\"oronaminC_kanban2.png\"")
					#break;
					#case (1)
						#write(OF,"\"panasonicKanban.png\"")
					#break;
					#else
						#write(OF,"\"sonyKanban.png\"")
					#break;
				#end
			#write(OF,"
			once interpolate 2
			}}
			scale<10,3,.1>
			translate<",X+ (sx-10)/2,",",Y + sy + .7,",",Z+.1">
		}\n\n")
		#write(OF,"object{whiteLight scale 2.2 translate<", X+ (sx-10)/2 ,"  ,", Y + sy + 3.7,",",Z-.1,">}\n")
		#write(OF,"object{whiteLight scale 2.2 translate<", X+ (sx-10)/2+5," ,",Y + sy + 3.7,",",Z-.1,">}\n")
		#write(OF,"object{whiteLight scale 2.2 translate<", X+ (sx-10)/2+10,",",Y + sy + 3.7,",",Z-.1,">}\n")
		setLight(1,X+ (sx-10)/2   ,Y + sy + 3.7,Z-.1)
		setLight(1,X+ (sx-10)/2+5 ,Y + sy + 3.7,Z-.1)
		setLight(1,X+ (sx-10)/2+10,Y + sy + 3.7,Z-.1)
		//#warning concat("oronaminC!! " , str(ii,4,0))
	#end

	#declare tpx = X;
	#declare tpy = Y;
	#declare tpz = Z;
	#declare tpsx = sx;
	#declare tpsy = sy;
	#declare tpsz = sz;
	
	//tower at top of building
	#while (rand(SD)>.65)
		#write(OF "\n\n//tower\n")
		#write(OF,"box {<",tpx+tpsx*.2,"     ,",tpy+tpsy,"               ,",tpz+tpsz*.2,">
			 <",tpx+tpsx-tpsx*.2,",",tpy+tpsy+max(tpsy*.3,2),",",tpz+tpsz-tpsz*.2,">
			pigment {color buildingC}
			finish{reflection .024 ambient .04 diffuse .7 crand .05}
			interior{ior 0}
		}\n\n")
		#declare tpx = tpx+ tpsx*.2;
		#declare tpy = tpy+ tpsy;
		#declare tpz = tpz+ tpsz*.2;
		#declare tpsx = tpsx*.6;
		#declare tpsy = max(tpsy*.3,2);
		#declare tpsz = tpsz*.6;
	#end

	//light of roof hedge 
	#if (tpx = X | rand(SD)>.3)
		#write(OF "\n\n//hedge\n")
		#write(OF,"box {<",tpx-.01,"     ,",tpy+tpsy-.2,",",tpz-.01,">
			 <",tpx+.01+tpsx,",",tpy+tpsy-.1,",",tpz+.01+tpsz">
				pigment {")
			#if (rand(SD)>.4)
					#write(OF,"checker White, color buildingC
				    scale ", rand(SD) *.4+.15)
			#else
					#write(OF,"color <1,1,1>")
			#end
			#write(OF,"}
		}\n")
	#end
	

	//safety flight hight light

			setLight(2,tpx + tpsx/2,tpy+tpsy+.3,tpz+tpsz/2)

	//building light at above the roof
	#if (Y+sy > 6)
		#write(OF "\n\n//light above roof\n")
		#write(OF,"object{whiteLight scale 1 translate <",X,"   ,",Y+sy+.2,",",Z,"   >}
		object{whiteLight scale 1 translate <",X+sz,",",Y+sy+.2,",",Z,"   >}
		object{whiteLight scale 1 translate <",X   ,",",Y+sy+.2,",",Z+sz,">}
		object{whiteLight scale 1 translate <",X+sz,",",Y+sy+.2,",",Z+sz,">}\n")

		setLight(3,X   ,Y+sy+.2,Z   )
		setLight(3,X+sz,Y+sy+.2,Z   )
		setLight(3,X   ,Y+sy+.2,Z+sz)
		setLight(3,X+sz,Y+sy+.2,Z+sz)
	#end
	
	///window   ・・・・注
	//window color
	#declare typ =	int(rand(SD)*7.01);

	#declare col = color <1,1,.9>;
	#switch (typ)
		#range (0,1)//yellow
			#declare col = color <1,1,.72>;
		#break
		#case (2)//orange
			#declare col = color <1,.78,.6>;
		#break
		#case (3)//green
			#declare col = color <.82,.98,.82>;
		#break
		#case (4)//blue
			#declare col = color <.82,.84,.9>;
		#break
		#default
			#declare col = color <1,1,.9>;
		#break
	#end

	//window
	windowZFixLine(X,	  Y, Z, sx,sy,col,-.001)
	windowXFixLine(X,	  Y, Z, sy,sz,col,-.001)
	windowXFixLine(X+sx,Y, Z, sy,sz,col, .001)
	
	//for calc volume
	#if (rand(SD)>.7)
		windowZFixLine(X,Y,Z+sz,sx,sy,col,.001)
	#end
#write(OF,"}\n\n\n")
#end


// window section (attach on building)

#macro windowZFixLine (X,Y,Z,sx,sy,bodyColor,thickDir) // front,depth↑↓
	#declare ia = 0;
	#write(OF "\n\n//window Z\n")
	#while (xdg+(ia+1)*(wdwsw+wdwgsw)< sx)
		#if (rand(SD)<=.97)
			#declare ja = 0;
			#while (ydg+(ja+1)*(wdwsh+wdwgsh) < sy)
				#if (rand(SD)<.28)//for calc volume
					#write(OF,"polygon{5,<0,0><0,1><1,1><1,0><0,0>")  // using box{} is almost same time
					#if (rand(SD)<.7)
						#write(OF,"pigment {color rgb <",vstr(3,bodyColor,", ",3,2),">}
						finish {reflection .7 ambient .9}")
					#else
						#write(OF,"pigment {color Silver}
						finish {reflection .9 ambient.9}")
					#end
					#write(OF,"scale<",wdwsw,",",wdwsh,",.1>
					translate<",X+xdg+ia*(wdwsw+wdwgsw),", ",Y+ydg+ja*(wdwsh+wdwgsh),", ",Z+thickDir,">
					}\n")
				#end
				#declare ja = ja+1;
			#end
		#end
		#declare ia = ia+1;
	#end
#end

#macro windowXFixLine (X,Y,Z,sy,sz,bodyColor,thickDir)//left , right ←→
	#declare ib = 0;
	#write(OF "\n\n//window X\n")
	#while (zdg+(ib+1)*(wdwsw+wdwgsw)< sz)
		#if (rand(SD)<=.97)
			#declare jb = 0;

			#while (ydg+(jb+1)*(wdwsh+wdwgsh)< sy)
				#if (rand(SD)<.28)//for calc volume
					#write(OF,"polygon{5,<0,0><0,1><1,1><1,0><0,0>")
						#if (rand(SD)<.7)
							#write(OF,"pigment {color rgb <",vstr(3,bodyColor,", ",3,2),">}
							finish {reflection .7 ambient .9}")
						#else
							#write(OF,"pigment {color Silver}
							finish {reflection .9 ambient.9}")
						#end
						#write(OF,"rotate y*-90
						scale<.1,",wdwsh,",",wdwsw,">
						translate<",X+thickDir,", ",Y+ydg+jb*(wdwsh+wdwgsh),", ", Z+zdg+ib*(wdwsw+wdwgsw),">
					}\n")
				#end
				#declare jb = jb+1;
			#end
		#end
		#declare ib = ib+1;
	#end
#end





#declare maxLightFN = 10;
#declare light = array[bldgTN][maxLightFN];
#declare lightF = array[bldgTN][maxLightFN];
#for (ii, 0 , bldgTN-1)
	#for (jj , 0 , maxLightFN-1)
		#declare lightF[ii][jj] = 0;
	#end
#end



#write(OF "\n\n//make building\n")

//1size = 1block = 1.0*"bai" scale  (10 block means 15.0 scale in pov-ray)
//      in landsize^2 area 
#for (ii, 0 , bldgTN-1-5)  // at following,  make 5 buildings each (3x3 , 2x2 , 1x1(park,house,tree)) 
	//set size
	#declare wx = 3 + int(rand(SD)*4);
	#declare wy = 8 + int(rand(SD)*5);
	#declare wz = 5 + int(rand(SD)*5);

	#if  (rand(SD)>.7)
		#declare wx = wx + 2 +int(rand(SD)*3);
	#end
	#if  (rand(SD)>.8)
		#declare wz = wz + 2 +int(rand(SD)*3);
	#end
	#if  (rand(SD)>.94)
		#declare wx = max(wx,wz);
		#declare wz = wx;
	#end
	#if  (rand(SD)>.92)
		#declare wx = wx + 3+int(rand(SD)*4);
		#declare wy = wy + 7+int(rand(SD)*12);
		#declare wz = wz + 3+int(rand(SD)*4);
		
		//#warning "big tower! appeard!"
	#end
	
	#declare lightFN = 0;
	#write(OF,"#declare building[",ii,"] =")
	 makeBuilding(0,0,0,wx,wy,wz)
	#write(OF, ";\n")
	
	#write(OF,"#declare buildingWX[",ii,"] = ",buildingWX[ii],";\n")
	#write(OF,"#declare buildingWY[",ii,"] = ",buildingWY[ii],";\n")
	#write(OF,"#declare buildingWZ[",ii,"] = ",buildingWZ[ii],";\n\n")
#end

#declare ii = bldgTN -5;
#declare wx = 3;
#declare wy = 4+int(rand(SD)*6);
#declare wz = 3;
#declare lightFN = 0;
#write(OF,"#declare building[",ii,"] =")
 makeBuilding(0,0,0,wx,wy,wz)

#declare ii = bldgTN -4;
#declare wx = 2;
#declare wy = 3+int(rand(SD)*5);
#declare wz = 2;
#declare lightFN = 0;
#write(OF,"#declare building[",ii,"] =")
 makeBuilding(0,0,0,wx,wy,wz)



//house (1x1  ... maybe)  ... x5 type when put
#declare ii = bldgTN -3;
#declare buildingWX[ii] = 1;
#declare buildingWY[ii] = 2;
#declare buildingWZ[ii] = 1;

//tree(1x1) ... x5 type
#declare ii = bldgTN -2;
#declare buildingWX[ii] = 1;
#declare buildingWY[ii] = 2;
#declare buildingWZ[ii] = 1;

//park(1x1) ... x5 type
#declare ii = bldgTN -1;
#declare buildingWX[ii] = 1;
#declare buildingWY[ii] = 2;
#declare buildingWZ[ii] = 1;



//for not overlapping(1 = 1block)
#declare land =array [landsize][landsize];//[X][Z] :area (0,0)-> (landsize,landsize):(right in pov-ray)(back in pov-ray)
#for(i,0,landsize-1)
	#for(j,0,landsize-1)
		#declare land[i][j] = 0;
	#end
#end

//---------------------------------
// [Section 3] Road
//---------------------------------
// road section( place road center line , car , street light)

//[main "make road"]
    // each X,Z axis
//---
// - buildRoad    ...fill edge to edge
//      centerline  
//---

#write(OF "\n\n//make load\n")

//road → : fix Z value
#macro buildRoadZ(ZZ)
	#write(OF concat("\n//build Road ZZ ",str(ZZ,3,0)," \n" ))
	#write(OF,"box{<0,0,",(ZZ)*bai+.01,"><",landsize*bai,",.1,",(ZZ+1)*bai-.01,">
		pigment {color rgb <.8,.8,.8>}
	}\n")
	#write(OF,"box{<0,0,",(ZZ)*bai+.015,"><",landsize*bai,",.101,",(ZZ+1)*bai-.015,">
		pigment {color rgb <.83,.8,.8>}
	}\n")
	
	//line
	#write(OF,"box{<",(0+.1)*bai,",",.11,",",(ZZ+.49)*bai,"><",(landsize+.1)*bai+bai*.5,",",.11,",",(ZZ+.49)*bai+.1,">
		pigment {checker .92, Clear  scale .3}
		finish {reflection .2 specular .2 roughness .05}
	}\n")

#end
//road ↑ : fix X value
#macro buildRoadX(XX)
	#write(OF concat("\n//build Road XX ",str(XX,3,0)," \n" ))
	#write(OF,"box{<",(XX)*bai+.02,",0,0><",(XX+1)*bai-.02,",.1,",landsize*bai,">
		pigment {color rgb <.8,.8,.8>}
	}\n")
	#write(OF,"box{<",(XX)*bai+.025,",0,0><",(XX+1)*bai-.025,",.101,",landsize*bai,">
		pigment {color rgb <.82,.8,.76>}
	}\n")
	
	
	//line
	#write(OF,"box{<",(XX+.49)*bai,",",.11,",",(0+.1)*bai,"><",(XX+.49)*bai+.1,",",.11,",",(landsize+.1)*bai+bai*.5,">
		pigment {checker .92, color Clear  scale .3}
		finish {reflection .2 specular .2 roughness .05}
	}\n")
	
#end



// place road  .
//→
buildRoadZ(10)
buildRoadZ(30)
buildRoadZ(70)
#for(ia,0,landsize-1)
	#declare land[ia][10] = -1;
	#declare land[ia][30] = -1;
	#declare land[ia][70] = -1;
#end

//↑
buildRoadX(12)
buildRoadX(20)
buildRoadX(49)
buildRoadX(50)
buildRoadX(80)
#for(ja,0,landsize-1)
	#declare land[12][ja] = -1;
	#declare land[20][ja] = -1;
	#declare land[49][ja] = -1;
	#declare land[50][ja] = -1;
	#declare land[80][ja] = -1;
#end




//---------------------------------------
// [Section 4] place building (virtual area mapping:land[][])
//---------------------------------------
#declare buryland = 0;

//building
#macro checkAndBuild(buildingType,tx,tz,fractuX,fractuZ,yRotate)//check ocupied land(  land[X+yx][Z+yz] {X,Z|landsize} )
	#declare ret = -1;//fail (already occupied)

	//bound check in program memory.
	#if ((tx + buildingWX[buildingType] < landsize)
		& (tz + buildingWZ[buildingType] < landsize)
		& tx >= 0 & tz >= 0)
		#for (ic,  tx, tx+buildingWX[buildingType]-1)
			#for (jc,  tz, tz+buildingWZ[buildingType]-1)
				#if (land[ic][jc] != 0)
					#declare ret = 0;//fail. out of bound
					#break;
				#end
			#end
			#if (ret = 0)
				#break;
			#end
		#end
	
		#if ( ret = -1)
			//put building
			#declare bt2 = buildingType;
			#if ((buildingWX[buildingType] = 1 & buildingWZ[buildingType] =1 & rand(SD)<.55)
				 |(buildingWX[buildingType] <= 3 & buildingWZ[buildingType] <=3 & rand(SD)<.04)) //for calc volume
				//keep  vacant
				
				#declare skipbuilt = skipbuilt +1;
				#declare bt2 = -2;
			#else
				#declare built = built +1;
				
				#if (buildingType >= bldgTN- 3)
					#declare bt2 = (buildingType -bldgTN)*5+int(rand(SD)*4.9999)+(bldgTN+12);
				#end

				#if (yRotate = 0)
					#write(OF,"object{building[",bt2,"] 
							translate <",tx*bai+fractuX,",",0,",",tz*bai+fractuZ,">}")
				#else
					//for fractuation
					#write(OF,"object{building[",bt2,"] 
							translate <",-buildingWX[buildingType]*bai/2," , 0 
									 , ",-buildingWZ[buildingType]*bai/2,">
							rotate y*",yRotate,"
							translate <",tx*bai+fractuX,"+buildingWX[",buildingType,"]*",bai/2,",0
									  ,",tz*bai+fractuZ,"+buildingWZ[",buildingType,"]*",bai/2,">}")
				#end


				//kanban , top, roof(for hand pass lights info)
				#for (il , 0, maxLightFN-1)
					#if (lightF[buildingType][il] != 0 & lightRecNum < lightRecMax)
						#declare lightRecType[lightRecNum] = lightF[buildingType][il];
						#declare lightRecVec[lightRecNum] = <tx*bai+fractuX,0,tz*bai+fractuZ>+ light[buildingType][il];
						
						#declare lightRecNum = lightRecNum+1;
					#end
				#end
			#end
			
			//set flag
			#for (id, tx, tx+buildingWX[buildingType]-1)
				#for (jd, tz, tz+buildingWZ[buildingType]-1)
					#declare land[id][jd] = bt2+1;
					#declare buryland = buryland+1;
				#end
			#end
			#declare ret = -2;// place this time! (not occupied)
			#write(OF, "\n\n")
			#break;
		#end
	#end
#end

// built essentially here.

#declare built = 0;
#declare skipbuilt = 0;
#declare tx = int(rand(SD)*landsize);
#declare tz = int(rand(SD)*landsize);


#for(ib,0,200)
	#declare limitLoop = landsize*10;
	#declare bdt = int(rand(SD)*bldgTN-.001);

	#while (limitLoop >=0)
		#declare limitLoop = limitLoop -1;

		//#declare tz = int(rand(SD)*3)-1;
		#if (tx >= landsize) 
			#declare tx = 10*int(rand(SD)*3.01);
			#declare tz = tz+1;
			#if (built > 100 & rand(SD)>.995)
				#declare tz = 20*int(rand(SD)*4);
			#end
			
			#if (tz >= landsize)
				#declare tz = 10*int(rand(SD)*3.01);
			#end
		#end
		#if (tx < 0) 
			#declare tx = 0;
		#end
		#if (tz < 0) 
			#declare tz = 0;
		#end

		#if (tx = tz)
			checkAndBuild(bdt,tx,tz,0,0,(int(rand(SD)*2.999)-1)*90)
		#else
			checkAndBuild(bdt,tx,tz,0,0,0)
		#end
		#if (ret =-2)
			#declare tx = tx + buildingWX[bdt];
			#break
		#end

		#declare tx = tx+1;
	#end
	
	#if (limitLoop < 0)
		#declare tz = 15*int(rand(SD)*2);
	#end
#end

debugPrint("built1: ", built,
 concat( " skip built1: ", str(skipbuilt,3,0)))

// from here
// bury vacant land area conscientiouslly (descend order by big size building)

//bury blank by 3x3 building
#for (ie,  0, landsize-1)
	#for (je,  0, landsize-1)
		checkAndBuild(bldgTN-5,ie,je,0,0,0)
		#if (ret = -2)
			#declare je = je+buildingWX[bldgTN-5]-1;
		#end
	#end
#end

//bury by 2x2 building
#for (ie,  0, landsize-1)
	#for (je,  0, landsize-1)
		checkAndBuild(bldgTN-4,ie,je,0,0,0)
		#if (ret = -2)
			#declare je = je+buildingWX[bldgTN-4]-1;
		#end
	#end
#end


//bury in 1x1 block area by constructure(house , tree, park/grass  or remain vacant..)
#for (ie,  0, landsize-1)
	#for (je,  0, landsize-1)
		checkAndBuild(bldgTN-3+int(rand(SD)*2.999),ie,je,
		rand(SD)*.32-.16,rand(SD)*.32-.16,
		(int(rand(SD)*2.999)-1)*90)
	#end
#end

//for debug
//about 10% calc volume
debugPrint("built2: ", built,
 concat( " skip built2: ", str(skipbuilt,3,0)))

debugPrint("buryland: ", buryland, "")


//80% calc volume
//light
debugPrint("lightRecNum: ", lightRecNum, "")

//hand pass lights info.
#write (OF ,"#declare lightRecNum = ",lightRecNum-1,";\n")
#for (il , 0 , lightRecNum-1)
	#write (OF ,"#declare lightRecType[",il,"] = ",lightRecType[il],";\n")
	#write (OF ,"#declare lightRecVec[",il,"] = <", vstr(3,lightRecVec[il],", ",3,1),">;\n")
#end

#write (OF ,"#declare land = array[",landsize,"][",landsize,"] \n")
#for (i , 0 , landsize-1)
	#if (i = 0)
		#write(OF , "{")
	#else
		#write(OF , ",")
	#end
	#for (j , 0 , landsize-1)
		#if (j = 0)
			#write(OF , "{")
		#else
			#write(OF , ",")
		#end
		#write (OF ,land[i][j])
	#end
	#write (OF ,"}\n")
#end
#write (OF ,"};\n\n")


#write (OF , "// kanbanRec: "kanbanRec)
#warning concat("kanbanRec:" ,kanbanRec)

#fclose OF


camera {
	location <1,2.5,-4.5>
	look_at <0,3,1>
	angle 120
}

light_source { <7, 100, -100> color rgb 1}

text { ttf "arial.ttf", "success", 0.42, 0.0 // thickness, offset

       texture{ pigment{ color Red } 
              //normal { bumps 0.5  scale 0.01 }
                finish { crand .1 phong 0.1 }
              } // end of texture
       normal {dents 1.75 scale 1.25} 

       scale<1,1.25,1>*2.6
       translate<-3.10,3.10,0.00 >
      } // end of text object ---------------------------------------------

text { ttf "arial.ttf", "finish", 0.12, 0.0 // thickness, offset

       texture{ pigment{ color Yellow } 
              //normal { bumps 0.5  scale 0.01 }
           		finish { ambient .5 diffuse 1 brilliance 1 phong 1.0 specular 1 roughness .3 metallic 2}

              } // end of texture

       scale<1,1.25,1>*1.2
       translate<-5.10,0.10,0.00 >
      } // end of text object ---------------------------------------------


text { ttf "arial.ttf", "All process clear!", 0.08, 0.0 // thickness, offset

       texture{ pigment{ color rgb<1,1,1>*1.3 } 
              //normal { bumps 0.5  scale 0.01 }
                finish { phong 0.1 }
              } // end of texture

       scale<1,1.25,1>*0.8
       translate<0.10,0.10,0.00 >
      } // end of text object ---------------------------------------------
