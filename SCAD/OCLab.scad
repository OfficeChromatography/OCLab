 /*
Use the full_view module for final outputs
type argument can be:
- full
- printed 
- etc...
    
*/



include <vitamine.scad>
use <RaspberryPiCamera.scad>


nema14_z = 36;
nema_axe_h = 22;

rabio=0.5;

// Position, may be in the full view more
//X = $t*100-50;
//Y = ($t*100-50)*2;

Y_axis_shift_X = 0;
// Dimension
X_dim = 205+50; // course: 90 + 50 obligatory; lost: X
Y_dim = 245+50; // course: 90 + 50 obligatory lost: Y
Z_dim = 250;
X=0;Y=0;
prof_type = 1; // I 20 
prof_dim = 20;
plate_dim_X = 100;
plate_dim_Z = 1;
plate_dim_Y = 50;
milling_thick = 10;
milling_thick_motor = 13;
rod_smooth_d = 8;
rod_smooth_Y_h = Y_dim- prof_dim*2;
//rod_smooth_X_h = X_dim- prof_dim*2; // with rod inside profiles
rod_smooth_X_h = X_dim;//- prof_dim*2;
// prof

full_prof = true;
Y_dim_min = 2;//5 for high, 2 for low
tr8_nut_inside_A = 180; //put to 180 to see it inside, 0 outside
tr8_nut_inside_h = tr8_nut_h2;//put to tr8_nut_h2 to see it inside, 0 outside


