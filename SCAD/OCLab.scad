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

full_prof = false;
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
    % translate([X_dim/2+frame_thick/2,(small_profs_Y/2)-profs_Y/2,Z_dim/2]) cube([frame_thick,small_profs_Y+40,Z_dim],center=true);//bottom
    % translate([-(X_dim/2+frame_thick/2),(small_profs_Y/2)-profs_Y/2,Z_dim/2]) cube([frame_thick,small_profs_Y+40,Z_dim],center=true);//bottom
    
}
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
include <OCLab_elec.scad>


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
        //translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),Z_dim-prof_dim*2]) rotate([90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // pippette holder
        //translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick),Z_dim-prof_dim*2]) rotate([90,0,0]) cylinder(d=10,h=5,center=true); // pippette holder
        //translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),prof_dim*3]) rotate([90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // vial holder
       // translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick),prof_dim*3]) rotate([90,0,0]) cylinder(d=10,h=5,center=true); // vial holder
				
				// name_printer
				translate([40,prof_Y_gap+prof_dim/2+milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); // name_printer
				translate([40,prof_Y_gap+prof_dim/2+milling_thick/2+milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=10,h=5,center=true); // name_printer
				translate([-40,prof_Y_gap+prof_dim/2+milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=5+rabio,h=milling_thick*1.5,center=true); //name_printer
				translate([-40,prof_Y_gap+prof_dim/2+milling_thick/2+milling_thick/2,prof_dim/2]) rotate([-90,0,0]) cylinder(d=10,h=5,center=true); // name_printer
        
        // elec holder
        for(i = [-1,1]){for(j = [-1,1]){
            translate([i*(prof_X_gap-prof_dim/2),-Y_dim/2+prof_dim+60+j*30,Z_dim-prof_dim/2]) rotate([0,-i*90,0]) M5();
        }}
        
        // angle conenctor
        for(i = [-1,1]){for(j = [-1,1]){
            translate([i*(prof_X_gap),prof_Z_gap_Y+30+j*8,prof_dim])M5();
            translate([i*(prof_X_gap),prof_Z_gap_Y+5,prof_dim*3+j*8]) rotate([-90,0,0])M5();
        }}
        
        // outside
        
    }
}

module vial_pipette_holder(){
    difference(){
        union(){
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),prof_dim*3]) cube([prof_dim,milling_thick,prof_dim],center=true);// milling bottom
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick*1.5),prof_dim*3-milling_thick*1.5]) cube([prof_dim,milling_thick*3,milling_thick*2],center=true);// body bottom
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick/2),Z_dim-prof_dim*2]) cube([prof_dim,milling_thick,prof_dim],center=true);// milling top
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick*1.5),Z_dim-prof_dim*2+milling_thick*1.25]) cube([prof_dim,milling_thick*3,milling_thick/2],center=true);// body top
        }
        union(){
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick*2.5),Z_dim-prof_dim*2+milling_thick*1.25]) cylinder(d1=3,d2=8,center=true,h=milling_thick/2+rabio);// pipette cyl
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick*2.5)+5,Z_dim-prof_dim*2+milling_thick*1.25]) cube([3,10,10],center=true);// pipette entrance: cube
            translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick*2.5),prof_dim*3+N9_h/2-milling_thick+2])N9(rabio=rabio*4);// vial
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
        translate([105,motor_X_gap_Y+12,motor_X_gap_Z-30]) rotate([90,0,-90]) import("Endstop_X_Support_Right.STL");
        translate([X,motor_X_gap_Y+16.5/2,motor_X_gap_Z]) rotate([90,0,0]) import("i3rework_Xcarriage.stl");
        X_motor();
        X_end();
        hpc6602_holder_holder(X,Y); 
        camera_holder();
        elec_holder();
    }else if(type == "frame"){
        profs();
        //green_top_front();
        M5s(true);
        
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
        X_end_stop_holder();
        hpc6602(X,Y);
        hpc6602_holder(X,Y);
        hpc6602_holder_holder(X,Y); 
        translate([105,motor_X_gap_Y+12,motor_X_gap_Z-30]) rotate([90,0,-90]) import("Endstop_X_Support_Right.STL");
    }else if(type == "assembled"){
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
        X_end_stop_holder();
        translate([105,motor_X_gap_Y+12,motor_X_gap_Z-30]) rotate([90,0,-90]) import("Endstop_X_Support_Right.STL");
        //power_supply_holder();
        hpc6602(X,Y);
        hpc6602_holder(X,Y);
        hpc6602_holder_holder(X,Y); 
    }else if(type == "front_frame"){        
        front_frame("top");
        translate([300,0,0]) front_frame("bottom");
       translate([-300,0,0])color("green") front_frame_link();
    }else if(type == "elec"){        
        profs();
        elec();
        elec_holder();
        translate([0,camera_Y_gap,Z_dim+1-prof_dim+3]) rotate([0,180,180])raspberryPiCamera();
        camera_holder();//translate([0,125,0])rotate([0,0,180])
    }else if(type == "full"){
        frames();
        front_frame("top");
        front_frame("bottom");
       color("green") front_frame_link();
       profs();
        //green_top_front();
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

        translate([105,motor_X_gap_Y+12,motor_X_gap_Z-30]) rotate([90,0,-90]) import("Endstop_X_Support_Right.STL");
        elec();
        elec_holder();
        //translate([0,camera_Y_gap,Z_dim+1-prof_dim+3]) rotate([0,180,180])raspberryPiCamera();
        camera_holder();//translate([0,125,0])rotate([0,0,180])
        //LED_UV();
        //vial_pipette_holder();
        //color("green") translate([-prof_X_gap,prof_Z_gap_Y+(prof_dim/2+milling_thick*2.5),prof_dim*3+N9_h/2-milling_thick+2])N9();
        X_motor();
        X_end();
        X_axis(X=X,Y=Y);
        //power_supply_holder();
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
full_view(type="front_frame");