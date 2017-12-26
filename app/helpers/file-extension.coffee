`import Ember from 'ember'`

fileExtension = (params) ->
  if !params[0]
    return null

  file_parts = params[0].split('.')
  if file_parts.length <= 1
    return 'unk'
  file_parts.pop()

FileExtensionHelper = Ember.Helper.helper fileExtension

`export { fileExtension }`

`export default FileExtensionHelper`
