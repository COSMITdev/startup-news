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
        $(this).parent().parent().find("span").removeClass("active")
        $(this).find("button").addClass("active")
        $(this).find("span").addClass("active")
        flash.hide()
        wrapper = $('<div>', { class: 'wrapper success' })
        message = "Votado com sucesso!"
        message = $('<div>', { class: 'alerts-error', text: message })
        wrapper.html(message)
        flash.html(wrapper)
        StartupNews.Common.flash()

      $(".remote-vote").bind 'ajax:error', (evt, data, status, xhr) ->
        $(this).parent().parent().find("button").removeClass("active")
        $(this).parent().parent().find("span").removeClass("active")
        if data.status == 401
          message = data.responseText
        else
          $(this).find("button").addClass("active")
          $(this).find("span").addClass("active")
          message = data.responseJSON.errors
        flash.hide()
        wrapper = $('<div>', { class: 'wrapper alerts-error' })
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
