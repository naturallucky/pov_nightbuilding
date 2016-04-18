//NIGHT BUILDING
//  recommend BackGround Music
//    - Gerry Mulligan  "Night Lights"
//    - Ramsey Lewis Trio The In Crowd Album

//object is mainly made <0,,0> to <+,,+> so pay attention when you rotate/scale objects.

//[Overall Structure] 3 parts(use 2 other inc files made for this scene file)
//1 init , camera
//   moon
//2 make each building objects(include house , tree , park/grass , car)
//   read buildings
//3 put place  


// todo : #local
// just in case  use diffrent i,j (such ia , ic ...)  at for loop

#version 3.7;
//---------------------------------------
// [Section 1] init & camera
//---------------------------------------

//only set initial value or init array ..
#include "nightbuilding.inc"
#declare bldgTN = bldgTN + 12;//reset (add hosue,tree... objects:total:5x3,add:4x3)


#macro setCamera(lx,ly,lz, tlax,tlay,tlaz , cratio)
	#declare csx = lx;
	#declare csy = ly;
	#declare csz = lz;
	#declare lax = tlax;
	#declare lay = tlay;
	#declare laz = tlaz;
	location<csx,csy,csz>
	look_at<lax,lay,laz>
	/*
	#declare CS = csx * cratio + lax *(1-cratio) ;
	#declare CY = csy * cratio + lay *(1-cratio) ;
	#declare CZ = csz * cratio + laz *(1-cratio) ;
	*/
	#declare CGX = lax - csx;
	#declare CGY = lay - csy;
	#declare CGZ = laz - csz;
#end

camera {
	//for calc volume (also csx,csz)
	#declare camerakaku = 120;
	

	//scene1 (from train? window　→) TODO make wire
	//setCamera(20+tick*70*bai,(8+tick*0)*bai,(5)*bai,0,0,0,1)
	//setCamera(csx, csy,csz,csx,12*bai,65*bai , .80)
	
	//scene2  (along and over the road)
	//setCamera(49.5*bai,9,tick*60*bai,0,0,0,1)
	//setCamera(csx, csy,csz,csx,csy-.5,csz+1 , .80)

	//scene3  (over city)
	/*
	setCamera((cos((9/16+tick*2/16)*pi*2)*.8+.95)*bai*landsize,
				15,
			  (sin((9/16+tick*2/16)*pi*2)*.8+.95)*bai*landsize,0,0,0,1)
	setCamera(csx, csy,csz,bai*landsize *.9, 12,bai*landsize *.9 , .80)
	#declare lookLower = 0;
	*/
		
	//scene4 (top to bottom  view)   
	//setCamera(50*bai, 1+tick*50,50*bai,0,0,0,1)
	//setCamera(csx, csy,csz,csx,csy-3,csz+3-tick*2.99 , .95)
    
	
	//scene5 (viewing car)
	//setCamera(tick*40*bai+20,3,10*bai,0,0,0,1)
	//setCamera(csx, csy,csz,csx+3,csy-1,csz , .90)

	//scene6 (flight view:rapid down,  back and turn)
	/*
	#declare camerakaku = 90;
	#if (tick < .5)
		setCamera(25*bai,(25+sin(-tick*pi)*15)*bai,(sin(tick*pi)*10+15)*bai
				25*bai,8*bai,(sin(tick*pi)*10+tick*3+15)*bai,1)
	#else
		#if (tick <.75)
			#declare t1 = (tick -.5)*2;
			setCamera((25)*bai,(10)*bai,(25+sin(t1*pi)*50)*bai
					,25*bai,(8)*bai,(26.5+sin(t1*pi)*53.5)*bai,1)
		#else
			#declare t1 = (tick -.5)*2;
			#declare t2 = (tick -.75)*4;
			setCamera((25+sin(t2*pi/2)*50)*bai,(10)*bai,(75-sin(t2*pi/2)*50)*bai
					,(25+t2*45)*bai,8*bai,(80-t2*70)*bai,1)
		#end
	#end
	*/
	
	
	//scene7 (circle)
	/*#declare camerakaku = 75;
	setCamera(30*bai,(7)*bai,30*bai
	,(30+cos(tick*pi*2)*40)*bai,(3+sin(tick*pi*2*2)*2)*bai,(30+sin(tick*pi*2)*40)*bai,1)
	*/
	
	//scene8 (for country view)
	//setCamera((50+60*cos((tick/3+4/3)*pi))*bai,1,(96+60*sin((tick/3+4/3)*pi))*bai
	//,50*bai,1,95*bai,1)

	
	
	//scene9 (for country view: stay)
	setCamera(25*bai,12,0,100,3,100,1)
	

	angle camerakaku
	#declare camerakaku = camerakaku * 1.2;

}

