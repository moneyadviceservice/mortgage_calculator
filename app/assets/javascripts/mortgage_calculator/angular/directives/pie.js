'use strict';

App.directive('ngPie', ['$window',
  function($window) {

    var linker = function(scope, element, attrs) {
      //Fire event to re-render when browser resizes
      $window.onresize = function() {
        scope.$apply();
      };

      //Watch for resize event
      scope.$watch(function() {
        return angular.element($window)[0].innerWidth;
      }, function() {
        scope.render(scope.data);
      });

      //Watch 'data' and run scope.render(newVal) whenever it changes
      //Use true for 'objectEquality' property so comparisons are done on equality and not reference
      scope.$watch('data', function(newVals, oldVals) {
        return scope.render(newVals);
      }, true);

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

      var label = svg.append('text')
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

      /**
       * Render the pie
       * @param  {[type]} data
       * @return {[type]}
       */
      scope.render = function(data) {
        var slice = svg.select('.slices').selectAll('path.slice')
            .data(pie(data), key);

        slice.enter()
            .insert('path')
            .style('fill', function (d) {
              return d.data.colour;
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

      };

    };

    return {
      restrict: 'EA',
      scope: {
        data: '='
      },
      link: linker
    };

  }
]);
