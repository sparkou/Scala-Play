
class UserService

    @headers = {'Accept': 'application/json', 'Content-Type': 'application/json'}
    @defaultConfig = { headers: @headers }

    constructor: (@$log, @$http, @$q) ->
        @$log.debug "constructing UserService"

    listUsers: () ->
        @$log.debug "listUsers()"
        deferred = @$q.defer()

        @$http.get("/users")
        .success((data, status, headers) =>
                @$log.info("Successfully listed Users - status #{status}")
                deferred.resolve(data)
            )
        .error((data, status, headers) =>
                @$log.error("Failed to list Users - status #{status}")
                deferred.reject(data)
            )
        deferred.promise

    createUser: (user) ->
        @$log.debug "createUser #{angular.toJson(user, true)}"
        deferred = @$q.defer()
        alert(user)
        @$http.post('/user', user)
        .success((data, status, headers) =>
                @$log.info("Successfully created User - status #{status}")
                alert(data)
                deferred.resolve(data)
            )
        .error((data, status, headers) =>
                @$log.error("Failed to create user - status #{status}")
                deferred.reject(data)
            )
        deferred.promise

    updateUser: (firstName, lastName, user) ->
        @$log.debug "updateUser #{angular.toJson(user, true)}"
        deferred = @$q.defer()

        @$http.put("/user/#{firstName}/#{lastName}", user)
        .success((data, status, headers) =>
                @$log.info("Successfully updated User - status #{status}")
                deferred.resolve(data)
              )
        .error((data, status, header) =>
                @$log.error("Failed to update user - status #{status}")
                deferred.reject(data)
              )
        deferred.promise

    listLetters: () ->
        @$log.debug "listLetters()"
        deferred = @$q.defer()

        @$http.get("/letters")
        .success((data, status, headers) =>
          @$log.info("Successfully listed Letters - status #{status}")
          alert(data)
          deferred.resolve(data)
        )
        .error((data, status, headers) =>
          @$log.error("Failed to list Letters - status #{status}")
          deferred.reject(data)
        )
        deferred.promise

    createLetter: (letter) ->
      @$log.debug "createLetter #{angular.toJson(letter, true)}"
      deferred = @$q.defer()
     # alert(letter)
      @$http.post('/letter', letter)
      .success((data, status, headers) =>
        @$log.info("Successfully created Letter - status #{status}")
        alert(data)
        deferred.resolve(data)
      )
      .error((data, status, headers) =>
        @$log.error("Failed to create letter - status #{status}")
        deferred.reject(data)
      )
     # alert("I am done")
      deferred.promise


servicesModule.service('UserService', UserService)