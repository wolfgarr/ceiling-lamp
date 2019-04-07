materialThickness = 4;
cutWidth = .12;

height = 250;
outerWidth = 300;
innerWidth = 200;

outerPlankCount = 24;
innerPlankCount = 24;
outerPlankWidth = 18;
innerPlanWidth = 12;

boxJointWidth = 6;
lampHoleDiam = 40;
bottomHoleDiam = innerWidth-materialThickness*2;

translate([330,0]) end(lampHoleDiam);
translate([330,330]) end(bottomHoleDiam);

rim(outerWidth, outerPlankCount, outerWidth - 20);
rim(innerWidth, innerPlankCount, innerWidth - 20);

translate([0,300]) plank(outerPlankWidth);

module plank(width) {
    difference() {
        union() {
            square([height, width], center = true);
    
            // male box joints
            translate([height / 2 + materialThickness / 2, 0]) square([materialThickness, boxJointWidth + cutWidth], center = true);
            translate([-height / 2 - materialThickness / 2, 0]) square([materialThickness, boxJointWidth + cutWidth], center = true);
        }
        
        // female box joints
        translate([height / 4, 0]) square([materialThickness - cutWidth, boxJointWidth], center = true);
        translate([-height / 4, 0]) square([materialThickness - cutWidth, boxJointWidth], center = true);
    
    }
    
}

module rim(diam, plankCount, innerDiam) {
    difference() {
        union() {
            extra = 1.64 * outerWidth / 200;
            circle(d = diam - materialThickness + extra, $fn = plankCount);
            
            // male box joints
            #for (i = [0 : plankCount - 1]) {
                rotate([0, 0, (180 / plankCount) + i * 360/outerPlankCount]) {
                    translate([diam/2,0,0]) {
                        square([materialThickness + cutWidth, boxJointWidth + cutWidth], center = true);
                    }
                }
            }
        }
        circle(d = innerDiam, $fn = plankCount*2);
    }
}

module end(holediam) {
    difference(){
        union(){
            circle(d = outerWidth + materialThickness +5, $fn = outerPlankCount);
        }
        circle(d = holediam, $fn = innerPlankCount);
        
        // female outer box joints
        for(i = [0 : outerPlankCount - 1]) {
            rotate([0, 0,  i * 360/outerPlankCount]) {
                translate([outerWidth/2,0,0]) {
                    square([materialThickness - cutWidth, boxJointWidth], center = true);
                }
            }
        }
        
        // female inner box joints
        for(i = [0 : innerPlankCount - 1]) {
            rotate([0, 0, (180/innerPlankCount)+ i * 360/innerPlankCount]) {
                translate([innerWidth/2,0,0]) {
                    square([materialThickness - cutWidth, boxJointWidth], center = true);
                }
            }
        }
    }
}