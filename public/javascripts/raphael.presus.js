/*
 * Raphael.flow 0.1 - lospresus implementation, based on Raphaël
 *
 * Copyright (c) 2010 Roberto Salicio
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */
(function () {
  Raphael.fn.presus = Raphael.fn.presus || {};
  Raphael.fn.presus.start_block = function (sx,sy,ex,ey,percent,text,despl,start,font_size){
    var color = "#031e1f";
    var padding = 10;
    var l = 50;

    var pos = 260*percent/100;

    this.path([
      "M",sx,sy,
      "L",sx+ex,sy,
      "C",(ex+l),sy,(start-l),despl+130-pos,start,despl+130-pos,
      "L",start+20,despl+130-pos,
      "L",start+20,despl+130,
      "L",start,despl+130,
      "C",(start-l),despl+130,(ex+l),sy+ey,ex,sy+ey,
      "L",sx,sy+ey,
      "L",sx+10,sy+ey/2,
      "z"
    ]).attr({fill: color, "stroke-width": 0, opacity: (percent < 1 ? 0.1 : percent/100.0+0.35)});

    var txt = this.print(0, 0, percent+"%", this.getFont("League Gothic"), 60).attr({fill: "#fff"});
    var bbox = txt.getBBox();
    txt.translate(sx+ex-bbox.width-padding,sy+bbox.height-5)

    txt = this.print(0, 0, text, this.getFont("League Gothic"), font_size).attr({fill: "#fff"});
    var bbox = txt.getBBox();
    txt.translate(sx+ex-bbox.width-padding,sy+bbox.height+(font_size<24 ? 60 : 55));
  };

  Raphael.fn.presus.end_block = function (sx,sy,ex,ey,percent,text,despl,start,sblock){
    var color = "#031e1f";
    var padding = 10;
    var l = 50;

    var pos = 260*percent/100;

    this.path([
      "M",sblock+sx,sy,
      "L",sblock+sx+ex,sy,
      "L",sblock+sx+ex-10,sy+ey/2,
      "L",sblock+sx+ex,sy+ey,
      "L",sblock+sx,sy+ey,
      "C",sblock+sx-l,sy+ey,start+20+l,despl+130,start+20,despl+130,
      "L",start,despl+130,
      "L",start,despl+130-pos,
      "L",start+20,despl+130-pos,
      "C",start+20+l,despl+130-pos,sblock+sx-l,sy,sblock+sx,sy,
      "z"
    ]).attr({fill: color, "stroke-width": 0, opacity: (percent < 1 ? 0.1 : percent/100.0+0.35)});

    var txt = this.print(0, 0, percent+"%", this.getFont("League Gothic"), 40).attr({fill: "#fff"});
    var bbox = txt.getBBox();
    txt.translate(sblock-9+sx+ex-bbox.width-padding,sy+bbox.height-3);

    txt = this.print(0, 0, text, this.getFont("League Gothic"), 20).attr({fill: "#fff"});
    var bbox = txt.getBBox();
    txt.translate(sblock-7+sx+ex-bbox.width-padding,sy+bbox.height+37);
  };
})();

