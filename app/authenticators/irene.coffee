`import Ember from 'ember';`
`import Base from 'simple-auth/authenticators/base';`
`import ENV from 'irene/config/environment';`
`import loginBtn from 'irene/utils/login-btn';`
`import Notify from 'ember-notify';`


IreneAuthenticator = Base.extend

  makeRequest: (url, data=null) ->
    Ember.$.ajax
      url: url,
      type: 'POST',
      data: data,
      dataType: 'json',
      contentType: 'application/x-www-form-urlencoded'

  authenticate: (credentials) ->
    loginBtn.setSigningIn()
    makeRequest = @makeRequest
    new Ember.RSVP.Promise (resolve, reject) ->
      data =
        username: credentials.identification
        password: credentials.password

      _resolved = (response, status, error)->
        Ember.run ->
          loginBtn.restoreSignIn()
          if response.success
            resolve Ember.$.extend response
          else
            Notify.error response.errors
            reject response

      _rejected = (xhr, status, error) ->
        Ember.run ->
          loginBtn.restoreSignIn()
          reject xhr.responseJSON || xhr.responseText

      url = ENV['simple-auth']['loginEndpoint']
      makeRequest(url, data).then _resolved, _rejected

  restore: (data) ->
    new Ember.RSVP.Promise (resolve, reject) ->
      if !Ember.isEmpty data.user
        resolve data
      else
        reject()

  invalidate: (data) ->
    localStorage.clear()
    makeRequest = @makeRequest

    new Ember.RSVP.Promise (resolve, reject) ->
      _resolved = (response)->
        Ember.run ->
          resolve Ember.$.extend response
          location.reload()

      _rejected = (xhr, status, error) ->
        Ember.run ->
          reject xhr.responseJSON || xhr.responseText

      url = ENV['simple-auth']['logoutEndpoint']
      makeRequest(url).then _resolved, _rejected

`export default IreneAuthenticator;`
