
class CreateLetterCtrl

  constructor: (@$log, @$location,  @UserService) ->
    @$log.debug "constructing CreateLetterController"
    @letter = {}

  createLetter: () ->
    @$log.debug "createLetter()"
    @letter.author = "test"
    alert(@letter.firstLine + @letter.middleLine + @letter.lastLine + @letter.author)

    @UserService.createLetter(@letter)
    .then(
     # alert("then")
      (data) =>
        @$log.debug "Promise returned #{data} Letter"
       # alert("error")
        @letter = data
        @$location.path("/letters")
    ,
      (error) =>
        @$log.error "Unable to create Letter: #{error}"
    )

controllersModule.controller('CreateLetterCtrl', CreateLetterCtrl)