//---------------------------------------
// [Section 2] make & place objects
//---------------------------------------
//     land , lights  , house , car ...

/*
sky_sphere {
    S_Cloud4
}
*/

//moon
#declare moon = 
union{
/*	sphere {
		<0,0,0>, 6
		pigment {
			//color rgb<1,.8,.2>
			image_map {
				jpeg "seamless_concrete_texture.jpg"
				map_type 1
			}
		}
		finish {ambient 0.1}
		hollow
	}
*/
	sphere{0  6
		pigment { Clear}
		interior {
			media {emission <.12,.12,.12>} }
		hollow
	}
	sphere{0  6.2
		pigment { Clear}
		interior {
			media {emission <.033,.033,.031>} }
		hollow
	}

	translate <50*bai,330,500>
	interior{caustics .0 ior .9}
	no_shadow
};
object {moon}
light_source { <0,100000,0> color rgb <.04,.04,.04> }
#declare lightN[0] = lightN[0]+1;

//grand
/*
plane {
	y, 0
	texture {
		pigment { color rgb <.3,.1, 0> }
	}
}
*/

//land place
/*
box{<0,0,0><landsize * bai,0.2,landsize*bai>
	pigment {color rgb <1,1,1>}
}*/
box{<-1000,-1,-1000><1000,.001,1000>
	pigment {color rgb <1,1,1>}
}



// [light section ]

//for car front, [streetlight] building roof also
#declare whiteLight =
union{
	sphere{<0,0,0> .06
		pigment { White }
		finish { ambient .5 diffuse 1 brilliance 1 phong 1.0 specular 1 roughness .3 metallic 2}
		no_shadow
	}
	sphere{<0,0,0> .09
		pigment {Clear}
		interior {	media {emission  <.99,.99,.99>}}
		/*pigment { Clear }
		finish { F_Glass1 }
		finish {ambient 1.0}
		interior {I_Glass1 fade_color color rgb <.8,.2,0> caustics 0.88}]
		*/
		hollow
		no_shadow
	}
	sphere{<0,0,0> .18
		pigment {Clear}
		interior {	media {emission  <.55,.55,.55>}}
		hollow
		no_shadow
	}
};

//for street light,kanban
#declare streetlight =
union {
	object{whiteLight}
	box {<-.012,-.06,-.012><.012,-.9,.012>
		pigment {color rgb .2}}
}

//for back car ,  building top(for flight)
#declare redLight =
union{
	sphere{<0,0,0> .06
		pigment { Red }
		finish { ambient .5 diffuse 1 brilliance 1 phong 1.0 specular 1 roughness .3 metallic 2}
		no_shadow
	}
	sphere{<0,0,0> .09
		pigment {Clear}
		interior {	media {emission  <.93,.3,.1>}}
		hollow
		no_shadow
	}
	sphere{<0,0,0> .22
		pigment {Clear}
		interior {	media {emission  <.85,.16,.06>}}
		hollow
		no_shadow
	}
}


//  ....  it is difficult to adjust light volume (moon also)

