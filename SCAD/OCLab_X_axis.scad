
motor_X_gap_X = prof_X_gap+prof_dim/2-nema14_xy/2;// - prof_dim;
motor_X_gap_Y = prof_Z_gap_Y - nema14_xy/2 - prof_dim/2;
motor_X_gap_Z = plate_gap_Z+ nema14_xy*1.5; //change here for up and down X axis
rod_smooth_X_gap_X = 0;
rod_smooth_X_gap_Y = prof_Z_gap_Y; // in case of rod on the profile
rod_smooth_X_gap_Z = motor_X_gap_Z;
//rod_smooth_X_gap_Z_bis = nema14_xy/4;
rod_smooth_X_gap_Y = motor_X_gap_Y; // in case of rod in the motor Y position
rod_smooth_X_gap_Z = motor_X_gap_Z;
rod_smooth_X_gap_Z_bis = 45/2;
rod_X_gap_Z = 45/2;
623_X_gap_Z = motor_X_gap_Z;
623_X_gap_X = -prof_X_gap-3;
623_X_gap_Y = motor_X_gap_Y;
module X_belt(hole=false){
    if(!hole){
        color("black")difference(){
            hull(){
                translate([623_X_gap_X,623_X_gap_Y,623_X_gap_Z]) rotate([-90,0,0])cylinder(d=623zz_OD+rabio,h=6,center=true);
                translate([motor_X_gap_X,motor_X_gap_Y,623_X_gap_Z]) rotate([-90,0,0])cylinder(d=623zz_OD+rabio,h=6,center=true);
            }
             hull(){
                translate([623_X_gap_X,623_X_gap_Y,623_X_gap_Z]) rotate([-90,0,0])cylinder(d=623zz_OD-rabio,h=7,center=true);
                translate([motor_X_gap_X,motor_X_gap_Y,623_X_gap_Z]) rotate([-90,0,0])cylinder(d=623zz_OD-rabio,h=7,center=true);
            }
        }
    }else{
        hull(){
                translate([623_X_gap_X*2,623_X_gap_Y,623_X_gap_Z]) rotate([-90,0,0])cylinder(d=623zz_OD*1.5,h=9,center=true);
                translate([motor_X_gap_X,motor_X_gap_Y,623_X_gap_Z]) rotate([-90,0,0])cylinder(d=623zz_OD*1.5,h=9,center=true);
            }
    }
}
module X_axis(X=0,Y=0,Z=0){
    color("pink")translate([motor_X_gap_X,motor_X_gap_Y,motor_X_gap_Z]) rotate([-90,0,0]) nema14();
    for(i = [-1,1]){
        translate([rod_smooth_X_gap_X,rod_smooth_X_gap_Y,rod_smooth_X_gap_Z+i*rod_smooth_X_gap_Z_bis]) rotate([0,90,0]) cylinder(d=rod_smooth_d,h=rod_smooth_X_h,center=true);// X smooth
    }
    for(i = [-1,1]){
            color("pink")translate([X,rod_smooth_X_gap_Y,rod_smooth_X_gap_Z+i*rod_smooth_X_gap_Z_bis]) rotate([0,90,0]) cylinder(d=lm8uu_OD,h=lm8uu_z,center=true);
    }
    //translate([motor_X_gap_X-4,motor_X_gap_Y+nema14_xy/2+5,motor_X_gap_Z-2]) rotate([90,0,180]) endstop();
    translate([X,motor_X_gap_Y+16.5/2,motor_X_gap_Z]) rotate([90,0,0]) import("i3rework_Xcarriage.stl");
    X_belt();
    translate([623_X_gap_X,623_X_gap_Y,623_X_gap_Z]) rotate([-90,0,0])cylinder(d=623zz_OD+rabio,h=6,center=true);
}


X_motor_X_gap = prof_X_gap+prof_dim/2-milling_thick/2;
module X_motor(){ // X_motor = Y_motor
    difference(){
        color("gold") union(){
					translate([prof_X_gap,prof_Z_gap_Y-(prof_dim/2+milling_thick/2),motor_X_gap_Z]) cube([prof_dim,milling_thick,prof_dim*3.3+nema14_xy],center=true); // M5s
					translate([X_motor_X_gap,motor_X_gap_Y,motor_X_gap_Z]) cube([milling_thick,nema14_xy/2,nema14_xy+5*rod_smooth_d],center=true); // rods
					translate([motor_X_gap_X,motor_X_gap_Y-nema_axe_h/2+milling_thick/2,motor_X_gap_Z]) cube([nema14_xy,milling_thick,nema14_xy],center=true); // motor
            
        }
        union(){
            translate([motor_X_gap_X,motor_X_gap_Y,motor_X_gap_Z]) rotate([-90,0,0]) nema14_neg(rabio);
            for(i = [-1,1]){for(j = [-1,1]){
               translate([motor_X_gap_X+j*nema14_vis_space,motor_X_gap_Y-1,motor_X_gap_Z+i*nema14_vis_space]) rotate([-90,0,0]) cylinder(d=7,h=4,center=true); 
            }}
            for(i = [-1,1]){
                translate([rod_smooth_X_gap_X,rod_smooth_X_gap_Y,rod_smooth_X_gap_Z+i*rod_smooth_X_gap_Z_bis]) rotate([0,90,0]) cylinder(d=rod_smooth_d+rabio,h=rod_smooth_X_h+rabio,center=true);// X smooth
                translate([motor_X_gap_X+nema14_vis_space,prof_Z_gap_Y-5,motor_X_gap_Z+i*nema14_vis_space]) rotate([90,0,0]) cylinder(d=7,h=50,center=true); // M3 guides
            }
            M5s();// M5
            //translate([motor_X_gap_X,motor_X_gap_Y,motor_X_gap_Z]) rotate([0,-90,0]) nema14_neg_back();
        }
    }
}

