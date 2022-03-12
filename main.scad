R1=10;
R2=20;
WALL=2;
HEIGHT=10;
BASE_HEIGHT=2;
MID_HEIGHT=4;
$fn=100;

for (a=[0:90:360])rotate([0,0,a])quarter();

module quarter() {
    difference(){
        union() {
            // Tooth
            rotate([90,0,90])
                linear_extrude(R2, false)
                    polygon([[0,0],[R1,0], [0,HEIGHT]]);
            // Base
            linear_extrude(BASE_HEIGHT)
            sector(R2,[0,90]);
            // Wall
            linear_extrude(HEIGHT)
                arc(R2,[0,90],WALL);
            // Mid
            linear_extrude(MID_HEIGHT)
                sector(R1, [0,90]);
        }
        
        // Slicing Wall
        translate([0,0,-HEIGHT/2])
        linear_extrude(HEIGHT*2)
        arc(R2+WALL,[0,90],WALL*2);
        
        // Slicing mid
        translate([0,0,MID_HEIGHT])
            cylinder(HEIGHT*2, R1, R1);
    }
}
    
module sector(radius, angles, fn = $fn) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = $fn) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 