#declare checkkaku = 0;
//eye sight degree  
#macro v2kakudoV(ov)
	#declare inradian = vdot(ov-<csx,csy,csz>,<CGX,CGY,CGZ>)
					/ (vlength(ov-<csx,csy,csz>)*vlength(<CGX,CGY,CGZ>));

	#declare kaku = degrees(acos(inradian));
	#if ( kaku > 180)
		#declare kaku = kaku - 360;
	#end
	#if (checkkaku < 30)
		//debugPrint("e-o gap degree", kaku,concat( " vx1:", str(vx1,3,0), ", ", str(vy1,3,0), ", ", str(vz1,3,0)))
		//debugPrint("e-o gap degree", kaku,concat( " ov:", vstr(3,ov:t,", ",3,1)))
		#declare checkkaku = checkkaku + 1;
	#end

#end

#macro v2kakudo(vx1,vy1, vz1)
	v2kakudoV(<vx1,vy1,vz1>)
#end

#macro checkBuildingBetween(ox,oy,oz, fx,fy,fz, rat)
	#declare tx = int((ox *rat + fx *(1-rat))/bai);
	#declare ty = int((oy *rat + fy *(1-rat))/bai);
	#declare tz = int((oz *rat + fz *(1-rat))/bai);
	
	#declare ret = 0;
	#if (tx < 0 | tx >= landsize | tz < 0 | tz >= landsize)
		#break;
	#else
		#declare h = land[tx][tz];
		#if (h > 0)
			#ifdef (buildingWY[h-1])
				#declare h = buildingWY[h-1];
				#if (h > ty)
					#declare ret = 1;
				#end
			#end
		#end
	#end
#end

#macro checkBuildingBetweenIter(ox,oy,oz, iter)
	#declare hc = 0;
	
	checkBuildingBetween(ox,oy,oz,  csx,csy,csz , .99)
	#declare hc = hc + ret;
	
	#for (it , 0 , iter-1)
		checkBuildingBetween(ox,oy,oz,  csx,csy,csz , 1/(iter+1)*(it+1))
		#declare hc = hc + ret;
	#end
#end


//for street 
#macro checkAndPlaceTownLight(sc,xx,yy,zz)
	object{streetlight scale sc translate<xx,yy,zz>}
	
	//for calc volume
	v2kakudo(xx,yy,zz)
	checkBuildingBetweenIter(xx,yy,zz, 3)
	#if (abs(kaku) < camerakaku & hc = 0)
		#declare tempDistan = vlength(<xx,yy,zz>-<csx,csy,csz>);
		#if (tempDistan < 8 *bai)
				light_source{<xx,yy,zz> color rgb <.217,.215,.216>
					 fade_distance 2.7 fade_power 1
					//media_interaction on media_attenuation on
					}
				#declare lightN[2] = lightN[2]+1;
		#else
		#if(tempDistan < 32 *bai  & mod(xx*100*29+zz*100*11,8)<1)//scatteredness by prime-number
				light_source{<xx,yy,zz> color rgb <.157,.155,.156>
					 fade_distance 2.7 fade_power 1
					//media_interaction on media_attenuation on
					}
				#declare lightN1[2] = lightN1[2]+1;
		#else
		#if	(tempDistan < 42 *bai 
				& mod(abs(xx-csx)*100*79 +abs(yy-csy)*100*577 +abs(zz-csz)*41 *11,100)
				 < (1-(abs(xx-csx)+abs(yy-csy)+abs(zz-csz))/260)*100/9) //scattered and (distance -> reciprocal ratio) instead "rand(SD)<.20"...
				light_source{<xx,yy,zz> color rgb <.117,.115,.116>
					 fade_distance 2.7 fade_power 1
					//media_interaction on media_attenuation on
					}
				#declare lightN2[2] = lightN2[2]+1;
		#end
		#end
		#end
	#end
#end

