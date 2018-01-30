#include "colors.inc"   // needed for colour defs
#include "stones.inc"  // used for stone shaft
#include "rad_def.inc" // radiosity file for high quality level 
#include "shapes.inc"
#include "metals.inc"
#include "glass.inc"  // for the glass torus
#include "woods.inc"
// to draw rotations of rotations of rotations. 6D reps possible
// three vector directions (rep by fletched arrows) and three bivector 
// directions represented by rotations of those arrows
// colour scheme: rgb = xyz, yellow = rg, c = gb = yz, m = rb= zx
global_settings {max_trace_level 5}



  camera {
    location <-20, 4, -20>
    look_at 0
    angle 20
  }
  background { color White } // to make the torus easy to see
  light_source { <10, 50, -50> White }
  
#declare Extendx = 0;  // Extend arrow to aid visualisation
#declare Extendz = 0;  // 
#declare Extendy = 0.2;  // 
#declare ExtendE = 0.2;  // 
#declare Step = 4;    //number of degrees between arrows
                                  
 #declare ArrowE = union {
    

     cone {
    <0.0+Extendx, 0,   0>, 0.3  // Centre /radius one end
    < 0.5+Extendx, 0,  0> 0  // Centre, radius other end
    scale 1.0   
    texture {
      T_Stone15     // Pre-defined from stones.inc
      pigment { Red }
      scale 1       // Scale by the same amount in all
                    // directions
    }    //end texture
    scale <1,0.2,1.0> // Flatten in y direction to help track rotations
   }       //end cone 
    
   cone {
    <0.0+Extendx, 0,   0>, 0.1  // Centre /radius one end
    < 0.0, 0.6,  0> 0  // Centre, radius other end
    scale 1.0   
    texture {
      T_Stone15     // Pre-defined from stones.inc
      pigment { Green } //xy plane marker fletching
      scale 1       // Scale by the same amount in all
                    // directions
    }    //end texture
    scale <1,1,0.3> // Flatten in xy direction to help track rotations
   }       //end cone 
    cone {
    <0.0+Extendx, 0,   -0.01>, 0.1  // Centre /radius one end
    < 0.0, 0.0,  -0.6> 0  // Centre, radius other end povray lefthanded coords hence -ve
    scale 1.0   
    texture {
      T_Stone15     // Pre-defined from stones.inc
      pigment { Blue } //xz plane marker
      scale 1       // Scale by the same amount in all
                    // directions
    }    //end texture
    scale <1,0.3,1> // Flatten in y direction to help track rotations
   }       //end cone 
   scale 1
   
  }    // end union  // end defn of arrowx


   
 
   #declare Minor = 0.2; // minor axis of torus positron
   #declare Major = 1.5;  
   #declare Index = 1;   // main loop counter
   #declare Amplitude = 90*Minor/Major;  // 90 ensures right angle if major=minor
 
  #declare Torusp = union{    // construct torus object
#while(Index <= 360/Step)
   #declare Rot1 = (Index)*-Step; // this is main phase counter in degrees
   #declare Rot2 = Rot1*2;      // main rotation counter 2*Rot1 for fermion
   #declare Rot3 = Rot1*0;   // tumble rotation
   #declare Rotx = Rot1*-1;    // rotation of x axis in yz plane
   #declare Roty = Rot1*0;   // rotation of y axis in zx plane
   #declare Rotz = Rot1*0;  // rotation of z axis in xy plane
   #declare Rock = sin(Rot1*pi/180); // sin argument in radians
   #declare Deviate = Amplitude*Rock; //deviation from parallality
   #declare AxesJ = union {    //insert bivector rotations
     object { ArrowE rotate <Rotx,0,0>}
   scale 0.7                         
   }// end union 
   object { AxesJ 
    rotate <-0*Rot1,0,0>   //untwist = Rot1 for twisted strip on eye
    rotate <Deviate,0,0>   // deviation from untwist for paths off eye
    translate Minor*y      // minor axis translation
    rotate <Rot1,0,0>      // phase rotation (mirror of untwist)- frequency
    translate Major*y      // major (momentum) axis
    rotate <0,0,Rot2>      // momentum rotation - clock
    rotate <0,Rot3,0>}     // tumble rotation to cons momentum (usually frozen)

      #declare Index = Index + 1;
