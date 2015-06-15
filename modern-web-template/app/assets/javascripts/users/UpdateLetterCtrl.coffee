class UpdateLetterCtrl

  constructor: (@$log, @$location, @$routeParams, @UserService) ->
    @$log.debug "constructing UpdateLetterController"
    @letter = {}
    @findLetter()

  updateLetter: () ->
    @$log.debug "updateUser()"
  #  @user.active = true
    @UserService.updateLetter(@$routeParams.firstLine, @$routeParams.middleLine, @$routeParams.lastLine, @letter)
    .then(
      (data) =>
        @$log.debug "Promise returned #{data} Letter"
        @letter = data
        @$location.path("/letters")
    ,
      (error) =>
        @$log.error "Unable to update Letter: #{error}"
    )

  findLetter: () ->
    # route params must be same name as provided in routing url in app.coffee
    firstName = @$routeParams.firstName
    lastName = @$routeParams.lastName
    @$log.debug "findUser route params: #{firstName} #{lastName}"

    @UserService.listUsers()
    .then(
      (data) =>
        @$log.debug "Promise returned #{data.length} Users"

        # find a user with the name of firstName and lastName
        # as filter returns an array, get the first object in it, and return it
        @user = (data.filter (user) -> user.firstName is firstName and user.lastName is lastName)[0]
    ,
      (error) =>
        @$log.error "Unable to get Users: #{error}"
    )

controllersModule.controller('UpdateLetterCtrl', UpdateLetterCtrl)