//for car
#macro checkAndPlaceLightSourceOnly(xx,yy,zz)
	//for calc volume
	v2kakudo(xx,yy,zz)
	checkBuildingBetweenIter(xx,yy,zz, 3)
	
	#if (abs(kaku) < camerakaku & hc = 0 )
		#declare tempDistan = vlength(<xx,yy,zz>-<csx,csy,csz>);
		#if (tempDistan < 8 *bai)
				light_source{<xx,yy,zz> color rgb <.012,.012,.012> 
					 fade_distance 3 fade_power 2
					media_interaction on media_attenuation on}
				#declare lightN[1] = lightN[1]+1;

		#else
			#if (tempDistan < 28 *bai & mod(xx*100*5+zz*100*3,5)<1)
					light_source{<xx,yy,zz> color rgb <.010,.010,.010> 
						 fade_distance 3 fade_power 2
						media_interaction on media_attenuation on}
					#declare lightN1[1] = lightN1[1]+1;
	
			#else
				#if (tempDistan < 40 *bai 
						& mod(abs(xx-csx)*100*37+abs(yy-csy)*100*349 +abs(zz-csz)*100*179  ,100)
						<	(1-(abs(xx-csx)+abs(yy-csy)+abs(zz-csz))/260)*100/10)
						light_source{<xx,yy,zz> color rgb <.005,.005,.005> 
							 fade_distance 3 fade_power 2
							media_interaction on media_attenuation on}
						#declare lightN2[1] = lightN2[1]+1;
				#end
			#end
		#end

	#end
	
#end


//for car
#macro checkAndPlaceRedLightSourceOnly(xx,yy,zz)
	//object{redLight scale sc translate<xx,yy,zz>}
	
	//for calc volume
	v2kakudo(xx,yy,zz)
	checkBuildingBetweenIter(xx,yy,zz, 3)
	#if (abs(kaku) < camerakaku & hc = 0)
		#declare tempDistan = vlength(<xx,yy,zz>-<csx,csy,csz>);
		#if (tempDistan < 8 *bai 
			| (tempDistan < 28 *bai & mod(xx*100*5+zz*100*3,7)<1)
			| (tempDistan < 40 *bai 
				& mod(abs(xx-csx)*100*71 +abs(yy-csy)*100*53 +abs(zz-csz)*100*379 ,100)
				< (1-(abs(xx-csx)+abs(yy-csy)+abs(zz-csz))/260)*100/10)
				)
					light_source{<xx,yy,zz> color rgb <.0222,.022,.026> 
						shadowless fade_distance 2 fade_power 1.5
						media_interaction on media_attenuation on}
					#declare lightN[4] = lightN[4]+1;
		#end
	#end
#end


//for kanban
//   roof,
#macro checkAndPlaceKanbanLightSourceOnly(v1)
	//object{whiteLight scale sc translate<xx,yy,zz>}
	
	//for calc volume
	v2kakudoV(v1)
	checkBuildingBetweenIter(vdot(v1,<1,0,0>),vdot(v1,<0,1,0>),vdot(v1,<0,0,1>), 3)
	#if (abs(kaku) < camerakaku & hc = 0)  // camerakaku/2
		/*& (lightN[3] <= 12
		 | (lightN[3] <= 20 & rand(SD)<.12)
		 )*/
		 
			#declare tempDistan = vlength(v1-<csx,csy,csz>);
			#if (tempDistan < 25 *bai 
				| (tempDistan < 35 *bai & mod(vdot(v1,<1,0,0>)*100*79+vdot(v1,<0,0,1>)*100*11,7)<1)
				| (tempDistan < 75 * bai 
					& mod(csx*11+csy*31+csz*7,100)<(abs(vdot(v1,<1,0,0>)-csx)
						+abs(vdot(v1,<0,1,0>)-csy)+abs(vdot(v1,<0,0,1>)-csz))/260*100/6)
				)
					light_source{v1 color rgb <.14,.14,.12> 
						 fade_distance 7 fade_power 1.2
						media_interaction on media_attenuation on}
					#declare lightN[3] = lightN[3]+1;
			#end
	#end
#end


//for high building tip
#macro checkAndPlaceRedTopLight(sc,v1)
	#if (vdot(v1,<0,1,0>) > 14 //height
		& mod(int(vdot(v1,<1,0,1>)+tick * totalSec),3)=0)// turn on only 1sec in 3 sec's cycle.(tpx is flactuations)
			object{redLight scale sc translate v1}
	
		//for calc volume
		v2kakudoV(v1)
		checkBuildingBetweenIter(vdot(v1,<1,0,0>),vdot(v1,<0,1,0>),vdot(v1,<0,0,1>), 3)
		#if (abs(kaku) < camerakaku & hc = 0)  // camerakaku/2
	
		
						light_source{v1 color rgb <.12,.011,.010> 
							 fade_distance 7 fade_power 2
						media_interaction on media_attenuation on}

						#declare lightN[5] = lightN[5]+1;
		

		#end
	#end
