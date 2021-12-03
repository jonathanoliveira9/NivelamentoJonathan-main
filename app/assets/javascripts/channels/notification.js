App.notifications = App.cable.subscriptions.create('NotificationChannel', {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    $('#follow-up-class').html('')
    $('#follow-up-class').html(data)
  }
})