module X_end(){
    difference(){
        color("gold") union(){
                translate([-X_dim/2+milling_thick*0.75,motor_X_gap_Y,motor_X_gap_Z]) cube([milling_thick*1.5,nema14_xy/2,nema14_xy+4*rod_smooth_d],center=true);
            translate([-prof_X_gap,prof_Z_gap_Y-(prof_dim/2+milling_thick/2),motor_X_gap_Z]) cube([prof_dim,milling_thick,prof_dim*3.3+nema14_xy],center=true);
        }
        union(){
            for(i = [-1,1]){
                translate([rod_smooth_X_gap_X,rod_smooth_X_gap_Y,rod_smooth_X_gap_Z+i*rod_smooth_X_gap_Z_bis]) rotate([0,90,0]) cylinder(d=rod_smooth_d+rabio,h=rod_smooth_X_h+rabio,center=true);// X smooth
            }
            M5s();// M5
            X_belt(true);
            translate([623_X_gap_X,623_X_gap_Y,623_X_gap_Z]) rotate([-90,0,0])cylinder(d=3+rabio,h=100,center=true);
            translate([623_X_gap_X,prof_Z_gap_Y-prof_dim/2,623_X_gap_Z]) rotate([-90,0,0])cylinder(d=7+rabio,h=5,center=true);
        }
    }
}
// hpc6602
HP_C6602_x = 25; // 35
HP_C6602_y = 39;
HP_C6602_z = 44; // 60
HP_C6602_holder_x = 35; // 35
HP_C6602_holder_y = 10;
HP_C6602_holder_z = 60; // 60
Y_origin = rod_smooth_X_gap_Y+lm8uu_OD*2; // move here the cartridge
X_origin = 0;
Z_hpc6602_gap = -42;
module hpc6602(X=0,Y=0){
    //HP_C6602_x = 25;
    color("darkgreen") translate([X_origin+X,Y_origin+HP_C6602_y/2,rod_smooth_X_gap_Z+Z_hpc6602_gap+HP_C6602_z/2]) cube([HP_C6602_x,HP_C6602_y,HP_C6602_z],center=true);
}
module hpc6602_holder(X=0,Y=0){
    //HP_C6602_x = 25;
    color("grey")translate([X_origin+X,Y_origin-HP_C6602_y/2+HP_C6602_y/2,,rod_smooth_X_gap_Z-35+HP_C6602_holder_z/2]) cube([HP_C6602_holder_x,HP_C6602_holder_y,HP_C6602_holder_z],center=true);
}
hpc6602_holder_holder_Y = 8;
module hpc6602_holder_holder(X=0,Y=0){
    difference(){
        union(){
            translate([X,rod_smooth_X_gap_Y+(lm8uu_OD+Y_moving_thick)/2+5+hpc6602_holder_holder_Y/2,rod_smooth_X_gap_Z-3]) cube([X_moving_X,hpc6602_holder_holder_Y,55],center=true);//simple cube, see X_moving for exact dim
        }
        union(){
            translate([X,rod_smooth_X_gap_Y+(lm8uu_OD+Y_moving_thick)/2+hpc6602_holder_holder_Y/2-13,motor_X_gap_Z]) M4_prusa(rabio=0.5);
            translate([X,rod_smooth_X_gap_Y,rod_smooth_X_gap_Z+Z_hpc6602_gap]) hpc6602_holder_M2_link();// M2
            // M2 nuts
        }
    }
}

M2_fill_Z_1 = 40;
M2_fill_Z_2 = 9;
M2_fill_X = 11;
M2_hole_Z_1 = 35.5;
M2_hole_Z_2 = 14.5;
M2_hole_X = -10;
M2_d = 3;
module hpc6602_holder_M2_link(){
    translate([M2_fill_X,0,M2_fill_Z_1]) rotate([90,0,0]) cylinder(d=M2_d,h=200,center=true);
    translate([M2_fill_X,0,M2_fill_Z_2]) rotate([90,0,0]) cylinder(d=M2_d,h=200,center=true);
    for(i = [-1,1]){
        translate([i*M2_hole_X,0,M2_hole_Z_2]) rotate([90,0,0]) cylinder(d=M2_d,h=200,center=true);
        translate([i*M2_hole_X,0,M2_hole_Z_1]) rotate([90,0,0]) cylinder(d=M2_d,h=200,center=true);
        translate([i*M2_hole_X,(lm8uu_OD+Y_moving_thick)/2+5,M2_hole_Z_2]) rotate([90,0,0]) cylinder(d=4.5,h=6,center=true);
        translate([i*M2_hole_X,(lm8uu_OD+Y_moving_thick)/2+5,M2_hole_Z_1]) rotate([90,0,0]) cylinder(d=4.5,h=6,center=true);
    }
}
// X_moving
X_moving_thick=5;
X_moving_X = HP_C6602_holder_x;
X_moving_X_M3_gap = 23/2+2.5;
X_moving_Z_M3_gap = 26/2+8; 
module X_moving_M3(){
    union(){
        for(i = [-1,1]){
            for(j = [-1,1]){
                translate([X_moving_X_M3_gap*i,0,j*X_moving_Z_M3_gap]) rotate([90,0,0]) cylinder(d=3+rabio*2,h=100,center=true);
                translate([X_moving_X_M3_gap*i,(lm8uu_OD+Y_moving_thick)/2+5+hpc6602_holder_holder_Y,j*X_moving_Z_M3_gap]) rotate([90,0,0]) cylinder(d=6+rabio*2,h=(hpc6602_holder_holder_Y-2)*2,center=true,$fn=6);
            }
        }
    }
}