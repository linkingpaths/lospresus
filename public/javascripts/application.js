$(document).ready(function () {
  $('#city_search').autocomplete("/search", {
    dataType: "json",
    parse: function(data) {
      return $.map(data, function(row) {
        return {
          data: row,
          value: row.name,
          result: row.name
        }
      });
    },
    formatItem: function(item) {
      return "<a href='"+item.url+"'><span>"+item.name+"</span></a>"
    },
    minChars: 2,
    resultsClass: "suggestedOptions",
    width: "23em",
    scroll: false,
    selectFirst: false
  }).result(function(e,item){
    location.href = item.url;
  });

  $('#city_compare_search').autocomplete($('#city_compare_search').attr('rel')+"/search_for_compare", {
    dataType: "json",
    parse: function(data) {
      return $.map(data, function(row) {
        return {
          data: row,
          value: row.name,
          result: row.name
        }
      });
    },
    formatItem: function(item) {
      return "<a href='"+item.url+"'><span>"+item.name+"</span></a>"
    },
    minChars: 2,
    resultsClass: "suggestedOptions",
    width: "23em",
    scroll: false,
    selectFirst: false
  }).result(function(e,item){
    location.href = item.url;
  });

  $('#budget_timeline').jcarousel({
    // Configuration goes here 
    scroll: 3,
    start: 100,
    initCallback: budget_timeline_callback,
    buttonNextHTML: null,
    buttonPrevHTML: null
  });   
  
  
  if ($('#holder').length != 0) {single_graph()}
  if ($('#holder_a').length != 0 || $('#holder_b').length != 0) {compare_graph()}
}); 

function budget_timeline_callback(carousel) {
    $('.jcarousel-control a').bind('click', function() {
        carousel.scroll(jQuery.jcarousel.intval(jQuery(this).text()));
        return false;
    });
 
    $('.jcarousel-scroll select').bind('change', function() {
        carousel.options.scroll = jQuery.jcarousel.intval(this.options[this.selectedIndex].value);
        return false;
    });
 
    $('#mycarousel-next').bind('click', function() {
        carousel.next();
        return false;
    });
 
    $('#mycarousel-prev').bind('click', function() {
        carousel.prev();
        return false;
    });
};

var income_txts = ["IMPUESTOS Y TASAS","OTRAS ADMINISTRACIONES","PATRIMONIO","ACTIVOS FINANCIEROS","PRÉSTAMOS"];
var income_txts_short  = ["IMPUESTOS Y TASAS","OTRAS ADMONS.","PATRIMONIO","ACT. FINANCIEROS","PRÉSTAMOS"];
var expense_txts = ["PERSONAL","GASTOS COTIDIANOS","PROYECTOS E INVERSIONES","SUBVENCIONES","OTRAS ENTIDADES","ACTIVOS FINANCIEROS","PRÉSTAMOS"];

function single_graph() {
  var paper = Raphael("holder", 660, 530);
  
  var vi = ingresos;
  var despl = 0;
  for (var i=0; i < vi.length; i++) {
    despl = despl + 260*vi[i]/100
    paper.presus.start_block(0,i*100+i*5,200,100,vi[i],income_txts[i],despl,305,24);
  };
  
  var vg = gastos;
  var despl = 0;
  for (var i=0; i < vg.length; i++) {
    despl = despl + 260*vg[i]/100
    paper.presus.end_block(0,i*70+i*5,200,70,vg[i],expense_txts[i],despl,335,459);
  };
  paper.safari();
};

function compare_graph() {
  var divs = ingrs = gasts = [];
  
  if ($('#holder_a').length != 0) {
    divs = ["holder_a"];
    ingrs = [ingresos];
    gasts = [gastos];
  }
  if ($('#holder_b').length != 0) {
    divs = (divs.length > 0) ? ["holder_a","holder_b"] : ["holder_b"];
    ingrs = (ingrs.length > 0) ? [ingresos, ingresos2] : [ingresos2];
    gasts = (gasts.length > 0) ? [gastos, gastos2] : [gastos2];
  }
  
  for (var x=0; x < divs.length; x++) {
    var paper = Raphael(divs[x], 460, 530);

    var vi = ingrs[x];
    var despl = 0;
    for (var i=0; i < vi.length; i++) {
      despl = despl + 260*vi[i]/100
      paper.presus.start_block(0,i*100+i*5,130,100,vi[i],income_txts_short[i],despl,205,20);
    };

    var vg = gasts[x];
    var despl = 0;
    for (var i=0; i < vg.length; i++) {
      despl = despl + 260*vg[i]/100
      paper.presus.end_block(0,i*70+i*5,130,70,vg[i],expense_txts[i],despl,235,330);
    };
    paper.safari();
  };
};

function format_num(num){
  num += '';
  x = num.split(',');
  x1 = x[0];
  x2 = x.length > 1 ? ',' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + '.' + '$2');
  }
  return x1 + x2;
}