draw = function(results) {
      /* */
      var defaultColors = [
        "rgba(74, 160, 209, 0.95)",
        "rgba(63, 124, 179, 0.95)",
        "rgba(73, 91, 115, 0.95)",
        "rgba(50, 63, 79, 0.95)",
        "rgba(11, 36, 68, 0.95)"
      ]
      var colorCount = 0
      var getColor = function() {
        if (colorCount < 5) {
          var color = defaultColors[colorCount];
          colorCount += 1
          return color;
        } else {
          return randomColor()
        }
      } /* */

      info = {}
      for (var i in results) {
        result = results[i]
        if (! (result.machine in info) ) info[result.machine] = [];
        info[result.machine].push(result)
      }
      data = []
      for (var machine in info) {
        row = {
          type: 'bar',
          showInLegend: true,
          name: machine,
          color: getColor(),
          dataPoints: []
        }
        for (var i in info[machine]) {
          result = info[machine][i]
          row.dataPoints.push({
              y: parseInt(result.req),
              label: result.image
          })
        }
        data.push(row)
      }

      var chart = new CanvasJS.Chart("chartContainer", {
        title: {
          text: "Requests per second",
          fontColor: '#f6980b',
          fontFamily: "Montserrat",
          fontSize: 48,
          margin: 15
        },
        animationEnabled: true,
        legend: {
          cursor: "pointer",
          fontFamily: "Montserrat",
          fontSize: 16,
          fontColor: "#171513",
          itemclick: function(e) {
            if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
              e.dataSeries.visible = false;
            } else {
              e.dataSeries.visible = true;
            }
            chart.render();
          }
        },
        axisX: {
          titleFontColor: "#171513",
          titleFontSize: "32",
          titleFontFamily: "Montserrat",
          tickColor: "#f6980b",
          tickThickness: 5,
          tickLength: 8,
          labelFontFamily: "Montserrat",
          labelFontColor: "#171513",
          labelFontSize: 20
        },
        axisY: {
          title: "Req/sec",
          titleFontColor: "#171513",
          titleFontSize: "32",
          titleFontFamily: "Montserrat",
          gridColor: "#ecebe8",
          gridThickness: 1,
          tickColor: "#f6980b",
          tickThickness: 5,
          tickLength: 8,
          labelFontFamily: "Montserrat",
          labelFontColor: "#171513",
          labelFontSize: 16
        },
        toolTip: {
          shared: true,
          borderColor: "#3885c4",
          fontStyle: "normal",
          fontFamily: "Montserrat",
          borderThickness: 5,
          cornerRadius: 5,
          content: function(e) {
            var str = '';
            var total = 0;
            var str3;
            var str2;
            for (var i = 0; i < e.entries.length; i++) {
              var str1 = "<span style= 'color:" + e.entries[i].dataSeries.color + "'> " + e.entries[i].dataSeries.name + "</span>: <strong>" + e.entries[i].dataPoint.y + "</strong> <br/>";
              total = e.entries[i].dataPoint.y + total;
              str = str.concat(str1);
            }
            str2 = "<span style = 'color:#f6980b; '><strong>" + e.entries[0].dataPoint.label + "</strong></span><br/>";
            str3 = "<span style = 'color:#f6980b '>Total: </span><strong>" + total + "</strong><br/>";

            return (str2.concat(str)).concat(str3);
          }

        },
        data: data
      });

      chart.render();
}