#end
} // end torusp
 
   #declare Minor = 0.2; // minor axis of torus electron
   #declare Major = 1.5;  
   #declare Index = 1;   // main loop counter
   #declare Amplitude = 90*Minor/Major;  // 90 ensures right angle if major=minor
 
  #declare Toruse = union{    // construct torus object
#while(Index <= 360/Step)
   #declare Rot1 = (Index)*Step; // this is main phase counter in degrees
   #declare Rot2 = Rot1*2;      // main rotation counter 2*Rot1 for fermion
   #declare Rot3 = Rot1*0;   // tumble rotation
   #declare Rotx = Rot1*-1;    // rotation of x axis in yz plane
   #declare Roty = Rot1*0;   // rotation of y axis in zx plane
   #declare Rotz = Rot1*0;  // rotation of z axis in xy plane
   #declare Rock = sin(Rot1*pi/180); // sin argument in radians
   #declare Deviate = Amplitude*Rock; //deviation from parallality
   #declare AxesJ = union {    //insert bivector rotations
     object { ArrowE rotate <Rotx,0,0>}
   scale 0.7                         
   }// end union 
   object { AxesJ 
    rotate <-0*Rot1,0,0>   //untwist = Rot1 for twisted strip on eye
    rotate <Deviate,0,0>   // deviation from untwist for paths off eye
    translate Minor*y      // minor axis translation
    rotate <Rot1,0,0>      // phase rotation (mirror of untwist)- frequency
    translate -Major*y      // major (momentum) axis
    rotate <0,0,Rot2>      // momentum rotation - clock
    rotate <0,Rot3,0>}     // tumble rotation to cons momentum (usually frozen)

      #declare Index = Index + 1;
#end
  
} // end toruse  


  #declare Minor = 0.2; // incident photon
   #declare Major = 1.5;  
   #declare Index = 1;   // main loop counter
   #declare Amplitude = 90*Minor/Major;  // 90 ensures right angle if major=minor
 
 #declare Photp = union{    // construct torus object
#while(Index <= 95/Step)
   #declare Rot1 = 4*(Index-1)*-Step; // this is main phase counter in degrees
   #declare Rot2 = Rot1*2;      // main rotation counter 2*Rot1 for fermion
   #declare Rot3 = Rot1*0;   // tumble rotation
   #declare Rotx = Rot1*-1;    // rotation of x axis in yz plane
   #declare Roty = Rot1*0;   // rotation of y axis in zx plane
   #declare Rotz = Rot1*0;  // rotation of z axis in xy plane
   #declare Rock = sin(Rot1*pi/180); // sin argument in radians
   #declare Deviate = Amplitude*Rock; //deviation from parallality
   #declare AxesJ = union {    //insert bivector rotations
     object { ArrowE rotate <Rotx,0,0>}
   scale 0.7                         
   }// end union 
   object { AxesJ 
    translate Minor*x*Index*2.4      //motion translation
    rotate <Rot1*2,0,0>  }    // phase rotation (mirror of untwist)- frequency
    

      #declare Index = Index + 1;
#end
} // end Photp

// object {Torusf  // print complete object
 //  translate Major*x*(-0.0)
//   scale 1
//}
 object {Torusp  // print complete object
   rotate <0,-30,0>
   translate Major*y*(-1.0)
   scale 1
}
object {Toruse  // print complete object 
   rotate <0,-30,0>
   translate Major*y*(1.0)
   rotate <0,-180,0>
   scale 1
}  
object {Photp  // print complete object 
   rotate <0,-0,0>
   translate Major*x*(-7.7)
   rotate <0,-30,0>
   scale 1
} 
object {Photp  // print complete object 
      rotate <0,-180,0>     
      translate Major*x*(7.7)
     rotate <0,-30,0>
   scale 1
}
 //  sphere {
 //   <0, Minor+Major, 0>,0.7
  //  texture {
 //     pigment { rgbf <1,1,1,0.7> }   // mark start
 //   }
 // }
 
 //  torus {      // transparent alternative torus
  //  Major, Minor              // major and minor radius
 //   rotate -90*x      // so we can see it from the top
 //  texture {pigment { rgbf <.96,.96,1,0.95> }   // mark start
//}
//  }

 