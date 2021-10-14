HTMLWidgets.widget({

  name: "treant",

  type: "output",

  factory: function(el, width, height) {

    return {
      renderValue: function(x) {
        
        x.chart.container = '#' + el.id
        
        // create the treant object and return it
        var tre = new Treant(x);
        tre
      }
    };
  }
});
