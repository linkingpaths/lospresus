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
  
  single_graph();
  compare_graph();
  
});

function single_graph() {
  var paper = Raphael("holder", 660, 530);
  
  var ingr   = ["IMPUESTOS Y TASAS","OTRAS ADMINISTRACIONES","PATRIMONIO","ACTIVOS FINANCIEROS","PRÉSTAMOS"];
  var colors = ["#031e1f","#031e1f","#031e1f","#031e1f","#031e1f"]
  var vi = ingresos;
  var despl = 0;
  for (var i=0; i < vi.length; i++) {
    despl = despl + 260*vi[i]/100
    paper.presus.start_block(0,i*100+i*5,200,100,vi[i],ingr[i],despl,colors[i],305,24);
  };
  
  var ingr   = ["PERSONAL","GASTOS COTIDIANOS","PROYECTOS E INVERSIONES","SUBVENCIONES","OTRAS ENTIDADES","ACTIVOS FINANCIEROS","PRÉSTAMOS"];
  var colors = ["#031e1f","#031e1f","#031e1f","#031e1f","#031e1f","#031e1f","#031e1f"]
  var vg = gastos;
  var despl = 0;
  for (var i=0; i < vg.length; i++) {
    despl = despl + 260*vg[i]/100
    paper.presus.end_block(0,i*70+i*5,200,70,vg[i],ingr[i],despl,colors[i],335,459);
  };
  paper.safari();
};

function compare_graph() {
  var paper = Raphael("holder2", 460, 530);
  
  var ingr   = ["IMPUESTOS Y TASAS","OTRAS ADMONS.","PATRIMONIO","ACT. FINANCIEROS","PRÉSTAMOS"];
  var colors = ["#031e1f","#031e1f","#031e1f","#031e1f","#031e1f"]
  var vi = ingresos;
  var despl = 0;
  for (var i=0; i < vi.length; i++) {
    despl = despl + 260*vi[i]/100
    paper.presus.start_block(0,i*100+i*5,130,100,vi[i],ingr[i],despl,colors[i],205,20);
  };

  var ingr   = ["PERSONAL","GASTOS COTIDIANOS","PROYECTOS E INVERSIONES","SUBVENCIONES","OTRAS ENTIDADES","ACTIVOS FINANCIEROS","PRÉSTAMOS"];
  var colors = ["#031e1f","#031e1f","#031e1f","#031e1f","#031e1f","#031e1f","#031e1f"]
  var vg = gastos;
  var despl = 0;
  for (var i=0; i < vg.length; i++) {
    despl = despl + 260*vg[i]/100
    paper.presus.end_block(0,i*70+i*5,130,70,vg[i],ingr[i],despl,colors[i],235,330);
  };
  ///////////////////////////////////////////////////////////////////////////////////
  paper = Raphael("holder3", 460, 530);
  var ingr   = ["PROYECTOS E INVER.","OTRAS ADMONS.","PATRIMONIO","ACT. FINANCIEROS","PRÉSTAMOS"];
  var colors = ["#031e1f","#031e1f","#031e1f","#031e1f","#031e1f"]
  var vi = ingresos2;
  var despl = 0;
  for (var i=0; i < vi.length; i++) {
    despl = despl + 260*vi[i]/100
    paper.presus.start_block(0,i*100+i*5,130,100,vi[i],ingr[i],despl,colors[i],205,20);
  };

  var ingr   = ["PERSONAL","GASTOS COTIDIANOS","PROYECTOS E INVERSIONES","SUBVENCIONES","OTRAS ENTIDADES","ACTIVOS FINANCIEROS","PRÉSTAMOS"];
  var colors = ["#031e1f","#031e1f","#031e1f","#031e1f","#031e1f","#031e1f","#031e1f"]
  var vg = gastos2;
  var despl = 0;
  for (var i=0; i < vg.length; i++) {
    despl = despl + 260*vg[i]/100
    paper.presus.end_block(0,i*70+i*5,130,70,vg[i],ingr[i],despl,colors[i],235,330);
  };
  paper.safari();
};