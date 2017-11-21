var main;

main = function() {
  var pubnub;
  
  pubnub = new PubNub({
    subscribeKey: gon.sub_key,
    uuid: gon.uuid
  });

  pubnub.subscribe({
    channels: [gon.channel],
    withPresence: true
  });

  pubnub.hereNow({
    channels: [gon.channel],
    includeUUIDs: true
  }, function(status, response) {
    var occ;
    occ = response['channels'][gon.channel]['occupants'];
    occ.forEach(function(o) {
      $('#online').append('<p id="' + o.uuid + '">' + o.uuid + '</p>');
    });
  });

  pubnub.addListener({
    message: function(msg) {
      $('#messages').append('<p>' + msg['message']['sender'] + ' : ' + msg['message']['message'] + '</p>');
    },

    presence: function(presenceEvent) {;
      var uuid = presenceEvent.uuid;
      if (presenceEvent.action == "join"){
        $('#online').append('<p id="' + uuid + '">' + uuid + '</p>');
      }else if (presenceEvent.action == "leave"){
        $( "#" + uuid ).remove();
        pubnub.unsubscribe({
            channels: [gon.channel]
        });
      }
    }
  });

  $('#message_form').bind('ajax:complete', function(event, xhr, status) {
    $('#message').val('');
  });

};

$(document).on('ready page:load', function() {
  main();
});
