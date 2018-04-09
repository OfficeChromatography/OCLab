rabio = 0.5; //will be overwritten in the actual file

include <RaspberryPiCamera.scad>

// nema17: 
nema_xy = 42.3;
nema_z = 47;
nema_cyl_d = 25;
nema_cyl_h = 2;
nema_axe_r = 2.5;
nema_axe_h = 24;
nema_vis_space = nema_xy/2-4-1.5;


module nema17(rabio=0) {
translate([0,0,-nema_z/2-nema_axe_h/2])
    difference(){
        union(){
            cube([nema_xy+rabio,nema_xy+rabio,nema_z+rabio],center=true);
            translate([0,0,nema_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h,d=nema_axe_r*2+rabio,center=true);
            translate([0,0,nema_z/2+nema_cyl_h/2]) cylinder(h=nema_cyl_h,d=nema_cyl_r*2+rabio,center=true);
        }
        union(){
            for(i = [-1,1]){
            for(j = [-1,1]){
                translate([i*nema_vis_space,j*nema_vis_space,nema_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h*10,d=3+rabio,center=true);
            }
        }
        }
    }

}

module nema17_neg(rabio=0) {
translate([0,0,-nema_z/2-nema_axe_h/2])
union(){
cube([nema_xy+rabio,nema_xy+rabio,nema_z+rabio],center=true);
translate([0,0,nema_z/2+nema_axe_h/2]) cylinder(h=nema_z*3,d=nema_cyl_d+rabio,center=true);
//translate([0,0,nema_z/2+nema_cyl_h/2]) cylinder(h=nema_cyl_h,r=nema_cyl_r,center=true);
for(i = [-1,1]){
    for(j = [-1,1]){
        translate([i*nema_vis_space,j*nema_vis_space,nema_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h*10,d=3+rabio,center=true);
    }
}
}
}

module nema17_neg_cyl_only(rabio=0) {
translate([0,0,-nema_z/2-nema_axe_h/2])
union(){
translate([0,0,nema_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h,d=nema_cyl_d+rabio,center=true);
//translate([0,0,nema_z/2+nema_cyl_h/2]) cylinder(h=nema_cyl_h,r=nema_cyl_r,center=true);
for(i = [-1,1]){
    for(j = [-1,1]){
        translate([i*nema_vis_space,j*nema_vis_space,nema_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h*10,d=3+rabio,center=true);
    }
}
}
}

//nema17_neg();

// nema17_small: 
nema_xy = 42.3;
nema_small_z = 28;
nema_cyl_r = 11;
nema_cyl_h = 2;
nema_axe_r = 2.5;
nema_axe_small_h = 18;

module nema17_small() {
translate([0,0,-nema_small_z/2-nema_axe_small_h/2])
union(){
cube([nema_xy,nema_xy,nema_small_z],center=true);
translate([0,0,nema_small_z/2+nema_axe_small_h/2]) cylinder(h=nema_axe_small_h,r=nema_axe_r,center=true);
translate([0,0,nema_small_z/2+nema_cyl_h/2]) cylinder(h=nema_cyl_h,r=nema_cyl_r,center=true);
}
}

// nema14: 
nema14_xy = 35;
nema14_z = 28;
nema_cyl_r = 11;
nema_cyl_h = 2;
nema_axe_r = 2.5;
//nema_axe_h = 18;
nema14_vis_space = 13;
module nema14() {
translate([0,0,-nema14_z/2-nema_axe_h/2])
union(){
cube([nema14_xy,nema14_xy,nema14_z],center=true);
translate([0,0,nema14_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h,r=nema_axe_r,center=true);
translate([0,0,nema14_z/2+nema_cyl_h/2]) cylinder(h=nema_cyl_h,r=nema_cyl_r,center=true);
}
}
module nema14_neg(rabio=0) {
translate([0,0,-nema14_z/2-nema_axe_h/2])
union(){
cube([nema14_xy+rabio,nema14_xy+rabio,nema14_z+rabio],center=true);
translate([0,0,nema_axe_h/2]) cylinder(h=100,d=nema_cyl_d+rabio,center=true);
for(i = [-1,1]){
    for(j = [-1,1]){
        translate([i*nema14_vis_space,j*nema14_vis_space,nema14_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h*3,d=3+rabio,center=true);
    }
}
}
}
module nema14_neg_body(rabio=0) {
translate([0,0,-nema_z/2-nema_axe_h/2])
union(){
cube([nema14_xy+rabio,nema14_xy+rabio,nema14_z+rabio],center=true);
}
}
module nema14_neg_back(rabio=0) { // used for attach in the back
translate([0,0,-nema14_z-nema_axe_h/2])
union(){
for(i = [-1,1]){
    for(j = [-1,1]){
        translate([i*nema14_vis_space,j*nema14_vis_space,0]) cylinder(h=30,d=3+rabio,center=true);
        translate([i*nema14_vis_space,j*nema14_vis_space,-10]) cylinder(h=10,d=8+rabio,center=true);
    }
}
}
}

// lm8uu
lm8uu_ID = 8;
lm8uu_OD = 15;
lm8uu_z = 24;
lm8luu_z = 45;
module lm8uu(rabio=rabio){
cylinder(h=lm8uu_z+rabio,d=lm8uu_OD+rabio,center=true);
}


housing_lm8uu_L = 30;
housing_lm8uu_W = 34;
housing_lm8uu_H = 20;
housing_lm8uu_D = 11;
housing_lm8uu_d2 = 9;
housing_lm8uu_d1 = 12;
module housing_lm8uu(){
    difference(){
        union(){
            cube([housing_lm8uu_W,housing_lm8uu_H,housing_lm8uu_L],center=true);
        }
        union(){
            cylinder(d=lm8uu_OD,h=housing_lm8uu_L*2,center=true);
            for(i = [-1,1]){
                for(j = [-1,1]){
                    translate([i*housing_lm8uu_d1,0,j*housing_lm8uu_d2]) rotate([90,0,0]) cylinder(h=housing_lm8uu_H*2,d=4,center=true);
                }
            }
        }
    }
}
module housing_lm8uu_neg(rabio=rabio,h=0){
    union(){
        for(i = [-1,1]){
            for(j = [-1,1]){
                translate([i*housing_lm8uu_d1,0,j*housing_lm8uu_d2]) rotate([90,0,0]) cylinder(h=housing_lm8uu_H*2,d=4+rabio,center=true);
                translate([i*housing_lm8uu_d1,(h*0.75+housing_lm8uu_H/2),j*housing_lm8uu_d2]) rotate([90,0,0]) cylinder(h=h/2+rabio*2,d=4*2+rabio,center=true);
            }
        }
    }
}
//housing_lm8uu_neg();
//housing_lm8uu();
// machin6uu
machin6uu_ID = 6;
machin6uu_OD = 10;
machin6uu_z = 6;
module machin6uu(rabio=rabio,rabio_h = 0){
cylinder(h=machin6uu_z+rabio_h,d=machin6uu_OD+rabio,center=true);
}

// lm10uu
lm10uu_ID = 10;
lm10uu_OD = 19;
lm10uu_z = 29;
module lm10uu(rabio=rabio){
cylinder(h=lm10uu_z+rabio,d=lm10uu_OD+rabio,center=true);
}

// 608zz
608zz_ID = 8;
608zz_OD = 22;
608zz_z = 7;
module 608zz() {
difference(){
cylinder(h=608zz_z,r=608zz_OD/2,center=true);
//scylinder(h=608zz_z*2,r=608zz_ID/2,center=true);
}
}

// 604zz
604zz_ID = 4;
604zz_OD = 12;
604zz_z = 4;
module 604zz() {
difference(){
cylinder(h=604zz_z,r=604zz_OD/2,center=true);
cylinder(h=604zz_z*2,r=604zz_ID/2,center=true);
}
}

// 623zz
623zz_ID = 3;
623zz_OD = 10;
623zz_z = 4;
module 623zz() {
difference(){
cylinder(h=623zz_z,r=623zz_OD/2,center=true);
cylinder(h=623zz_z*2,r=623zz_ID/2,center=true);
}
}

//seringe
syringe_body_h = 30;
syringe_body_r = 2;
syringe_piston_h = 30;
syringe_piston_r = 1;
syringe_needle_h = 20;
syringe_needle_r = 0.5;
syringe_grip_h = 1;
syringe_grip_r = 2;
module syringe() {
cylinder(h=syringe_needle_h,r=syringe_needle_r);
translate([0,0,syringe_needle_h]) cylinder(h=syringe_body_h,r=syringe_body_r);
translate([0,0,syringe_body_h+syringe_needle_h]) cylinder(h=syringe_piston_h,r=syringe_piston_r);
translate([0,0,syringe_body_h+syringe_needle_h+syringe_piston_h]) cylinder(h=syringe_grip_h,r=syringe_grip_r);
}

syringe_12_needle_d = 4; // 2.4 in reality
syringe_12_needle_h = 50; // 
syringe_12_pink_d = 7; // 5.7 in reality
syringe_12_pink_h = 17.2; // 
syringe_12_body_d = 17.3; // 
syringe_12_body_h = 75; // 
syringe_12_flange_d = 31; // 
syringe_12_flange_h = 2; // 
syringe_12_piston_in_d = 20; // 
syringe_12_piston_in_h = 13.3; // 
syringe_12_piston_out_d = 20; //
syringe_12_piston_out_h = 73.7; // 
syringe_12_Y_gap_body_etc = 17.3/2-(0.8+2.25);
module syringe_12(rabio=rabio,inside = 1){
    union() {
        translate([0,0,0]) cylinder(d = syringe_12_needle_d+rabio,h = syringe_12_needle_h);
        translate([0,0,syringe_12_needle_h]) cylinder(d = syringe_12_pink_d,h = syringe_12_pink_h);
        translate([0,syringe_12_Y_gap_body_etc,syringe_12_needle_h+syringe_12_pink_h]) cylinder(d = syringe_12_body_d+rabio,h = syringe_12_body_h);
        translate([0,syringe_12_Y_gap_body_etc,syringe_12_needle_h+syringe_12_pink_h+syringe_12_body_h]) cylinder(d = syringe_12_flange_d+rabio,h = syringe_12_flange_h);
        translate([0,syringe_12_Y_gap_body_etc,syringe_12_needle_h+syringe_12_pink_h+syringe_12_body_h+syringe_12_flange_h]) cylinder(d = syringe_12_piston_in_d +rabio,h = syringe_12_piston_in_h+inside*(syringe_12_piston_out_h-syringe_12_piston_in_h));
    }
}

// vial: dim
N9_r = 11.6/2;
N9_h = 32;
module N9(rabio=rabio) {
translate([0,0,-N9_h/2]) cylinder(h=N9_h,d=N9_r*2+rabio,center=true);
}
// gt2 pulley

gt2_pulley_d_1 = 15;
gt2_pulley_d_2 = 12;
gt2_pulley_h = 15;
gt2_pulley_h_1 = 7;
gt2_pulley_h_2 = 7;
gt2_pulley_h_3 = 1;
module gt2_pulley() {
    union(){
        translate([0,0,-gt2_pulley_h_1]) cylinder(d=gt2_pulley_d_1,h=gt2_pulley_h_1,center=true);
        translate([0,0,-gt2_pulley_h_1*0]) cylinder(d=gt2_pulley_d_2,h=gt2_pulley_h_2,center=true);
        translate([0,0,gt2_pulley_h_1*0.5+gt2_pulley_h_3/2]) cylinder(d=gt2_pulley_d_1,h=gt2_pulley_h_3,center=true);
    }
}

// endstop

endstop_x = 16;
endstop_y = 40;
endstop_z = 8;
endstop_d = 3.5;
endstop_out_x = 2;
endstop_out_y_1 = 2;
endstop_out_y_2 = 17;
endstop_out_y_3 = 36;
module endstop_neg() {
    union(){
        translate([endstop_x/2-endstop_out_x,endstop_y/2-endstop_out_y_1]) cylinder(h=10*endstop_z,d=endstop_d,center=true);
        translate([-endstop_x/2+endstop_out_x,endstop_y/2-endstop_out_y_1]) cylinder(h=10*endstop_z,d=endstop_d,center=true);
        translate([endstop_x/2-endstop_out_x,endstop_y/2-endstop_out_y_2]) cylinder(h=10*endstop_z,d=endstop_d,center=true);
        translate([endstop_x/2-endstop_out_x,endstop_y/2-endstop_out_y_3]) cylinder(h=10*endstop_z,d=endstop_d,center=true);
    }
}
module endstop() {
    difference(){
        cube([endstop_x,endstop_y,endstop_z],center=true);
        endstop_neg();
    }
}

// coupler
coupler_d = 18;
coupler_h = 25;
module coupler(center = true){
    translate([0,0,0]) cylinder(d=coupler_d,h=coupler_h,center=center);
}

// tr8
tr8_d = 8;
tr8_h=150;
tr8_nut_d1 = 22;
tr8_nut_d2 = 10;
tr8_nut_h1 = 3.5;
tr8_nut_h2 = 10;
tr8_nut_r = 8;
module tr8_nut(rabio=rabio){
    difference() {
        union(){
            translate([0,0,tr8_nut_h1/2+tr8_nut_d2]) cylinder(h=tr8_nut_h1,d=tr8_nut_d1,center=true);
            translate([0,0,tr8_nut_h2/2]) cylinder(h=tr8_nut_h2,d=tr8_nut_d2,center=true);
        }
        union(){
            translate([1*tr8_nut_r,0*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
            translate([-1*tr8_nut_r,0*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
            translate([0*tr8_nut_r,1*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
            translate([0*tr8_nut_r,-1*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
        }
    }
}
module tr8_nut_neg(rabio=rabio,d1 = false){
    union(){
        translate([0,0,tr8_nut_h2/2]) cylinder(h=tr8_nut_h2*10,d=tr8_nut_d2+2*rabio,center=true);
        translate([1*tr8_nut_r,0*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
        translate([-1*tr8_nut_r,0*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
        translate([0*tr8_nut_r,1*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
        translate([0*tr8_nut_r,-1*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
			if(d1){
				translate([0,0,tr8_nut_h1/2+tr8_nut_d2]) cylinder(h=tr8_nut_h1+rabio*2,d=tr8_nut_d1+rabio*4,center=true);
			}
    }
}
module tr8(){
    cylinder(d=tr8_d,h=tr8_h);
}

power_supply_x = 67;
power_supply_y = 171;
power_supply_z = 42;
module power_supply(rabio=0){
    color("black") cube([power_supply_x,power_supply_y,power_supply_z],center=true);
}

inductif_d = 12;
inductif_z = 62;
module inductif_sensor(rabio=rabio){
    color("orange") cylinder(d=inductif_d+rabio,h=inductif_z);
}

module profile(length = 200,type = 1){
    if(type == 1){ // 1 = I20
        difference(){
            translate([0,0,length/2]) cube([20,20,length],center=true);
            union(){
                for(i = [-1,1]){
                        translate([i*10,0,length/2]) cube([6.35*2,5,length*2],center=true);
                    translate([0,i*10,length/2]) cube([5,6.35*2,length*2],center=true);
                }
            }
        }
        
    }
}
profile_slider_xy = 45;
profile_slider_z = 81;
module profile_slider(){
    translate([0,0,0]) cube([profile_slider_xy,profile_slider_xy,profile_slider_z],center=true);
}
//http://www.motedis.com/shop/Dynamics-linear-units/Shaft-support/Shaft-Support-standing/Shaft-supports-SH8::1250.html
sh8_h = 20;
sh8_W = 42;
sh8_E = 18;
sh8_H= 32.8;
sh8_T= 6;
sh8_B=14;
sh8_C=32;
sh8_M = 4;
module sh8(){
    difference(){
        union(){
            translate([-sh8_E/2,-sh8_B/2,-sh8_h]) cube([sh8_E,sh8_B,sh8_H],center=false);
            translate([-sh8_W/2,-sh8_B/2,-sh8_h]) cube([sh8_W,sh8_B,sh8_T],center=false);
        }
        union(){
            rotate([90,0,0]) cylinder(d=8.1,h=sh8_B*2,center=true);
            translate([-sh8_C/2,0,0]) cylinder(d=sh8_M,h=sh8_H*2,center=true);
            translate([sh8_C/2,0,0]) cylinder(d=sh8_M,h=sh8_H*2,center=true);
        }
    }
}


//http://www.motedis.com/shop/Dynamics-linear-units/Shaft-support/Shaft-support-flange/Shaft-Supports-SHF10::1230.html
shf10_L = 43;
shf10_B = 32;
shf10_T = 10;
shf10_F= 5;
shf10_H= 24;
shf10_G= 20;
shf10_M = 4;
module shf10(){
    difference(){
        union(){
            translate([0,0,0]) cylinder(d=shf10_G ,h=shf10_T,center=false);
            translate([-shf10_L/2,-shf10_G/2,0]) cube([shf10_L,shf10_G,shf10_F],center=false);
        }
        union(){
            cylinder(d=10,h=shf10_T*4,center=true);
            translate([-shf10_B/2,0,0]) cylinder(d=shf10_M,h=shf10_F*3,center=true);
            translate([shf10_B/2,0,0]) cylinder(d=shf10_M,h=shf10_F*3,center=true);
        }
    }
}

shf8_L = 43;
shf8_B = 30;
shf8_T = 10;
shf8_F= 5;
shf8_H= 24;
shf8_G= 20;
shf8_M = 4;
module shf8(){
    difference(){
        union(){
            translate([0,0,0]) cylinder(d=shf8_G ,h=shf8_T,center=false);
            translate([-shf8_L/2,-shf8_G/2,0]) cube([shf8_L,shf8_G,shf8_F],center=false);
        }
        union(){
            cylinder(d=8,h=shf8_T*4,center=true);
            translate([-shf8_B/2,0,0]) cylinder(d=shf8_M,h=shf8_F*3,center=true);
            translate([shf8_B/2,0,0]) cylinder(d=shf8_M,h=shf8_F*3,center=true);
        }
    }
}
// rpi camera
rpi_X = 24;
rpi_Y = 25;
rpi_Z = 9;
module rpi_cam(){ // translate to have the lens at 0,0,0
    rotate([0,0,90]) translate([0,-2,rpi_Z/2+1]) rotate([0,180,0]) raspberryPiCamera();
    rotate([0,0,90]) translate([0,-2,rpi_Z/2+1]) rotate([0,180,0]) camera_screw();
    
}
//rpi_cam();
//rpi();

rpi_z = 20;
rpi_x = 56;
rpi_y = 85;
rpi_ext = 5;
module rpi(){
    union(){
        color("green") translate([0,0,0]) cube([rpi_x+rabio*2,rpi_y+rabio*2,rpi_z],center=true);
        color("black") translate([0,-rpi_y/2,0]) cube([12+2,rpi_ext+2,rpi_z+1],center=true); // sd
        color("black") translate([rpi_x/2,-rpi_y/2+10,0]) cube([rpi_ext+2,10+2,rpi_z+1],center=true); // power
        color("black") translate([rpi_x/2,-rpi_y/2+32,0]) cube([rpi_ext+2,15+2,rpi_z+1],center=true); // hdmi
        color("black") translate([rpi_x/2,-rpi_y/2+52,0]) cube([rpi_ext+2,8+2,rpi_z+1],center=true); // audio
        color("black") translate([rpi_x/2-10,rpi_y/2,0]) cube([16+2,rpi_ext+2,rpi_z+1],center=true); // ethernet
        color("black") translate([-rpi_x/2+27,rpi_y/2,0]) cube([13+2,rpi_ext+2,rpi_z+1],center=true);  // usb 1
        color("black") translate([-rpi_x/2+9,rpi_y/2,0]) cube([13+2,rpi_ext+2,rpi_z+1],center=true);  // usb 2
        
    }
    
}


// a bit tricky to use but hey
module  flexi_wall(r,x,z,wall){
   translate([0,-(1-sin(acos(x/2/r)))*r,0])difference(){
            translate([0,r,(z)/2]) cylinder(h=z,r=r,center=true);
            translate([0,r,(z)/2]) cylinder(h=z*2,r=r-wall,center=true);
            translate([0,r*2,(z)/2]) cube([r*3,r*3.5,z*2],center=true);
            translate([(x/2+r),0,(z)/2]) cube([r*2,r,z*2],center=true);
            translate([-(x/2+r),0,(z)/2]) cube([r*2,r,z*2],center=true);
        }
        echo((1-sin(acos(x/2/r)))*r);
}

// delrin nuts
delrin_X = 38;
delrin_Y= 32;
delrin_Z = 13;
delrin_X_screw_gap = 10;
delrin_Y_screw_gap = 7;
module delrin(){
	difference(){
		cube([delrin_X,delrin_Y,delrin_Z],center=true);
		rotate([90,0,0]) cylinder(d=8,h=40,center=true);
		for(i = [-1,1]){
			translate([i*10,7,0]) cylinder(d=5.5,h=50,center=true);
		}
	}
}
module delrin_neg(,cuube=false){
	union(){
		for(i = [-1,1]){
			translate([i*10,7,0]) cylinder(d=5.5,h=100,center=true);
		}
		if(cuube){
			cube([delrin_X+rabio,delrin_Y+rabio,delrin_Z+rabio],center=true);
		}
	}
}

//delrin();

module lurrlock_needle(rabio=0){ // origin at the end of the needle
    cylinder(d=2,h=34,center=false); // needle
    translate([0,0,13]) cylinder(d=8+rabio,h=21,center=false); // spring
    translate([0,0,34]) cylinder(d=11+rabio,h=7,center=false); // middle cyl
    translate([0,0,41]) cylinder(d=6+rabio,h=14,center=false); // top cyl
    translate([0,0,41+4.5]) cube([3+rabio,10+rabio,9],center=true);// cube 1
    translate([0,0,41+4.5]) cube([10+rabio,3+rabio,9],center=true);// cube 2
    translate([-10,0,41+4.5]) cube([15,3+rabio,25],center=true);// cube input
}
//lurrlock_needle();

module igus_carriage(rabio=0){
    difference(){
        cube([81,45,45],center=true);
        cube([82,20,20],center=true);
    }
}

// M4 prusa
prusa_X_M4_gap = 23/2;
prusa_Z_M4_gap = 22/2;
module M4_prusa(rabio=0){
    union(){
        for(i = [-1,1]){
            for(j = [-1,1]){
                    translate([prusa_X_M4_gap*i,0,j*prusa_Z_M4_gap]) rotate([90,0,0]) cylinder(d=4+rabio,h=50,center=true);
                translate([prusa_X_M4_gap*i,20,j*prusa_Z_M4_gap]) rotate([90,0,0]) cylinder(d=7+rabio*2,h=7,center=true,$fn=6);
            }
        }
    }
}
