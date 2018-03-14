$( document ).ready(function() {

  // Fix for Bootstrap Datepicker
  $('#builder-widgets').on('afterUpdateRuleValue.queryBuilder', function(e, rule) {
    if (rule.filter.plugin === 'datepicker') {
      rule.$el.find('.rule-value-container input').datepicker('update');
    }
  });


  // get event name
  function getEvent() {
    return $('#selectEvent').val();
  }

  // select event
  function selectEvent() {
    var event = getEvent();
    if (event != undefined && event != '') {
      $.ajax({
        type: 'post',
        data: { event_name: event},
        url: '/projects/get_event_poperties',
        beforeSend: function (xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        success:function(event_poperties) {
          resetBuilder();
          makeBuilder(event_poperties);
        },
        error:function(xhr, ajaxOptions, thrownError) {
          alert('Something went worng, Please try Again.');
        }
      });
    }
  }

  $('#selectEvent').on('change', function(e) {
    selectEvent();
  });

  // recreate builder when user changes event
  function resetBuilder() {
    // $('#query-builder').queryBuilder('reset');
    $('#query-builder').queryBuilder('destroy');
  }

  // init jquery builder from events and event properties
  function makeBuilder(event_poperties) {
    var filters = [];
    for (var i=0; i < event_poperties.length; i++) {
      var field = event_poperties[i];
      var data_type = field.data_type;
      var field_type = "string";
      var item = {
        id: field.column_name,
        name: field.column_name,
      }

      if (data_type.indexOf("time") != -1) {
        field_type = "time";
        // item["input"] = "date";
        item["plugin"] = 'datepicker',
        item["plugin_config"] = {
          format: 'yyyy/mm/dd',
          todayBtn: 'linked',
          todayHighlight: true,
          autoclose: true
        };
      } else if (data_type.indexOf("date") != -1) {
        field_type = "date";
        item["plugin"] = 'datepicker',
        item["plugin_config"] = {
          format: 'yyyy/mm/dd',
          todayBtn: 'linked',
          todayHighlight: true,
          autoclose: true
        };
      } else if (data_type.indexOf("int") != -1) {
        field_type = "integer";
        item["input"] = "number";
      } else if (data_type.indexOf("double") != -1 || data_type.indexOf("float") != -1) {
        field_type = "double";
        item["input"] = "number";
      }
      item["type"] =  field_type;
      filters.push(item);
    }
    // console.log(filters);
    $('#query-builder').queryBuilder({
      filters: filters,
    });
  }

  // execute search
  $('button.search-sql').click(function(e) {
    var sql = 'select * from ' + getEvent();
    var rules = $('#query-builder').queryBuilder('getRules');
    if (rules != null) {
      var result = $('#query-builder').queryBuilder('getSQL', false);
      // console.log(result.sql);
      sql += ' where ' + result.sql;
    }
    // console.log(sql);
    $('button.search-sql').prop('disabled', true);
    $.ajax({
      type: 'post',
      data: { sql: sql, event_name: getEvent()},
      url: '/projects/search',
      beforeSend: function (xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      success:function(data_html) {
        $('#search-result').html(data_html);
        $('button.search-sql').prop('disabled', false);
      },
      error:function(xhr, ajaxOptions, thrownError) {
        $('button.search-sql').prop('disabled', false);
        alert('Something went worng, Please try Again.');
      }
    });

  });

  selectEvent();
});