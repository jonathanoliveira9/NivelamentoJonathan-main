$(document).ready(function(){
  $('#warning-notication').hide()

  $('#email_search').autocomplete({
    source: function (request, response) {
      $.ajax({
        url: "/autocomplete/students.json", 
        dataType: 'json',
        data: { term: request.term,
                grade_id: $('#grade_id').val()
              },
        success: function(data) {
          response(data);
        }
      });
    },
    minLength: 5,
    select: function(event, ui) {
      if (ui.item.avaliable) {
        $('#student_id').val(ui.item.id)
        $('#warning-notication').hide()
      } else {
        $('#warning-notication').show()
        $('#email_search').val('')
      }
    },
    search: function(event, ui){
      $('.spinner-border').show();
    },
    response: function(event, ui){
      $('.spinner-border').hide()
    }
  });  
})
