padding = 5;
thickness = 8;
mc = 0.1;
grow = 1.05;
l = 40;
d = 16;
hole_dia = 3;
$fn=64;

mount_len = 2.5*(d+thickness);

echo("Mount length", mount_len);

module grill_mount() {
    
    
    space_for_mount = mount_len/2 - (d+thickness)/2;
    hole_pos = space_for_mount; // + space_for_mount/2;
    difference() {
        translate([-l/2-padding/2-1, 0, 0])
            cube([padding, mount_len, thickness], center=true);
        translate([-l/2-(padding)/2-1, -hole_pos-(hole_dia*grow)/2, 0])
            rotate([0, 90, 0])
                screw();
        translate([-l/2-(padding)/2-1, hole_pos+(hole_dia*grow)/2, 0])
            rotate([0, 90, 0])
                screw();
    }
    difference() {
        cube([l*grow, d+thickness, thickness], center=true);
        translate([-(l/2-d/2), 0, 0])
            cylinder(h=thickness+mc, d=d*grow, center=true);   
        translate([(l/2-d/2), 0, 0])
            cylinder(h=thickness+mc, d=d*grow, center=true);   
        translate([(l/2+3), 0, 0])
            cylinder(h=thickness+mc, d=d*grow, center=true);   
        union() {
            for(i=[(-d/2+3):0.5:(d/2-3)]) {
                translate([i, 0, 0])
                    cylinder(h=thickness+mc, d=d, center=true);   
            }
        }
    }
}

module enforcement() {
    difference() {
        cube([thickness, thickness, thickness], center=true);
        translate([thickness/2, -thickness/2, 0])
            cylinder(h=thickness+mc, r=thickness, center=true); 
    }
}

module screw() {
    union() {
        translate([0, 0, (padding+mc)/2-(3/2)])
        cylinder(h=3, d1=hole_dia, d2=hole_dia*2, center=true);
        cylinder(h=padding+mc, d=hole_dia*grow, center=true);
    }
}

//enforcement();
//screw();
grill_mount();