prof_X_gap = X_dim/2 - prof_dim/2;
prof_Y_gap = Y_dim/2 - prof_dim/2;
prof_Z_gap_Y = 2.5;//prof_Y_gap - 100 - 50;
small_profs_Y = prof_Y_gap + prof_Z_gap_Y - prof_dim;
prof_verticale_gap_1 = prof_dim/2;
prof_verticale_gap_2 = Z_dim-prof_dim/2;
profs_X = X_dim- prof_dim*2;
profs_Y = Y_dim- prof_dim*2;
profs_Y_top = prof_Y_gap +prof_Z_gap_Y - prof_dim;
profs_Z = Z_dim- prof_dim*2;
//profs_diag = sqrt(2)*profs_Z;
module profs(){
    union(){
        for(i = [-1,1]){
                translate([-profs_X/2 ,i*prof_Y_gap,prof_dim/2]) rotate([0,90,0]) profile(length= profs_X ,type=prof_type); // X
                translate([i*prof_X_gap,-profs_Y/2 ,prof_dim/2]) rotate([-90,0,0]) profile(length= profs_Y ,type=prof_type); // Y bottom
            
            
            translate([i*prof_X_gap,prof_Z_gap_Y ,prof_dim]) profile(length= profs_Z ,type=prof_type); // Z middle
            translate([i*prof_X_gap,-prof_Y_gap ,prof_dim]) profile(length= profs_Z ,type=prof_type); // Z back
            for(j = [-1,1]){
                    color("green")translate([i*prof_X_gap,j*prof_Y_gap,prof_dim/2]) cube([20,20,20],center=true); //green bottom
            }
            color("green")translate([i*prof_X_gap,-prof_Y_gap,prof_verticale_gap_2]) cube([20,20,20],center=true); // green top back
        }
        translate([-profs_X/2 ,-prof_Y_gap,prof_verticale_gap_2]) rotate([0,90,0]) profile(length= profs_X ,type=prof_type); // X top back
    }
    if(full_prof){
        for(i = [-1,1]){
            translate([i*prof_X_gap,-profs_Y/2 ,prof_verticale_gap_2]) rotate([-90,0,0]) profile(length= profs_Y ,type=prof_type); // Y top
            translate([i*prof_X_gap,prof_Y_gap ,prof_dim]) profile(length= profs_Z ,type=prof_type); // Z front
            //color("green")translate([i*prof_X_gap,prof_Y_gap,prof_verticale_gap_2]) cube([20,20,20],center=true); // green top front
        }
        translate([-profs_X/2 ,prof_Y_gap-10-4  ,prof_verticale_gap_2]) rotate([0,90,0]) profile(length= profs_X ,type=prof_type); // X top front
        translate([-profs_X/2 ,prof_Z_gap_Y,prof_verticale_gap_2]) rotate([0,90,0]) profile(length= profs_X ,type=prof_type); // X top middle
    }else{
        translate([-profs_X/2 ,prof_Z_gap_Y,prof_verticale_gap_2]) rotate([0,90,0]) profile(length= profs_X ,type=prof_type); // X top middle
        for(j = [-1,1]){
            color("green")translate([j*prof_X_gap,prof_Z_gap_Y,prof_verticale_gap_2]) cube([20,20,20],center=true); //green top middle
            translate([j*prof_X_gap,-profs_Y/2 ,prof_verticale_gap_2]) rotate([-90,0,0]) profile(length= small_profs_Y ,type=prof_type); // Y top smalls
        }
    }
    
}
frame_thick = 2;
frame_bottom_height = 190;
module frames(){
    % translate([0,-Y_dim/2-frame_thick/2,Z_dim/2]) cube([X_dim,frame_thick,Z_dim],center=true);//back
    % translate([0,0,-frame_thick/2]) cube([X_dim,Y_dim,1],center=true);//bottom
    if(!full_prof){
        % translate([X_dim/2+frame_thick/2,(small_profs_Y/2)-profs_Y/2,Z_dim/2]) cube([frame_thick,small_profs_Y+40,Z_dim],center=true);//side
        % translate([-(X_dim/2+frame_thick/2),(small_profs_Y/2)-profs_Y/2,Z_dim/2]) cube([frame_thick,small_profs_Y+40,Z_dim],center=true);//side
        % translate([0,-Y_dim/2+150/2,Z_dim+frame_thick/2]) cube([X_dim,150,1],center=true);//top
    }else{
        % translate([X_dim/2+frame_thick/2,0,Z_dim/2]) cube([frame_thick,Y_dim,Z_dim],center=true);//side
        % translate([-(X_dim/2+frame_thick/2),0,Z_dim/2]) cube([frame_thick,Y_dim,Z_dim],center=true);//side
        % translate([0,-7,Z_dim+frame_thick/2]) cube([X_dim,Y_dim-14,1],center=true);//top
    }
    
}
//echo(small_profs_Y+40);// 160
module front_frame(type="top"){
    difference(){
        translate([0,Y_dim/4+frame_thick,Z_dim/2+frame_thick]) cube([X_dim-40,Y_dim/2,Z_dim],center=true);
        cube([1000,1000,32],center=true);
        translate([0,Y_dim/2,Z_dim]) rotate([30,0,0]) cube([1000,80,150],center=true);
        difference(){
            translate([0,Y_dim/4,Z_dim/2]) cube([X_dim-40-2*frame_thick,Y_dim/2,Z_dim],center=true);
            translate([0,Y_dim/2-frame_thick,Z_dim-frame_thick]) rotate([30,0,0]) cube([1000,80,150],center=true);             
        }
        if(type=="top"){
           translate([0,Y_dim/4,0])cube([1000,1000,(frame_bottom_height)*2],center=true);
            translate([0,prof_Z_gap_Y,prof_verticale_gap_2]) cube([profs_X*2,20+rabio,20+rabio],center=true);//X prof top
        }else{
           translate([0,Y_dim/4,Z_dim])cube([1000,1000,(Z_dim-frame_bottom_height)*2],center=true);
            translate([0,prof_Y_gap,10]) cube([profs_X*2,20+rabio,20+rabio],center=true);//X prof bottom
        }
        front_frame_M3();// M3 frame
    }
}
module front_frame_M3(){
    for(i = [0:3]){
        translate([0,i*35+20,frame_bottom_height-5]) rotate([0,90,0]) cylinder(d=3.5,h=300,center=true);
        translate([0,i*35+20,frame_bottom_height+5]) rotate([0,90,0]) cylinder(d=3.5,h=300,center=true);
    }
    for( i = [-2:2]){
        translate([i*40,Y_dim/2,frame_bottom_height-7+6])rotate([-60,0,0])cylinder(d=2.5,h=100,center=true);
        translate([i*40,Y_dim/2,frame_bottom_height+7+6])rotate([-60,0,0])cylinder(d=2.5,h=100,center=true);
    }
}
module front_frame_link(){
    difference(){
        translate([0,Y_dim/4+frame_thick,Z_dim/2+frame_thick]) cube([X_dim-40+frame_thick*3,Y_dim/2,Z_dim],center=true);
        cube([1000,1000,32],center=true);
        translate([0,prof_Z_gap_Y,0])cube([1000,20,1000],center=true);
        translate([0,Y_dim/2+2*frame_thick,Z_dim]) rotate([30,0,0]) cube([1000,80,150],center=true);
        difference(){
            translate([0,Y_dim/4,Z_dim/2]) cube([X_dim-40+rabio,Y_dim/2,Z_dim],center=true);
            translate([0,Y_dim/2+frame_thick+rabio,Z_dim-frame_thick]) rotate([30,0,0]) cube([1000,80,150],center=true);             
        }
           translate([0,Y_dim/4,-10])cube([1000,1000,(frame_bottom_height)*2],center=true);
           translate([0,Y_dim/4,Z_dim+10])cube([1000,1000,(Z_dim-frame_bottom_height)*2],center=true);
           
        front_frame_M3();// M3 frame
    }
}


