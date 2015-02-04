`import Ember from 'ember';`
`import Notify from 'ember-notify';`
`import CONSTANTS from '../utils/constants';`
`import SocketMixin from '../mixins/socket';`

IndexController = Ember.ArrayController.extend SocketMixin,

  needs: ['application']

  storeURL: null

  ratio: null

  model:( ->
    @get "controllers.application.currentUser.projects"
  ).property "controllers.application.currentUser"

  sortProperties: ["lastFile.updatedOn:desc"]
  sortedModel: Ember.computed.sort('model', 'sortProperties')

  actions:

    submitURL: ->
      storeURL = @get "storeURL"
      if !CONSTANTS.STORE_URL_RE.test storeURL
        return Notify.error "Please enter a valid URL"
      data =
        storeURL: storeURL
      applicationAdapter = @store.adapterFor 'application'
      host = applicationAdapter.get 'host'
      namespace = applicationAdapter.get 'namespace'
      postUrl = [host, namespace, 'store_url'].join '/'
      that = @
      Ember.$.post postUrl, data
        .then ->
          that.set "storeURL", null
          Notify.success "Hang in there while we process your URL"
        .fail (xhr, message, status) ->
          if xhr.status is 401
            Notify.error xhr.responseJSON.message
          else
            Notify.error "A network error occured! Please try again later"


`export default IndexController;`