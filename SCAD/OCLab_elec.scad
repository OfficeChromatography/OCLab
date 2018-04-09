

ramp_X_gap = -20;
ramp_Y_gap =-prof_Y_gap+ 50+prof_dim;
ramp_Z_gap = Z_dim-prof_dim-35;
MEGA_X_gap = 40;
MEGA_Y_gap =-prof_Y_gap - 7+prof_dim;
MEGA_Z_gap =Z_dim-400;// Z_dim-prof_dim-40;
RPI_X_gap = -prof_X_gap+15;
RPI_Y_gap =-prof_Y_gap + 80+prof_dim;
RPI_Z_gap = ramp_Z_gap;
elec_holder_thick = 3;
elec_Y = 120;
module elec(){
    translate([ramp_X_gap,ramp_Y_gap,ramp_Z_gap]) rotate([0,0,90]) import("RAMPS1_4.STL");
    translate([MEGA_X_gap,MEGA_Y_gap,MEGA_Z_gap]) rotate([0,0,90]) import("Arduino_Mega_2560.STL");
    translate([RPI_X_gap,RPI_Y_gap,RPI_Z_gap]) rotate([0,0,-90]) import("Raspberry_Pi_3.STL");
    
}
module elec_holder(){
    color("green",0.5) difference(){
        union(){
            // bottom
            translate([0,-Y_dim/2+elec_Y/2+prof_dim,ramp_Z_gap-elec_holder_thick/2]) cube([210,elec_Y,elec_holder_thick],center=true);
            // Y wall
            translate([prof_X_gap-prof_dim/2-elec_holder_thick/2-2.5,-Y_dim/2+elec_Y/2+prof_dim,Z_dim-(Z_dim-ramp_Z_gap)/2-elec_holder_thick/2]) cube([elec_holder_thick,elec_Y,Z_dim-ramp_Z_gap+elec_holder_thick],center=true);
            translate([-(prof_X_gap-prof_dim/2-elec_holder_thick/2-2.5),-Y_dim/2+elec_Y/2+prof_dim,Z_dim-(Z_dim-ramp_Z_gap)/2-elec_holder_thick/2]) cube([elec_holder_thick,elec_Y,Z_dim-ramp_Z_gap+elec_holder_thick],center=true);
            // X wall
            translate([0,-Y_dim/2+elec_holder_thick/2+prof_dim,Z_dim-(Z_dim-ramp_Z_gap)/2-elec_holder_thick/2]) cube([210,elec_holder_thick,Z_dim-ramp_Z_gap+elec_holder_thick],center=true);
            translate([0,-Y_dim/2-elec_holder_thick/2+prof_dim+elec_Y,Z_dim-(Z_dim-ramp_Z_gap)/2-elec_holder_thick/2]) cube([210,elec_holder_thick,Z_dim-ramp_Z_gap+elec_holder_thick],center=true);

        }
        elec_neg();
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
    translate([-prof_X_gap+prof_dim/2,RPI_Y_gap-15,RPI_Z_gap+5]) cube([10,20,10],center=true);
    // cube RAMPS alim
    translate([ramp_X_gap+20,-Y_dim/2+elec_holder_thick/2+prof_dim,ramp_Z_gap+15]) cube([60,10,30],center=true); 
    // hp cable
    color("red")translate([MEGA_X_gap+20,-Y_dim/2+elec_holder_thick/2+prof_dim+elec_Y,RPI_Z_gap+20]) cube([30,10,5],center=true); 
    // cube cable
    translate([prof_X_gap-25,-Y_dim/2+elec_holder_thick/2+prof_dim,ramp_Z_gap+10]) cube([20,10,20],center=true); 
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