#end

//house (1x1  ... maybe)
#for (ii , bldgTN -15 , bldgTN -11)
//#declare ii = bldgTN -3;
#declare ij = ii- (bldgTN -15);
#declare buildingWX[ii] = 1;
#declare buildingWY[ii] = 2;
#declare buildingWZ[ii] = 1;
#declare building[ii] = object{union{
	// linear prism in z-direction: from ,to ,number of points (first = last)
	prism { -1.00 ,1.00 , 6
	       <-1.00, 0.50>,  // first point
	       < 1.00, 0.50>, 
	       < 1.00, 1.00>, 
	       < 0.00, 2.00>, 
	       <-1.00, 1.00>, 
	       <-1.00, 0.50>   // last point = first point!!!!
	       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction! Don't change this line! 
	
	       texture { pigment{ color DustyRose } 
	                 finish { phong 1.0 } 
	               } // end of texture
	
	       scale <1.00,1.00,1.00>       
	       rotate <0,0,0> 
	       translate <0.00,0.00,0.00> 
	     } // end of prism --------------------------------------------------------
	
	// linear prism in z-direction: from ,to ,number of points (first = last)
	prism { -1.10 ,1.10 , 7
	       <-1.05, 0.95>,  // first point
	       < 0.00, 2.00>,  
	       < 1.05, 0.95>, 
	       < 1.05, 1.00>, 
	       < 0.00, 2.05>, 
	       <-1.05, 1.00>, 
	       <-1.05, 0.95>  // last point = first point!!!!
	       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction! Don't change this line! 
	       texture { pigment{ color rgb <204/255-ij*.2,153/355+ij*.2,ij*.2>/*Scarlet*/ } 
	                 finish { phong 1.0 }
	               } // end of texture
	
	       scale <1.00,1.00,1.00>       
	       rotate <0,0,0> 
	       translate <0.00,0.00,0.00> 
	} // end of prism --------------------------------------------------------

	scale <.2*bai,.50*bai,.2*bai>
	translate <.8,-.38,.8>
}};
#end


//tree(1x1)
#for (ii , bldgTN -10 , bldgTN -6)
#declare ij = ii- (bldgTN -10);
//#declare ii = bldgTN -2;
#declare buildingWX[ii] = 1;
#declare buildingWY[ii] = 2;
#declare buildingWZ[ii] = 1;
#declare building[ii] = union{
	cone { <.5,0,.5>, 0.75, <.5,2.00,.5>, 0 
       texture { pigment{ color rgb<0.1*+.02*ij,0.4*.03*ij,0.10>*0.8 }                                     
                 normal { bumps 1.25 scale 0.05} 
                 finish { phong 1 reflection 0.00}
               } // end of texture

       scale  <.4*bai,.4*bai+ij*.7,.4*bai>  rotate<0,0,0>  translate<0.3*bai,0.4,0.3*bai>  
     }  // end of cone -------------------------------------- 
	cylinder{<0.5*bai,-.8,0.5*bai><0.5*bai,.5,0.5*bai> .1
		pigment {color rgb <1,.4,0>}
	}
	
	#if (ii > bldgTN-8)
		object{building[ii-int(ij*rand(SD)-.0001)-1]
			translate < rand(SD)*1-.5,0,rand(SD)*1-.5>
		}
		//debugPrint("hey! w-tree" ,ii,"")
	#end
	
};
#end

//park(1x1)
#for (ii , bldgTN -5 , bldgTN -1)
#declare ij = ii-(bldgTN -5);
//#declare ii = bldgTN -1;
#declare buildingWX[ii] = 1;
#declare buildingWY[ii] = 2;
#declare buildingWZ[ii] = 1;
#declare building[ii] = box {<.1*bai,0,.1*bai>
	<.9*bai,.01,.9*bai>
	pigment {color rgb <.2+ij*.02,.5+ij*.05,.2+ij*.03>}
}; 
#end


