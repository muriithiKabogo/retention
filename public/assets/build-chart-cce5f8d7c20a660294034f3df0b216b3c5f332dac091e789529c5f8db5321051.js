$( document ).ready(function() {

  function buildChart(chartId, eventName) {
    var chartObj = {
      id: chartId, 
      event: eventName,
      data: null,
    };

    var initChart = function(_chartObj) {
      var chartData = [];
      var chartLabels = [];

      // prepare data for chart
      $.each(_chartObj.data, function(index, val) {
        chartData.push(val.count);
        chartLabels.push(val.date);
      });

      var config = {
        type: 'line',
        data: {
          labels: chartLabels,
          datasets: [{
            label: chartObj.event,
            fill: false,
            backgroundColor: 'rgb(54, 162, 235)',
            borderColor: 'rgb(54, 162, 235)',
            data: chartData,
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          title: {
            display: true,
            text: ''
          },
          tooltips: {
            mode: 'index',
            intersect: true,
          },
          hover: {
            mode: 'nearest',
            intersect: true
          },
          scales: {
            xAxes: [{
              display: true,
              scaleLabel: {
                display: true,
                labelString: 'Date'
            }],
            yAxes: [{
              display: true,
              scaleLabel: {
                display: true,
                labelString: 'Times'
              },
              ticks: {
                beginAtZero: true,
                userCallback: function(label, index, labels) {
                  if (Math.floor(label) === label) return label;
                },
              }
            }]
          }
        }
      };
      var ctx = document.getElementById(chartObj.id).getContext('2d');
      return new Chart(ctx, config);
    }

    // request data
    $.ajax({
      type: 'post',
      data: { event_name: chartObj.event},
      url: '/projects/get_data_for_chart',
      beforeSend: function (xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      success:function(data) {
        chartObj.data = data;
        initChart(chartObj);
      },
      error:function(xhr, ajaxOptions, thrownError) {
        alert('Something went worng, Please try Again.');
      }
    });
  }

  $('.chart-graph').each(function() {
    var chartId = $(this).data('chart-id');
    var eventName = $(this).data('event');
    buildChart(chartId, eventName);
  })
});
