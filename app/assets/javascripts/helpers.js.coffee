App.H =
  longDate: (date) ->
    date = moment(date)
    "#{date.calendar()} - #{date.format('DD.MM.YYYY')}"
  timeAgo: (date) ->
    moment(date).fromNow()
