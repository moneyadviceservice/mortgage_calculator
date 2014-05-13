App.directive('ngPie', function() {

  var linker = function(scope, element, attrs, ctrl) {
    var dataForWatch = element.attr('data-incoming') + element.attr('data-outgoing');

    var svg = d3.select(element[0])
        .append('svg')
        .append('g');

    svg.append('g')
        .attr('class', 'slices');
    svg.append('g')
        .attr('class', 'labels');

    var $inner = $(element),
        width = $inner.width() || $inner.parent().width() || 500,
        radius = width / 2;

    svg
        .attr('transform', 'translate(' + width / 2 + ',' + width / 2 + ')');

    svg.append('text')
        .attr('alignment-baseline', 'central')
        .attr('text-anchor', 'middle')
        .attr('font-family', 'sans-serif')
        .attr('font-size', width / 9)
        .text(element.attr('data-pie-text') + '%');

    var canvas = d3.select('svg');
    canvas
        .attr('preserveAspectRatio', 'xMinYMin')
        .attr('viewBox', '0 0 ' + width + ' ' + width);

    var pie = d3.layout.pie()
        .sort(null)
        .value(function (d) {
          return d.value;
        });

    var arc = d3.svg.arc()
        .outerRadius(radius * 1)
        .innerRadius(radius * 0.5);


    var key = function (d) {
      return d.data.label;
    };

    var color = d3.scale.ordinal()
        .domain(['Incoming', 'Outgoing'])
        .range(['#337018', '#38AD26']);

    function getData() {
      var labels = color.domain();
      return labels.map(function (label) {
        return {
          label: label,
          value: parseInt(element.attr('data-' + label))
        };
      });
    }

    function change(data) {

      /* ------- PIE SLICES -------*/
      var slice = svg.select('.slices').selectAll('path.slice')
          .data(pie(data), key);

      slice.enter()
          .insert('path')
          .style('fill', function (d) {
            return color(d.data.label);
          })
          .attr('class', 'slice');

      slice
          .transition().duration(1000)
          .attrTween('d', function (d) {
            this._current = this._current || d;
            var interpolate = d3.interpolate(this._current, d);
            this._current = interpolate(0);
            return function (t) {
              return arc(interpolate(t));
            };
          });

      slice.exit()
          .remove();

    }

    change(getData());

    scope.$watch(function() { return element.attr('data-incoming') + element.attr('data-outgoing'); }, function(newValue) {
      if (newValue != dataForWatch) {
        change(getData());
      }
    });

    scope.$watch(function() { return element.attr('data-pie-text'); }, function(newValue) {
      // update text
    });
  };

  return {
    restrict: 'A',
    controller: function($scope) {},
    link: linker
  };

});
