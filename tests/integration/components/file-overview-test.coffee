`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'file-overview', 'Integration | Component | file overview', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{file-overview}}"""

  assert.equal @$().text().trim(), '02/06/16 14:23Package: Version: Vulnerabilities: High: Medium: Low: None: Unknown:'
