<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>

<style> /* set the CSS */

body { font: 12px Arial;}

path {
  stroke: navy;
  stroke-width: 2;
  fill: none;
}

.axis path,
.axis line {
  fill: none;
  stroke: grey;
  stroke-width: 1;
  shape-rendering: crispEdges;
}

</style>









  <script src="https://d3js.org/d3.v3.min.js"></script>
  <script>
  var dane = '{{dane}}';
  var dane = dane.replace(/&quot;/g, '\"');
  var dane =JSON.parse(dane);
  </script>


  <script>


  function render(dane, fundusz){

    var margin = {top: 30, right: 20, bottom: 30, left: 50},
      width = 600 - margin.left - margin.right,
      height = 270 - margin.top - margin.bottom;

      var parseDate = d3.time.format("%Y-%m-%d").parse;

      var x = d3.time.scale().range([0, width]);
      var y = d3.scale.linear().range([height, 0]);

      var xAxis = d3.svg.axis().scale(x)
      .orient("bottom").ticks(5);

      var yAxis = d3.svg.axis().scale(y)
      .orient("left").ticks(5);



      var valueline = d3.svg.line()
      .x(function(d) { return x(d['Data wyceny']); })
      .y(function(d) { return y(d[fundusz]); });



      var svg = d3.select("body")
      .append("svg")
          .attr("width", width + margin.left + margin.right)
          .attr("height", height + margin.top + margin.bottom)
      .append("g")
          .attr("transform",
                "translate(" + margin.left + "," + margin.top + ")");


    var data = [];


    for (var i in dane) {data.push(dane[i])};


      data.forEach(function(d) {
        d['Data wyceny'] = parseDate(d['Data wyceny']);
        d['Allianz Akcji'] = +d[fundusz];
      });



      x.domain(d3.extent(data, function(d) { return d['Data wyceny']; }));
      y.domain(d3.extent(data, function(d) { return d[fundusz]; }));


      svg.append("path")

          .attr("class", "line")


          .attr("d", valueline(data));


          svg.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .call(xAxis);


          svg.append("g")
          .attr("class", "y axis")
          .call(yAxis);




  };

  render(dane, 'Allianz Akcji');














</script>

</body>
</html>
