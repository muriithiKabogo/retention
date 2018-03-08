$( document ).ready(function() {
  // Fix for Bootstrap Datepicker
  $('#builder-widgets').on('afterUpdateRuleValue.queryBuilder', function(e, rule) {
    if (rule.filter.plugin === 'datepicker') {
      rule.$el.find('.rule-value-container input').datepicker('update');
    }
  });

  function getEvent() {
    return $('#selectEvent').val();
  }

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

  function resetBuilder() {
    // $('#query-builder').queryBuilder('reset');
    $('#query-builder').queryBuilder('destroy');
  }

  function makeBuilder(event_poperties) {
    let filters = [];
    for (let field of event_poperties) {
      let data_type = field.data_type;
      let field_type = "string";
      var item = {
        id: field.column_name,
        name: field.column_name,
      }

      if (data_type.indexOf("time") != -1) {
        field_type = "time";
        item["input"] = "text";
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
      data: { sql: sql},
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