module green_top_front(){
    for(i = [-1,1]){
        difference(){
            color("green")translate([i*prof_X_gap,prof_Y_gap,prof_verticale_gap_2]) cube([20,20,20],center=true); // green top front
            translate([0,prof_Y_gap,Z_dim/2]) cube([230,5,Z_dim+50],center=true);
            translate([0,Y_dim/2,Z_dim]) cube([300,25,28],center=true);
            translate([i*prof_X_gap,prof_Y_gap,prof_verticale_gap_2]) rotate([-90,0,0]) cylinder(d=6,h=30,center=true);
            translate([i*prof_X_gap,prof_Y_gap,prof_verticale_gap_2]) rotate([-90,0,0]) cylinder(d=12,h=15,center=true);
        }
    }
}

module feet(){
    difference(){
        hull(){
            translate([10,0,-5]) rotate([90,0,0]) cylinder(h=20,d=10,center=true);
            translate([-10,0,-20]) cube([1,20,40],center=true);
        }
        hull(){
            translate([10,0,-5]) rotate([90,0,0]) cylinder(h=21,d=6,center=true);
            translate([-10,0,-20]) cube([1,21,36],center=true);
        }
        translate([-5,0,-40]) cube([20,21,70],center=true);
        cylinder(d=5.5,h=10,center=true);
    }
}
module feets(){
    for(i = [-1,1]){for(j=[-1,1]){
        translate([i*prof_X_gap,j*prof_X_gap,-frame_thick]) rotate([0,0,-j*90])feet();
    }}
}

// Y axis
include <OCLab_Y_axis.scad>

// X_axis
include <OCLab_X_axis.scad>

// elec