#declare car  =object{union{
	superellipsoid{ <0.25,0.25> 
     texture{ pigment{ color rgb <1, 1 , .9>  }
	              //finish { phong 1 }
	            } // end of texture
	     scale <.24,.08,.36> 
	     rotate<0,0,0> 
	     translate<0.1,0,0.1>
	} // -------------- end superellipsoid

	superellipsoid{ <0.25,0.25> 
	     texture{ pigment{ color rgb 1 }
	              //finish { phong 1 }
	            } // end of texture
	     scale <.20,.06,.20> 
	     rotate<0,0,0> 
	     translate<0.1,.1,0.1>
	} // -------------- end superellipsoid  
	//without lightsource
	object{redLight scale .9 translate<.010,0.03,-.23>}
	object{redLight scale .9 translate<.220,0.03,-.23>}
	object{whiteLight scale .7 translate<.010,0.02,.47>}
	object{whiteLight scale .7 translate<.220,0.02,.47>}
	
	translate <.2,0.1,.2>
	}
};




//---------------------------------------
// [Section 3] put object on the road
//---------------------------------------
// relatet to anime (so car , camera , and so light)


//load buildings' objects which was made beforehand.
#include "nightbuilding_scene_temp.inc"



//kanban , top, roof
debugPrint("lightRecNum",lightRecNum,"")
#for (il , 0, lightRecNum-1)
	//debugPrint("il",il,"")
	//debugPrint("lightRecType[il]",lightRecType[il],"")

	#switch (lightRecType[il])
		#case (1)
			checkAndPlaceKanbanLightSourceOnly(lightRecVec[il])
		#break
		#case (2)
			checkAndPlaceRedTopLight(1.1,lightRecVec[il])
		#break
		#case (3)
			checkAndPlaceKanbanLightSourceOnly(lightRecVec[il])
		#break
	#end
#end
		

#macro putRoadObjectsFixZ(ia,ZZ)
	//car (Japan , England)
	#if (mod(ia+ZZ*13,10) = 0 | mod(ia*23+ZZ*13,31) = 0)//random ratio :appearness
		//left side : + X
		object { 
			car 
			translate <-.3,0,-.3>
			rotate y*90
			scale .8
			translate <(ia)*bai+.1+.3+tick*(20+mod(ZZ+ia,5)*4),.2,(ZZ)*bai+.46+.3+.3>
		}
		checkAndPlaceLightSourceOnly((ia)*bai+.1+.3+tick*20+.26,.2,(ZZ)*bai+.46+.3+.3+0.125)
		checkAndPlaceLightSourceOnly((ia)*bai+.1+.3+tick*20+.26,.2,(ZZ)*bai+.46+.3+.3-0.125)
		checkAndPlaceRedLightSourceOnly((ia)*bai+.1+.3+tick*20-.32,.2,(ZZ)*bai+.46+.3+.3+0.125)
		checkAndPlaceRedLightSourceOnly((ia)*bai+.1+.3+tick*20-.32,.2,(ZZ)*bai+.46+.3+.3-0.125)
	#end
	#if (mod(ia+ZZ*13,20) = 0 | mod(ia*7+ZZ*3,29) = 0)//random
		// right side  :- X
		object { 
			car
			translate <-.3,0,-.3>
			rotate y*-90
			scale .8
			translate <(ia)*bai+.1+.3-tick*(20+mod(ZZ+ia,4)*5),.2,(ZZ)*bai+.01+.3>
		}
		checkAndPlaceLightSourceOnly((ia)*bai+.1+.3-tick*20-.28,.2,(ZZ)*bai+.01+.3+0.125)
		checkAndPlaceLightSourceOnly((ia)*bai+.1+.3-tick*20-.28,.2,(ZZ)*bai+.01+.3-0.125)
		checkAndPlaceRedLightSourceOnly((ia)*bai+.1+.3-tick*20+.30,.2,(ZZ)*bai+.01+.3+0.125)
		checkAndPlaceRedLightSourceOnly((ia)*bai+.1+.3-tick*20+.30,.2,(ZZ)*bai+.01+.3-0.125)
	#end

	//street light
	#if (mod(ia,3)=0)
		checkAndPlaceTownLight(1,(ia)*bai+.1 ,1.0,(ZZ)*bai+.001)
		checkAndPlaceTownLight(1,(ia)*bai+.1 ,1.0,(ZZ+.95)*bai)
	#end
