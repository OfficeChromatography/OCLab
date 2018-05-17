// Y_axis, 
rod_smooth_Y_gap_X = rod_smooth_d*2.5+nema14_xy/2;
motor_Y_gap_X = 0;
motor_Y_gap_Y = -prof_Y_gap+nema14_xy/2+prof_dim/2;
motor_Y_gap_Z = -nema_axe_h/2+prof_dim+milling_thick;
623_Y_gap_Z = motor_Y_gap_Z-10;
623_Y_gap_Y = prof_Y_gap-prof_dim;
rod_smooth_Y_gap_Z = motor_Y_gap_Z-5;
module Y_belt(){
    color("black")difference(){
        hull(){
            translate([0,623_Y_gap_Y,623_Y_gap_Z]) cylinder(d=623zz_OD+rabio,h=6,center=true);
            translate([0,motor_Y_gap_Y,623_Y_gap_Z]) cylinder(d=623zz_OD+rabio,h=6,center=true);
        }
         hull(){
            translate([0,623_Y_gap_Y,623_Y_gap_Z]) cylinder(d=623zz_OD-rabio,h=7,center=true);
            translate([0,motor_Y_gap_Y,623_Y_gap_Z]) cylinder(d=623zz_OD-rabio,h=7,center=true);
        }
    }
}
module Y_M3s(rabio=0,Y=0){
    color("green")union(){
        
        translate([0,623_Y_gap_Y,623_Y_gap_Z]) cylinder(d=3+rabio,h=30+rabio,center=true);//62.3
        // beld holder
        translate([3,Y+lm8uu_OD/2,rod_smooth_Y_gap_Z+lm8uu_OD/2+2-10]) cylinder(d=3+rabio,h=30+rabio,center=true);
        translate([3,Y-lm8uu_OD/2,rod_smooth_Y_gap_Z+lm8uu_OD/2+2-10]) cylinder(d=3+rabio,h=30+rabio,center=true);
        translate([3,Y+lm8uu_OD/2,rod_smooth_Y_gap_Z+lm8uu_OD/2+2-10+20]) cylinder(d=7+rabio,h=10+rabio,center=true);
        translate([3,Y-lm8uu_OD/2,rod_smooth_Y_gap_Z+lm8uu_OD/2+2-10+20]) cylinder(d=7+rabio,h=10+rabio,center=true);
    }
}
module Y_rods(rabio=0){
    for(i = [-1,1]){
        translate([i*rod_smooth_Y_gap_X,0,rod_smooth_Y_gap_Z]) rotate([90,0,0]) cylinder(d=rod_smooth_d+rabio,h=rod_smooth_Y_h+rabio,center=true);// Y_rod
    }
}
module Y_axis(X=0,Y=0,Z=0){
    color("pink")translate([motor_Y_gap_X,motor_Y_gap_Y,motor_Y_gap_Z]) rotate([-180,0,0]) nema14();
    Y_rods();
    % translate([motor_Y_gap_X,motor_Y_gap_Y,motor_Y_gap_Z]) rotate([-180,0,0])gt2_pulley();
    //color("yellow") translate([motor_Y_gap_X,Y-5,motor_Y_gap_Z]) rotate([-90,0,0]) translate([0,0,0]) rotate([0,0,0]) tr8_nut();
    for(i = [-1,1]){
        for(j = [-1,1]){
            color("pink")translate([i*rod_smooth_Y_gap_X,j*housing_lm8uu_L/2+Y,rod_smooth_Y_gap_Z]) rotate([90,0,0]) housing_lm8uu();
        }
    }
    translate([70,Y_dim/2-prof_dim-endstop_x/2-2,prof_dim+endstop_z/2+2]) rotate([180,180,90]) endstop();
    Y_belt();
}
module Y_endstop_holder(){
	difference(){
		color("gold")union(){
			translate([70,Y_dim/2-prof_dim-1,prof_dim/2+1]) cube([endstop_y,2,prof_dim+2],center=true);//body
			translate([70,Y_dim/2-prof_dim-endstop_x/2-2,prof_dim+1]) cube([endstop_y,endstop_x,2],center=true);//link
		}
		union(){
			M5s();
			translate([70,Y_dim/2-prof_dim-endstop_x/2-2,prof_dim+endstop_z/2]) rotate([180,180,90]) endstop_neg();//endstop_neg();
		}
	}
}