ramp_X_gap = -10;
ramp_Y_gap =-prof_Y_gap+ 50+prof_dim-15+20;
ramp_Z_gap = Z_dim+5;//-prof_dim-35;
MEGA_X_gap = 50;
MEGA_Y_gap =-prof_Y_gap - 7+prof_dim-12+10;
MEGA_Z_gap =Z_dim-400+(prof_dim+35)+5;// Z_dim-prof_dim-40;
RPI_X_gap = -prof_X_gap+30;
RPI_Y_gap =-prof_Y_gap + 70+prof_dim+10;
RPI_Z_gap = ramp_Z_gap;
elec_holder_thick = 3;
elec_holder_Z = 50;
elec_Y=150;
elec_holder_X = X_dim-35;
module elec(){
    translate([ramp_X_gap,ramp_Y_gap,ramp_Z_gap]) rotate([0,0,90]) import("RAMPS1_4.STL");
    translate([MEGA_X_gap,MEGA_Y_gap,MEGA_Z_gap]) rotate([0,0,90]) import("Arduino_Mega_2560.STL");
    translate([RPI_X_gap,RPI_Y_gap,RPI_Z_gap]) rotate([0,0,-90]) import("Raspberry_Pi_3.STL");
    
}
module elec_holder(){
    color("green",1) difference(){
        union(){
            // bottom
            translate([0,-Y_dim/2+150/2,Z_dim+frame_thick+elec_holder_thick/2]) cube([elec_holder_X,150,elec_holder_thick],center=true);
            // Y wall
            translate([elec_holder_X/2-elec_holder_thick/2,-Y_dim/2+elec_Y/2+prof_dim,Z_dim+frame_thick+elec_holder_Z/2]) cube([elec_holder_thick,elec_Y,elec_holder_Z],center=true); // Y wall left
            translate([-(elec_holder_X/2-elec_holder_thick/2)+17,-Y_dim/2+elec_Y/2+prof_dim,Z_dim+frame_thick+elec_holder_Z/2]) cube([elec_holder_thick,elec_Y,elec_holder_Z],center=true);
            // X wall
            translate([0,-Y_dim/2+elec_holder_thick/2+prof_dim,Z_dim+frame_thick+elec_holder_Z/2]) cube([elec_holder_X,elec_holder_thick,elec_holder_Z],center=true);
            translate([0,-Y_dim/2+150,Z_dim+frame_thick+elec_holder_Z/2]) cube([elec_holder_X,elec_holder_thick,elec_holder_Z],center=true);
            difference(){
                translate([X_dim/2-70,-Y_dim/2+150,Z_dim+frame_thick+elec_holder_Z/2]) cube([70,20,elec_holder_Z],center=true);
                translate([X_dim/2-70,-Y_dim/2+150,Z_dim+frame_thick+elec_holder_Z/2]) cube([55,50,elec_holder_Z+1],center=true);
                translate([X_dim/2-70,-Y_dim/2+150,Z_dim+frame_thick+elec_holder_Z/2]) cube([65,15,elec_holder_Z+1],center=true);
            }
            

        }
        elec_neg();
        translate([0,-Y_dim/2+150+50+elec_holder_thick/2,0]) cube([300,100,700],center=true);
    }
}
module arduino_neg(){
    //see here: https://blog.protoneer.co.nz/arduino-uno-and-mega-dimensions/
    translate([40.5,-54.6,0]) rotate([180,0,180]) union(){
        translate([2.54,14,0]) cylinder(d=3,h=200,center=true); // bottom left screw
        translate([2.54,96.52,0]) cylinder(d=3,h=200,center=true);
        translate([50.8,14+1.3,0]) cylinder(d=3,h=200,center=true);
        translate([50.8,90.17,0]) cylinder(d=3,h=200,center=true);
    }

}
module rpi_neg(){
    //see here: https://blog.protoneer.co.nz/arduino-uno-and-mega-dimensions/
    translate([54.2,-64.3,0]) rotate([180,0,180]) union(){
        translate([0,0,0]) cylinder(d=3,h=200,center=true); // bottom left screw
        translate([0,58,0]) cylinder(d=3,h=200,center=true);
        translate([49,0,0]) cylinder(d=3,h=200,center=true);
        translate([49,58,0]) cylinder(d=3,h=200,center=true);
    }

}
module elec_neg(){
    // cube RPI usb
    translate([RPI_X_gap+30,-Y_dim/2+elec_holder_thick/2+prof_dim,RPI_Z_gap+10]) cube([60,10,20],center=true); 
    // cube_RPI_alim
    translate([-prof_X_gap+prof_dim/2,RPI_Y_gap-15,RPI_Z_gap+5]) cube([50,20,10],center=true);
    // cube RAMPS alim
    translate([ramp_X_gap+20,-Y_dim/2+elec_holder_thick/2+prof_dim,ramp_Z_gap+15]) cube([60,10,30],center=true); 
    // hp cable
    color("red")translate([MEGA_X_gap+20,-Y_dim/2+elec_holder_thick/2+prof_dim+elec_Y,RPI_Z_gap+20]) cube([30,10,5],center=true); 
    // cube cable
    translate([X_dim/2-30,prof_Z_gap_Y-15,Z_dim]) cube([20,10,20],center=true);
    //translate([prof_X_gap-25,-Y_dim/2+elec_holder_thick/2+prof_dim,ramp_Z_gap+10]) cube([20,10,20],center=true); 
    // arduino_neg ramp
    translate([ramp_X_gap,ramp_Y_gap,ramp_Z_gap]) arduino_neg();
    translate([ramp_X_gap+70,ramp_Y_gap+7,ramp_Z_gap]) arduino_neg();
    translate([RPI_X_gap,RPI_Y_gap,RPI_Z_gap]) rpi_neg();
    M5s();
}

