StartupNews.Votes = {} if StartupNews.Votes is undefined

StartupNews.Votes =->
  $ ->
    $voteUp   = $('a.vote-up')
    $voteDown = $('a.vote-down')

    $flash = $(".flash")
    $flash = $('<div>', { class: 'flash report-flash' }) unless $flash?
    $('body').append($flash)

    $voteUp.bind 'ajax:success', (evt, data, status, xhr)->
      console.log('chamou voteUp success')
      $flash.hide()
      $wrapper = $('<div>', { class: 'wrapper success' })
      message = data.success
      $message = $('<div>', { class: 'alerts-error', text: message })
      $wrapper.html($message)
      $flash.html($wrapper)
      StartupNews.Common.flash()

    $voteUp.bind 'ajax:error', (evt, data, status, xhr)->
      console.log('chamou voteUp error')
      $flash.hide()
      $wrapper = $('<div>', { class: 'wrapper alerts-error' })
      message = $.parseJSON(data.responseText).error
      $message = $('<div>', { class: 'alerts-error', text: message })
      $wrapper.html($message)
      $flash.html($wrapper)
      StartupNews.Common.flash()

    $voteDown.bind 'ajax:success', (evt, data, status, xhr)->
      console.log('chamou voteDown success')
      $flash.hide()
      $wrapper = $('<div>', { class: 'wrapper success' })
      message = data.success
      $message = $('<div>', { class: 'alerts-error', text: message })
      $wrapper.html($message)
      $flash.html($wrapper)
      StartupNews.Common.flash()

    $voteDown.bind 'ajax:error', (evt, data, status, xhr)->
      console.log('chamou voteDown error')
      $flash.hide()
      $wrapper = $('<div>', { class: 'wrapper alerts-error' })
      message = $.parseJSON(data.responseText).error
      $message = $('<div>', { class: 'alerts-error', text: message })
      $wrapper.html($message)
      $flash.html($wrapper)
      StartupNews.Common.flash()