#end

#macro putRoadObjectsFixX(ja,XX)
	
	#if  (mod(ja+XX*13,24) = 0 | mod(ja*11+XX*7,29) = 0)//random ratio :appearness
		//go along left side
		object{car translate <(XX+.1)*bai,.2,(ja)*bai+.1+tick*(20+mod(XX+ja,5)*4)>}
		checkAndPlaceLightSourceOnly((XX+.22)*bai+0.125,.2,(ja)*bai+.1+tick*20+.72)
		checkAndPlaceLightSourceOnly((XX+.22)*bai-0.125,.2,(ja)*bai+.1+tick*20+.72)
		checkAndPlaceRedLightSourceOnly((XX+.22)*bai+0.125,.2,(ja)*bai+.1+tick*20-.07)
		checkAndPlaceRedLightSourceOnly((XX+.22)*bai-0.125,.2,(ja)*bai+.1+tick*20-.07)
	#end
	#if (mod(ja+XX*17,33) = 0 | mod(ja*37+XX*3,31) = 0)//random ratio :appearness
		//go right side
		object{car
			translate <-.3,0,-.3>
			rotate y*180 
			translate <(XX+.51)*bai+.3,.2,(ja)*bai+.1+.3-tick*(20+mod(XX+ja,5)*4)>}
		checkAndPlaceLightSourceOnly((XX+.51)*bai+.3+0.125,.2,(ja)*bai+.1+.3-tick*20-.22)
		checkAndPlaceLightSourceOnly((XX+.51)*bai-.3+0.125,.2,(ja)*bai+.1+.3-tick*20-.22)
		checkAndPlaceRedLightSourceOnly((XX+.51)*bai+.3+0.125,.2,(ja)*bai+.1+.3-tick*20+.42)
		checkAndPlaceRedLightSourceOnly((XX+.51)*bai+.3-0.125,.2,(ja)*bai+.1+.3-tick*20+.42)
	#end
	
	#if (mod(ja,3)=0)
		checkAndPlaceTownLight(1,(XX+.02)*bai,1.0,(ja+.1)*bai)
		checkAndPlaceTownLight(1,(XX+.98)*bai,1.0,(ja+.1)*bai)
	#end
#end

// place road   , at this phrases.
//→
#for(ia,0,landsize-1)
	putRoadObjectsFixZ(ia,10)
	putRoadObjectsFixZ(ia,30)
	putRoadObjectsFixZ(ia,70)
#end

//↑
#for(ja,0,landsize-1)
	putRoadObjectsFixX(ja,12)
	putRoadObjectsFixX(ja,20)
	putRoadObjectsFixX(ja,49)
	putRoadObjectsFixX(ja,50)
	putRoadObjectsFixX(ja,80)
#end

//light
debugPrint("light all: ", lightN[0]+lightN[1]+lightN[2]
							+lightN1[1]+lightN1[2]+lightN2[1]+lightN2[2]
							+lightN[3]+lightN[4]+lightN[5],
							concat(" moon:" ,str(lightN[0],2,0),""))
debugPrint("(car:" lightN[1]
   ,concat(
    ", " , str(lightN1[1] , 1,0),", " , str(lightN2[1] , 1,0)
	," car red:",str(lightN[4] , 2,0) , "\n"
	," street:",str(lightN[2] , 1,0) ,", " , str(lightN1[2] , 1,0),", " , str(lightN2[2] , 2,0)
	," kanban,roof:",str(lightN[3] , 2,0)
	," top tip red:",str(lightN[5] , 2,0)
	,")"
))