camera_Y_gap = 55;
LED_gap = 35.5/2;
module LED_UV_neg(){
    union(){
        for(i = [-1,1]){for(j = [-1,1]){
            translate([i*LED_gap,camera_Y_gap+j*LED_gap,Z_dim-prof_dim-4]) cylinder(d=3,h=100,center=true);
        }}
        for(i= [0:4]){
			//translate([0,camera_Y_gap,Z_dim-prof_dim-4]) rotate([0,0,i*360/5+36]) translate([0,-33,0]) cylinder(d=3.5,h=100,center=true);
		}
    }
}
module LED_UV(){
    difference(){
        translate([0,55,Z_dim-prof_dim-4]) cube([40,40,2],center=true);
        LED_UV_neg();
    }
}
module camera_holder(){
    difference(){
        color("gold")union(){
            translate([0,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),Z_dim-prof_dim/2]) cube([board_width*2+4,milling_thick,prof_dim],center=true);
            hull(){
                translate([0,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),Z_dim-prof_dim/2]) cube([board_width*2+4,milling_thick,prof_dim],center=true);
                translate([0,camera_Y_gap,Z_dim-prof_dim/2]) cube([board_width*2+4,75,prof_dim],center=true);
            }
            hull(){
                translate([0,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),Z_dim-prof_dim+1]) cube([board_width*3+4,milling_thick,2],center=true);
                translate([0,camera_Y_gap,Z_dim-prof_dim+1]) cube([board_width*3+4,75,2],center=true);
            }
        }
        union(){
            M5s();
            LED_UV_neg();
                translate([0,camera_Y_gap,Z_dim-prof_dim+1]) rotate([0,180,180])raspberryPiCamera_neg();
                translate([0,camera_Y_gap,Z_dim-prof_dim+4]) rotate([0,180,180])raspberryPiCamera_neg();
            translate([0,10,3])hull(){
                translate([0,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),Z_dim-prof_dim/2]) cube([board_width*2,milling_thick,prof_dim],center=true);
                translate([0,camera_Y_gap,Z_dim-prof_dim/2]) cube([board_width*2+2,75,prof_dim],center=true);
            }
        }
    }
}


module name_printer(string="OC-Lab"){
	difference(){
		union(){
			translate([0,Y_dim/2+5,10]) cube([105,10,20],center=true);
		}
		//M5s();
        front_frame("bottom");
			translate([35,Y_dim/2+milling_thick-2,4])rotate([90,0,180]) linear_extrude(3) text(string, size = 12, direction = "ltr", spacing = 1 );
	}
	
}

