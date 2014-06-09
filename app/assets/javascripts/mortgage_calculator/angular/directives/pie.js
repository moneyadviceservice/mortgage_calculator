'use strict';

App.directive('ngPie', ['$window', function($window) {

    var linker = function(scope, element, attrs) {
      //Fire event to re-render when browser resizes
      $window.onresize = function() {
        scope.$apply();
      };

      scope.$watch(function() {
        return angular.element($window)[0].innerWidth;
      }, function() {
        scope.render(scope.data);
      });

      scope.$watch('data', function(newVals, oldVals) {
        return scope.render(newVals);
      }, true);

      scope.$watch('riskProportion', function(newVals, oldVals) {
        return scope.updateLabel(newVals);
      }, true);

      var svg = d3.select(element[0])
          .append('svg')
          .append('g');

      var $inner = $(element),
          width = $inner.width() || $inner.parent().width() || 500,
          radius = width / 2;

      svg.append('g')
          .attr('class', 'slices');

      svg
          .attr('transform', 'translate(' + width / 2 + ',' + width / 2 + ')');

      var label = svg.append('text')
          .attr('alignment-baseline', 'central')
          .attr('text-anchor', 'middle')
          .attr('font-family', 'sans-serif')
          .attr('font-size', width / 4);

      var canvas = d3.select('svg');
      canvas
          .attr('preserveAspectRatio', 'xMinYMin')
          .attr('viewBox', '0 0 ' + width + ' ' + width);

      var pie = d3.layout.pie()
          .sort(null)
          .value(function(d) {
            return d.value;
          });

      var arc = d3.svg.arc()
          .outerRadius(radius * 1)
          .innerRadius(radius * 0.8);


      /**
       * Update label
       * @return {[type]}
       */
      scope.updateLabel = function() {
        label.text(parseInt(scope.riskProportion, 10) + '%');
      };

      /**
       * Render the pie
       * @param  {[type]} data
       * @return {[type]}
       */
      scope.render = function(data) {
        var slice = svg.select('.slices').selectAll('path.slice')
            .data(pie(data), function(d) {
              return d.data.label;
            });

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
        data: '=',
        riskProportion: '='
      },
      link: linker
    };

  }
]);
