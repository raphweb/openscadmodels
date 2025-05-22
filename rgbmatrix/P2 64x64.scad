$fn = 30;

clearance = 0.4;
frameWall = 2;
frameDepth = 15;
panelDepth = 12;
panelWidth = 128;
panelHeight = panelWidth;

module duoY(dx, dy) {
    translate([dx, +dy]) children();
    translate([dx, -dy]) children();
}

module duoX(dx, dy) {
    translate([+dx, dy]) children();
    translate([-dx, dy]) children();
}

module quad(dx, dy) {
    duoX(dx, 0) duoY(0, dy) children();
}

module body() {
    difference() {
        linear_extrude(height=frameDepth, center=true) difference() {
            square([panelWidth + 2*frameWall, panelHeight + 2*frameWall], center=true);
            square(104, center=true);
            square([112, 32], center=true);
            duoY(0, 56.85) circle(1.5+clearance);
            duoX(56, 29) circle(1.4+clearance);
            quad(56.85, 44) circle(1.5+clearance);
        };
        translate([0, 0, (frameDepth-panelDepth)/2]) linear_extrude(height=panelDepth, center=true)
            square([panelWidth + clearance*2, panelHeight + clearance*2], center=true);
    }
}

render() duoX((panelWidth+frameWall+clearance)/2, 0) body();