`import Ember from 'ember'`
`import ENV from 'irene/config/environment';`


InvitationAcceptComponent = Ember.Component.extend

  invitation: null

  actions:
    acceptInvite: ->
      that = @
      data =
        invitationUuid: @get "invitation.id"
        username: @get "username"
        password: @get "password"
      @get("ajax").post ENV.endpoints.signup, data: data
      .then (data)->
        # FIXME: This should be this.transitionTo`
        that.get("notify").success "User got created sucessfully", ENV.notifications
        setTimeout ->
          window.location.href = "/"
        ,
          3 * 1000
      .catch (error) ->
        that.get("notify").error error.payload.message, ENV.notifications
        for error in error.errors
          that.get("notify").error error.detail?.message

`export default InvitationAcceptComponent`
