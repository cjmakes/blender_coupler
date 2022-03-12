R1=10;
R2=20;
R3=2;
WALL=2;
HEIGHT=10;
BASE_HEIGHT=2;
MID_HEIGHT=4;
$fn=500;

VIEW="";
if (VIEW=="top"){
    top();
} else if (VIEW=="bottom"){
    bottom();
} else {
    translate([0,0,HEIGHT*2])top();
    bottom();
}

module top(){
    difference(){
        // Stock
        cylinder(HEIGHT*2, R2, R2);
        // Remove bottom
        bottom();
        // Drill Center
        cylinder(HEIGHT*3, R3, R3);
    }
}

module bottom() {
    difference(){
        union() {
            // Teeth
            for (a=[0:90:360])
                rotate([0,0,a])
                    tooth(R2,R1,HEIGHT);         
            // Base
            cylinder(BASE_HEIGHT, R2, R2);          
            // Wall
            ring(R2, WALL);           
            // Mid
            cylinder(MID_HEIGHT, R1,R1);
        }
        
        // Slicing Wall
        translate([0,0,-HEIGHT/2])
            ring(R2+WALL, 100);
        
        // Slicing mid
        translate([0,0,MID_HEIGHT])
            cylinder(HEIGHT*2, R1, R1);
    }
}

module tooth(l,w,h){
    rotate([90,0,90])
        linear_extrude(l, false)
            polygon([[0,0],[w,0], [0,h]]);
}
module ring(radius, width){
     // Wall
    difference(){
        cylinder(HEIGHT, radius+width,radius+width);
        translate([0,0,-HEIGHT])cylinder(HEIGHT*3, radius, radius);
    };
}