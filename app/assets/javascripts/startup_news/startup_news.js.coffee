window.StartupNews =

  Common:
    init: ->
      @flash()
      @bindVotes()

    bindVotes: ->
      flash = $(".flash")
      if flash.length == 0
        flash = $('<div>', { class: 'flash report-flash' })
        $('body').append(flash)

      $(".remote-vote").bind 'ajax:success', (evt, data, status, xhr) ->
        $(this).parent().parent().find("button").removeClass("active")
        $(this).parent().addClass("active")
        $(this).parent().addClass("voted")
        flash.hide()
        wrapper = $('<div>', { class: 'wrapper success' })
        message = "Votado com sucesso!"
        message = $('<div>', { class: 'alerts-error', text: message })
        wrapper.html(message)
        flash.html(wrapper)
        StartupNews.Common.flash()

      $(".remote-vote").bind 'ajax:error', (evt, data, status, xhr) ->
        $(this).parent().parent().find("button").removeClass("active")
        $(this).parent().addClass("active")
        flash.hide()
        wrapper = $('<div>', { class: 'wrapper alerts-error' })
        message = data.responseJSON.errors
        message = $('<div>', { class: 'alerts-error', text: message })
        wrapper.html(message)
        flash.html(wrapper)
        StartupNews.Common.flash()

    flash: ->
      setTimeout( ->
        $('.flash').slideDown('slow')
      , 100)
      if $('.flash').length > 0
        setTimeout( ->
          $('.flash').slideUp('slow')
        , 4000)
      $('.flash').click ->
        $('.flash').slideUp()

jQuery ->
  StartupNews.Common.init()
