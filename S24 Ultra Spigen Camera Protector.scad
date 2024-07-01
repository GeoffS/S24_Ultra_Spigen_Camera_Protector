include <../OpenScadDesigns/MakeInclude.scad>
include <../OpenScadDesigns/chamferedCylinders.scad>

firstLayerZ = 0.3;
upperLayersZ = 0.2;

caseExteriorX = 75 + 0.3;
caseExteriorZ = 11.75 + 0.3;
caseCornerRadius = 12.6;

cornersCtrsX = caseExteriorX -2*caseCornerRadius;

protectorExtCornerRadius = caseCornerRadius + 3;
baseZ = firstLayerZ + 7*upperLayersZ;
upperZ = 1;
protectorZ = caseExteriorZ + baseZ + upperZ;
echo(str("protectorZ = ", protectorZ));

module exterior()
{
  hull()
  {
    protectorExtCorner(0);
    protectorExtCorner(35); //65);
  }
}

module interior()
{
  hull()
  {
    protectorIntCorner(0);
    protectorIntCorner(200);
  }
}

module protectorIntCorner(y)
{
  cx = cornersCtrsX/2;
  echo(str("protectorIntCorner() cx = ", cx));
  d = 2*caseCornerRadius;
  h = protectorZ - baseZ - upperZ;

  botCZ = 4;
  botH = botCZ + 2;

  topCZ = 2;
  topH = topCZ +2;
  r = 2;
  doubleX() translate([cx, y, 0])
  {
    translate([0,0,baseZ])
      mirror([0,0,1])
        translate([0,0,-botH])
          radiusedChamferedCylinder(d, botH, r, botCZ);
    translate([0,0,protectorZ-topH+2*nothing])
      radiusedChamferedCylinder(d, topH, r, topCZ);
  }

}

module protectorExtCorner(y)
{
  cx = cornersCtrsX/2;
  echo(str("protectorExtCorner() cx = ", cx));
  d = 2*protectorExtCornerRadius;
  h = protectorZ;
  r = 2;
  cz = 2;
  doubleX() translate([cx, y, 0])
    radiusedChamferedCylinderDoubleEnded(d, h, r, cz);
}

module itemModule()
{
  difference()
  {
    exterior();
    interior();
  }
}

module clip(d=0)
{
	//tc([-200, -400, -10], 400);
}

if(developmentRender)
{
	display() itemModule();
}
else
{
	rotate([0,0,180]) itemModule();
}