M5_gap_ends = 15;
M5_gap_motors = 27;
M5_gap_motors_X = nema14_xy/2+prof_dim*1.3;
module M5(hole = true){
    color("green")union(){
        translate([0,0,0]) cylinder(d=5+rabio,h=milling_thick+rabio,center=true); 
        if(hole){
            translate([0,0,milling_thick]) cylinder(d=12,h=5,center=true);
        }else{
            translate([0,0,milling_thick]) cylinder(d=12,h=milling_thick,center=true);
        }        
    }
}
module M5s(real = false){
    color("green") union(){
        for(i = [-1,1]){
            translate([i*M5_gap_ends,-Y_motor_Y_gap,prof_dim/2]) rotate([-90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // Y_end
            translate([i*M5_gap_ends,-Y_motor_Y_gap-milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=10,h=5,center=true); // Y_end
            
            translate([i*M5_gap_motors,Y_motor_Y_gap,prof_dim/2]) rotate([-90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // Y_motor
            translate([i*M5_gap_motors,Y_motor_Y_gap+milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=10,h=5,center=true); // Y_motor
            
            
            translate([-prof_X_gap,prof_Z_gap_Y-(prof_dim/2+milling_thick/2),motor_X_gap_Z+i*(M5_gap_motors_X)]) rotate([90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // X_end
            translate([-prof_X_gap,prof_Z_gap_Y-(prof_dim/2+milling_thick),motor_X_gap_Z+i*M5_gap_motors_X]) rotate([90,0,0]) cylinder(d=10,h=5,center=true); // X_end
            
            translate([prof_X_gap,prof_Z_gap_Y-(prof_dim/2+milling_thick/2),motor_X_gap_Z+i*(M5_gap_motors_X)]) rotate([90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // X_motor
            translate([prof_X_gap,prof_Z_gap_Y-(prof_dim/2+milling_thick),motor_X_gap_Z+i*M5_gap_motors_X]) rotate([90,0,0]) cylinder(d=10,h=5,center=true); // X_motor
            translate([i*20,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),Z_dim-prof_dim/2]) rotate([90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // camera holder
            translate([i*20,prof_Z_gap_Y+(prof_dim/2+milling_thick),Z_dim-prof_dim/2]) rotate([90,0,0]) cylinder(d=10,h=5,center=true); // camera holder
            
        }
				
				// Y enstop
				translate([70-10,Y_dim/2-prof_dim,prof_dim/2])rotate([90,0,0])  cylinder(d=5+rabio,h=milling_thick*1,center=true); // Y enstop
				translate([70-10,Y_dim/2-prof_dim-5,prof_dim/2])rotate([90,0,0])   cylinder(d=10,h=5,center=true); // Y enstop
				translate([70+10,Y_dim/2-prof_dim,prof_dim/2])rotate([90,0,0])  cylinder(d=5+rabio,h=milling_thick*1,center=true); // Y enstop
				translate([70+10,Y_dim/2-prof_dim-5,prof_dim/2]) rotate([90,0,0])  cylinder(d=10,h=5,center=true); // Y enstop
        
				 // pippette holder
        if(full_prof){
            translate([0,Y_dim/2-10,0]) union(){
                translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),Z_dim-prof_dim*2]) rotate([90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // pippette holder
        translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick),Z_dim-prof_dim*2]) rotate([90,0,0]) cylinder(d=10,h=5,center=true); // pippette holder
        translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),prof_dim*6]) rotate([90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // vial holder
       translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick),prof_dim*6]) rotate([90,0,0]) cylinder(d=10,h=5,center=true); // vial holder
            }
        }else{
                translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),Z_dim-prof_dim*2]) rotate([90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // pippette holder
        translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick),Z_dim-prof_dim*2]) rotate([90,0,0]) cylinder(d=10,h=5,center=true); // pippette holder
        translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),prof_dim*6]) rotate([90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // vial holder
       translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick),prof_dim*6]) rotate([90,0,0]) cylinder(d=10,h=5,center=true); // vial holder
        }
        
				
				// name_printer
				translate([40,prof_Y_gap+prof_dim/2+milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // name_printer
				translate([40,prof_Y_gap+prof_dim/2+milling_thick/2+milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=10,h=5,center=true); // name_printer
				translate([-40,prof_Y_gap+prof_dim/2+milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); //name_printer
				translate([-40,prof_Y_gap+prof_dim/2+milling_thick/2+milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=10,h=5,center=true); // name_printer
        
        // elec holder
       // for(i = [-1,1]){for(j = [-1,1]){
        //    translate([i*(prof_X_gap-prof_dim/2),-Y_dim/2+prof_dim+60+j*30,Z_dim-prof_dim/2]) rotate([0,-i*90,0]) M5();
        //}}
        
        // angle conenctor
        for(i = [-1,1]){for(j = [-1,1]){
            translate([i*(prof_X_gap),prof_Z_gap_Y+30+j*8,prof_dim])M5();
            translate([i*(prof_X_gap),prof_Z_gap_Y+10,prof_dim*3+j*8]) rotate([-90,0,0])M5();
            if(full_prof){
                translate([i*(prof_X_gap),prof_Z_gap_Y+30+j*8,Z_dim-prof_dim])rotate([180,0,0])M5();
                translate([i*(prof_X_gap),prof_Z_gap_Y+10,Z_dim-(prof_dim*3+j*8)]) rotate([-90,0,0])M5();
                translate([i*(prof_X_gap),Y_dim/2-(40+j*8),Z_dim-prof_dim])rotate([180,0,0])M5();
                translate([i*(prof_X_gap),Y_dim/2-20,Z_dim-(prof_dim*3+j*8)]) rotate([90,0,0])M5();
                translate([i*(prof_X_gap-10),prof_Z_gap_Y+30+j*8,Z_dim-prof_dim/2])rotate([0,-i*90,0])M5();
                translate([i*(prof_X_gap-40-j*8),prof_Z_gap_Y+10,Z_dim-10]) rotate([-90,0,0])M5();
                translate([i*(prof_X_gap-10),Y_dim/2-40-14-j*8,Z_dim-prof_dim/2])rotate([0,-i*90,0])M5();
                translate([i*(prof_X_gap-40-j*8),Y_dim/2-20-14,Z_dim-10]) rotate([90,0,0])M5();
            }
        }}
        
        // bottom, back, side, top
        for(i = [-1,1]){for(j = [-1,1]){
            translate([i*(prof_X_gap),j*(Y_dim/2-30),0])rotate([180,0,0])M5();
            translate([i*(prof_X_gap),-Y_dim/2,Z_dim/2+j*(Z_dim/2-30)])rotate([90,0,0])M5();
            translate([i*(prof_X_gap-20),-(Y_dim/2-10),Z_dim])M5();//top back
            if(!full_prof){
                translate([i*(prof_X_gap),(Y_dim/2-170),Z_dim])M5();//top middle
                for(k=[-1,1]){
                    translate([k*(X_dim/2),(small_profs_Y/2)-profs_Y/2+70*i,Z_dim/2+j*(Z_dim/2-30)])rotate([0,k*90,0])M5();//side
                }
            }else{
                translate([i*(prof_X_gap-20),(Y_dim/2-10-14),Z_dim])M5();//top front
                for(k=[-1,1]){
                    translate([k*(X_dim/2),(Y_dim/2-10)*i,Z_dim/2+j*(Z_dim/2-30)])rotate([0,k*90,0])M5();
                }
            }
            
        }}
        
    }
}

module vial_pipette_holder(){    
    difference(){
        union(){
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),prof_dim*6]) cube([prof_dim,milling_thick,prof_dim],center=true);// milling bottom
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick*1.5),prof_dim*6-milling_thick*1.5]) cube([prof_dim,milling_thick*3,milling_thick*2],center=true);// body bottom
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),Z_dim-prof_dim*2]) cube([prof_dim,milling_thick,prof_dim],center=true);// milling top
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick*1.5),Z_dim-prof_dim*2+milling_thick*1.25]) cube([prof_dim,milling_thick*3,milling_thick/2],center=true);// body top
        }
        union(){
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick*2.5),Z_dim-prof_dim*2+milling_thick*1.25]) cylinder(d1=3,d2=8,center=true,h=milling_thick/2+rabio);// pipette cyl
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick*2.5)+5,Z_dim-prof_dim*2+milling_thick*1.25]) cube([3,10,10],center=true);// pipette entrance: cube
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick*2.5),prof_dim*6+N9_h/2-milling_thick+2])N9(rabio=rabio*4);// vial
            M5s();
        }
    }
}

