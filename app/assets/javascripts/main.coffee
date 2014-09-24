$ ->
  validate_username = () ->
    username = $('#username').val();
    if (username.length == 0 || !username.trim())
      $('#username_group').addClass('has-error')
      return false
    else
      $('#username_group').removeClass('has-error')
      return true

  $('#username').on 'change', (e) ->
    validate_username()

  $('#lookup_button').on 'click', (e) ->
    if validate_username()
      $.ajax({
        url: "/api/github_users/#{ $('#username').val()}"
        }).done((data) ->
          result = ''
          $.map(data, (prop, key) ->
            result = "#{result} #{key}:#{prop}"
          )
          $('#result').html(result)
        )
