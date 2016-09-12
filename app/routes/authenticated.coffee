`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

AuthenticatedRoute = Ember.Route.extend AuthenticatedRouteMixin,
  breadCrumb: null

`export default AuthenticatedRoute`