Y_motor_Y_gap = -prof_Y_gap+prof_dim/2+milling_thick/2;
milling_thick_Y_motor = nema14_xy - prof_dim-2;
module Y_motor(){
    color("gold")difference(){
        union(){
            translate([0,-prof_Y_gap+prof_dim/2+milling_thick/2,prof_dim/2+milling_thick/2]) cube([rod_smooth_Y_gap_X*2+15,milling_thick,prof_dim+milling_thick],center=true);
            translate([0,motor_Y_gap_Y,prof_dim+milling_thick/2]) cube([nema14_xy,nema14_xy,milling_thick],center=true);
            }
        M5s();
        translate([motor_Y_gap_X,motor_Y_gap_Y,motor_Y_gap_Z]) rotate([180,0,0]) nema14_neg(rabio=rabio);
        translate([motor_Y_gap_X,motor_Y_gap_Y,-rabio]) union(){ // special to screw the head
            for(i = [-1,1]){for(j = [-1,1]){
                translate([i*nema14_vis_space,j*nema14_vis_space,0]) cylinder(h=22+rabio,d=6+rabio,center=false);
            }}
        }
        Y_rods(rabio=rabio);
    }
}

module Y_end(){
    color("gold")difference(){
        union(){
            translate([0,prof_Y_gap-prof_dim/2-milling_thick/2,prof_dim/2]) cube([rod_smooth_Y_gap_X*2+15,milling_thick,prof_dim],center=true);
            translate([0,prof_Y_gap-prof_dim/2-milling_thick,prof_dim/2]) cube([nema_xy/2,milling_thick*2,prof_dim],center=true);
            }
        M5s();
        Y_rods(rabio=rabio);
        translate([0,prof_Y_gap-prof_dim/2-milling_thick,623_Y_gap_Z]) cube([623zz_OD*1.5,milling_thick*3,8],center=true);
        Y_M3s(Y=Y,rabio=rabio);
            translate([0,prof_Y_gap-prof_dim/2-milling_thick,0]) cylinder(h=6,d=8,center=true);
    }
}

// Y_moving
Y_moving_thick=10;
Y_moving_top_Z = rod_smooth_Y_gap_Z+lm8uu_OD/2+Y_moving_thick/2*Y_dim_min; // change Y_dim_min at begining to get higher plate level
module M4_Y_moving(rabio=rabio,nut=true){
    translate([0,0,rabio/2]) union(){
        rotate([0,180,0])cylinder(d=8+rabio,h=Y_moving_thick/2+rabio);
        if(nut){
            rotate([0,180,0])cylinder(d=4+rabio,h=Y_moving_thick*5);
        }
    }
}
module Y_belt_holder(Y=0){
    color("gold")difference(){
        hull(){
            translate([4,Y,623_Y_gap_Z-6])cube([14,30,1],center=true);
            translate([4,Y,rod_smooth_Y_gap_Z-1/2+housing_lm8uu_H/2-3])cube([14,30,1],center=true);
        }
        translate([3,Y,623_Y_gap_Z])cube([7,30+rabio,7],center=true);
        
        Y_M3s(Y=Y,rabio=rabio);
    }
}
module M5_Y_moving(rabio=rabio,nut=true){
    translate([0,0,rabio/2]) union(){
        rotate([0,180,0])cylinder(d=10+rabio,h=Y_moving_thick/2+rabio);
        if(nut){
            rotate([0,180,0])cylinder(d=5+rabio,h=Y_moving_thick*5);
        }
    }
}
magnet_X_gap = 60;
chamber_Z_gap_0 = rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2;
module Y_moving(X=0,Y=0,Z=0){
    difference(){
        color("gold") union(){
            translate([0,Y,rod_smooth_Y_gap_Z+Y_moving_thick/2+housing_lm8uu_H/2]) cube([magnet_X_gap*2+8,2*housing_lm8uu_L,Y_moving_thick],center=true);
            for(i = [-1,1]){
                translate([i*magnet_X_gap,Y,chamber_Z_gap_0-0.1]) cylinder(d1=5,d2=3,h=2,center=false);
            }
        }
        union(){
            for(i = [-1,1]){
                for(j = [-1,1]){
                    color("pink")translate([i*rod_smooth_Y_gap_X,j*housing_lm8uu_L/2+Y,rod_smooth_Y_gap_Z]) rotate([90,0,0]) housing_lm8uu_neg(rabio=rabio,h=Y_moving_thick);
                    translate([i*magnet_X_gap,j*(housing_lm8uu_L-10)+Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2-3]) cube([8.1,8.1,3.2],center=true);
                   translate([i*rod_smooth_Y_gap_X,Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2]) cube([lm8uu_OD,housing_lm8uu_L*1.6,30],center=true); // cube neg in housing
                }
            }
            Y_M3s(Y=Y,rabio=rabio);
        }
    }
}

