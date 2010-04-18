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
  
});