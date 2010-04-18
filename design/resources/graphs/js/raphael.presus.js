/*
 * Raphael.flow 0.1 - lospresus implementation, based on Raphaël
 *
 * Copyright (c) 2010 Roberto Salicio
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */
(function () {
  Raphael.fn.presus = Raphael.fn.presus || {};
  Raphael.fn.presus.start_block = function (sx,sy,ex,ey,percent,txt1,despl,color){
    var padding = 10;
    var l = 50;
    
    y = despl+130-260*percent/100
    this.path(["M",sx,sy,"L",sx+ex,sy,"C",(ex+l),sy,(305-l),y,305,y,"L",305+20,y,"L",305+20,y+260*percent/100,"L",305,y+260*percent/100,"C",(305-l),y+260*percent/100,(ex+l),sy+ey,ex,sy+ey,"L",sx,sy+ey,"L",sx+10,sy+ey/2,"z"]).attr({fill: color, "stroke-width": 0, opacity: percent/100.0+0.25});//.attr({fill: "url(http://www.irunmywebsite.com/images/irunmywebsitesmall.png)", stroke: color});
    
    var txt = this.print(0, 0, percent+"%", this.getFont("League Gothic"), 60).attr({fill: "#fff"});
    var bbox = txt.getBBox();
    txt.translate(sx+ex-bbox.width-padding,sy+bbox.height-5)

    txt = this.print(0, 0, txt1, this.getFont("League Gothic"), 24).attr({fill: "#fff"});
    var bbox = txt.getBBox();
    txt.translate(sx+ex-bbox.width-padding,sy+bbox.height+55)

  };
  
  Raphael.fn.presus.end_block = function (sx,sy,ex,ey,percent,txt1,despl,color){
    var padding = 10;
    var l = 50;
    
    this.path(["M",459+sx,sy,"L",459+sx+ex,sy,"L",459+sx+ex-10,sy+ey/2,"L",459+sx+ex,sy+ey,"L",459+sx,sy+ey,"C",459+sx-l,sy+ey,355+l,despl+130,355,despl+130,"L",335,despl+130,"L",335,despl+130-260*percent/100,"L",355,despl+130-260*percent/100,"C",355+l,despl+130-260*percent/100,459+sx-l,sy,459+sx,sy,"z"]).attr({fill: color, "stroke-width": 0});
    
    var txt = this.print(0, 0, percent+"%", this.getFont("League Gothic"), 40).attr({fill: "#fff"});
    var bbox = txt.getBBox();
    txt.translate(450+sx+ex-bbox.width-padding,sy+bbox.height-3)
    
    txt = this.print(0, 0, txt1, this.getFont("League Gothic"), 20).attr({fill: "#fff"});
    var bbox = txt.getBBox();
    txt.translate(450+sx+ex-bbox.width-padding,sy+bbox.height+37)
  };
})();