echo("Dimension l*b*h: ",X_dim,"*",Y_dim,"*",Z_dim);
echo("profile X: 4* ", profs_X);
echo("profile Y: 4* ", profs_Y);
echo("profile small Y: 2* ", small_profs_Y);
echo("profile Z: 6* ", profs_Z);
echo("full profile: ",4*profs_X+4*profs_Y+6*profs_Z);
echo("smooth X: 2*",rod_smooth_X_h); 
echo("smooth Y: 2*",rod_smooth_Y_h); 
echo("plate level: ",plate_gap_Z);
echo("M5 nuts full prof: ",4*5+4*10+2+2+2+4*2+2);
module full_view(type = "full",X=0,Y=0){
    if(type == "printed"){
        Y_motor();
        Y_moving();
        translate([0,0,-5]) Y_belt_holder();
        Y_end();
        translate([0,0,10]) plate_holder();
        translate([0,150,10]) plate_holder_10_10();
        translate([0,-150,10]) plate_holder(elution=true);
        Y_endstop_holder();
        translate([85,motor_X_gap_Y+15,motor_X_gap_Z-30]) rotate([90,0,90]) import("Endstop_X_Support_Right.STL");
        translate([X,motor_X_gap_Y+16.5/2,motor_X_gap_Z]) rotate([90,0,0]) import("i3rework_Xcarriage.stl");
        X_motor();
        X_end();
        hpc6602_holder_holder(X,Y); 
        camera_holder();
        elec_holder();
        if(full_prof){green_top_front();}
        feets();
        if(full_prof){translate([0,Y_dim/2-10,0]) vial_pipette_holder();}else{vial_pipette_holder();}
        
    }else if(type == "frame"){
        profs();
        M5s(true);
        if(full_prof){green_top_front();}
    }else if(type == "Y axis"){
        Y_axis(X=X,Y=Y);
        Y_moving(X=X,Y=Y);
        Y_motor();
        % Y_end();
        %plate(X,Y);
        Y_endstop_holder();
        Y_belt_holder(Y);
        plate_holder(Y,15,-6);
        
    }else if(type == "X axis"){
        X_axis(X=X,Y=Y);
        X_motor();
        X_end();        
        //X_end_stop_holder();
        hpc6602(X,Y);
        hpc6602_holder(X,Y);
        hpc6602_holder_holder(X,Y); 
        //translate([105,motor_X_gap_Y+14,motor_X_gap_Z-28]) rotate([90,0,-90]) import("Endstop_X_Support_Right.STL");
    }else if(type == "assembled"){
                frames();

        profs();
        //green_top_front();
        M5s(true);
        Y_axis(X=X,Y=Y);
        Y_moving(X=X,Y=Y);
        Y_motor();
        % Y_end();
        Y_endstop_holder();
        Y_belt_holder(Y);
        plate_holder(Y,15,-6);
        X_motor();
        X_end();
        X_axis(X=X,Y=Y);
        if(full_prof){green_top_front();}
        ///X_end_stop_holder();
        //translate([105,motor_X_gap_Y+13,motor_X_gap_Z-30]) rotate([90,0,-90])      import("Endstop_X_Support_Right.STL");
        //power_supply_holder();
        hpc6602(X,Y);
        hpc6602_holder(X,Y);
        hpc6602_holder_holder(X,Y); 
    }else if(type == "front_frame"){        
        front_frame("top");
        translate([300,0,0]) front_frame("bottom");
       translate([-300,0,0])color("green") front_frame_link();
    }else if(type == "elec"){    
    if(full_prof){green_top_front();}    
        profs();
        elec();
        elec_holder();
        translate([0,camera_Y_gap,Z_dim+1-prof_dim+3]) rotate([0,180,180])raspberryPiCamera();
        camera_holder();//translate([0,125,0])rotate([0,0,180])
    }else if(type == "full"){
        frames();
        if(!full_prof){
            translate([300,0,0]) %front_frame("top");
            translate([300,0,0]) %front_frame("bottom");
            translate([300,0,0]) %front_frame_link();
        }
       profs();
        if(full_prof){green_top_front();}
        M5s(true);
        name_printer("OC-Lab");
        translate([Y_axis_shift_X,0,0]) union(){
            Y_axis(X=X,Y=Y);
            Y_moving(X=X,Y=Y);
            Y_motor();
            % Y_end();
            %plate(X,Y);
            Y_endstop_holder();
            Y_belt_holder(Y);
            plate_holder(Y,15,-6);
        }
        feets();

        translate([105,motor_X_gap_Y+15,motor_X_gap_Z-30]) rotate([90,0,-90]) import("Endstop_X_Support_Right.STL");
        elec();
        elec_holder();
        translate([0,camera_Y_gap,Z_dim+1-prof_dim+3]) rotate([0,180,180])raspberryPiCamera();
        camera_holder();//translate([0,125,0])rotate([0,0,180])
        LED_UV();
        if(full_prof){translate([0,Y_dim/2-10,0]) vial_pipette_holder();}else{vial_pipette_holder();}
        X_motor();
        X_end();
        X_axis(X=X,Y=Y);
        hpc6602(X,Y);
        hpc6602_holder(X,Y);
        hpc6602_holder_holder(X,Y); 
    }    
}

//camera_holder();
//full_view(X=-70,Y=50,Z=0);
//green_top_front();
//name_printer();
//translate([10,0,0])hpc6602_holder_holder(X,Y);
//Y_endstop_holder();
//plate_holder_flex(X,Y,rabio);
//full_view(X=X,Y=Y);
//translate([0,0,1]) plate_holder();
//vial_pipette_holder();
//translate([-10,0,0]) X_end_stop_holder();
//camera_holder();
//power_supply_holder();
//Y_moving();
//translate([0,0,-5]) Y_belt_holder();
//Y_end();
//Y_motor();
//elec_holder();
//plate_holder_10_10(Y);
//X_motor();
//X_end();
//front_frame("top");
//full_view(type="X axis");
full_view(type="printed");

