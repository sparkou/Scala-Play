
class LetterCtrl

  constructor: (@$log, @UserService) ->
    @$log.debug "constructing LetterController"
    @letters = []
    @getAllLetters()

  getAllLetters: () ->
    @$log.debug "getAllLetters()"

    @UserService.listLetters()
    .then(
      (data) =>
        @$log.debug "Promise returned #{data.length} Letters"
        @letters = data
    ,
      (error) =>
        @$log.error "Unable to get Letters: #{error}"
    )

controllersModule.controller('LetterCtrl', LetterCtrl)