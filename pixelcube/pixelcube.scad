use <polyround.scad>;

//$fn = 120;
$fa = 1;
$fs = 0.4;

// cube width and depth
cw = 10;
cd = 10;

// clearance
c = 0.4;

// length of the stem of the knob
kl = 3.6;

// height of the thing
h = 42;
// number of elements for width and depth
we = 10;
de = 10;

width = cw*we + c*(we-1);
depth = cd*de + c*(de-1);

module knob(kh=12) {
  translate([0,0,-kh/2]) difference() {
    translate([0,-kl/2,0]) linear_extrude(kh) polygon([[1,0],[-1,0],[-1,kl-1.7],[-2,kl-1.3],[-1,kl],[1,kl],[2,kl-1.3],[1,kl-1.7]]);
    translate([kl/2+c,0.01,-0.01]) rotate([0,-90,0]) linear_extrude(kl+c*2) polygon([[0,kl/2+0.01],[kl+0.01,kl/2+0.01],[0,-kl/2-0.01]]);
    translate([-kl/2-c,0.01,kh + 0.01]) rotate([0,90,0]) linear_extrude(kl+c*2) polygon([[0,kl/2+0.01],[kl+0.01,kl/2+0.01],[0,-kl/2-0.01]]);
  }
}

module column(curW=2, curD=2) {
  translate([-(depth+cd)/2-c+(curD*(cd+c)),-(width+cw)/2-c+(curW*(cw+c)),0])
  union() {
    if (curW < we) translate([0,cw/2+c*sqrt(kl+c)*4/3,0]) knob();
    if (curD < de) translate([cd/2+c*sqrt(kl+c)*4/3,0,0]) rotate([0,0,-90]) knob();
    difference() {
      cube([cd,cw,h], center=true);
      if (curW > 1) translate([0,-cw/2+c,0]) scale([1+c*3/4,1+c*3/4,1]) knob(kh=h);
      if (curD > 1) translate([-cd/2+c,0,0]) rotate([0,0,-90]) scale([1+c*3/4,1+c*3/4,1]) knob(kh=h);
    }
  } 
}

module diffForRounded() {
  difference() {
    cube([depth+1,width+1,h+1],center=true);
    rr=4;
    radiiPoints=[[-depth/2,-width/2,rr],[-depth/2,width/2,rr],[depth/2,width/2,rr],[depth/2,-width/2,rr]];
    translate([0,0,-h/2]) polyRoundExtrude(radiiPoints, h,rr,0,30);
  }
}

difference() {
  for(curW=[1:we])
    for(curD=[1:de]) {
      column(curW, curD);
  }
  diffForRounded();
  //translate([0,0,h/2+c]) cube([depth+2,width+2,h], center=true);
  //translate([0,0,-h/2-c]) cube([depth+2,width+2,h], center=true);
}
//cube([cw,cd,h], center=true);