module plate_holder(Y=0,rim=15,deep=-8,elution=false){//Only for 5*10 plates 
    difference(){
        color("green") union(){
            translate([0,Y,chamber_Z_gap_0+5]) cube([magnet_X_gap*2+8,50+rim*2+4+5*2,10],center=true);
        }
        union(){
            translate([0,Y,chamber_Z_gap_0+5+10+deep]) cube([102,51,10],center=true);//plate
            translate([0,Y,chamber_Z_gap_0+5+5]) cube([102,51+rim*2+4,10],center=true);//center
            if(elution){
                difference(){
                    translate([0,Y,chamber_Z_gap_0+5+8]) cube([111,51+rim*2+4+6,10],center=true);//top
                    translate([0,Y,chamber_Z_gap_0+5+8]) cube([200,5,100],center=true);//top
                }
            }else{
                translate([0,Y,chamber_Z_gap_0+5+8]) cube([111,51+rim*2+4+6,10],center=true);//top
            }            
            translate([50,Y,chamber_Z_gap_0+5+1]) cube([5,10,10],center=true);//encoche
            for(i = [-1,1]){
               translate([0,Y+i*(51+rim+4)/2,chamber_Z_gap_0+5+2]) cube([101,rim,10],center=true);//top 
                translate([i*magnet_X_gap,Y,chamber_Z_gap_0-0.1]) cylinder(d1=5+0.5,d2=3+0.5,h=2+0.5,center=false);
                for(j = [-1,1]){
                    translate([i*magnet_X_gap,j*(housing_lm8uu_L-10)+Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2-7+10]) cube([8.1,8.1,3.2],center=true);
                }
            }
        }
    }
}
module plate_holder_10_10(Y=0){// only for 10*10 plates, only for 
    difference(){
        color("green") union(){
            translate([0,Y,chamber_Z_gap_0+3]) cube([magnet_X_gap*2+8,106,6],center=true);
        }
        union(){
            translate([0,Y,chamber_Z_gap_0+5+4]) cube([102,102,10],center=true);//plate
            translate([0,Y,chamber_Z_gap_0+5+5]) cube([102,51+20,10],center=true);//center
            translate([0,Y,chamber_Z_gap_0+5+8]) cube([111,51+20+6,10],center=true);//top
            translate([50,Y,chamber_Z_gap_0+5+1]) cube([6,10,10],center=true);//top
            for(i = [-1,1]){
               //translate([0,Y+i*(51+20-8)/2,chamber_Z_gap_0+5+2]) cube([101,8,10],center=true);//top 
                translate([i*magnet_X_gap,Y,chamber_Z_gap_0-0.1]) cylinder(d1=5+1,d2=3+1,h=2+1,center=false);
                for(j = [-1,1]){
                    translate([i*magnet_X_gap,j*(housing_lm8uu_L-10)+Y,rod_smooth_Y_gap_Z+Y_moving_thick+housing_lm8uu_H/2-7+10]) cube([8.1,8.1,3.2],center=true);
                }
            }
        }
    }
}
// Plate
plate_holder_body_z = Y_moving_thick;
plate_gap_Y = 0;//(plate_dim_Y/2-lm8uu_z); // for now
plate_gap_X = 0;
plate_gap_Z = Y_moving_top_Z+plate_holder_body_z;
plate_holder_screw_X_gap = motor_Y_gap_Z+lm8uu_OD;
plate_holder_screw_Y_gap = lm8uu_z/1.3;
module plate(X=0,Y=0,Z=0,rabio=0){
    translate([plate_gap_X,plate_gap_Y+Y,plate_gap_Z]) cube([plate_dim_X+rabio,plate_dim_Y+rabio,plate_dim_Z+rabio],center=true);
}
