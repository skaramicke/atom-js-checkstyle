{$$, Point, SelectListView} = require 'atom'
PhpCheckstyleBaseView = require './js-checkstyle-base-view'

# View for the sniffer commands
class PhpCheckstyleView extends PhpCheckstyleBaseView

  @checkstyleList = []

  # Initialise the view and register the sniffer command
  initialize: () ->
    super
    @addClass('js-checkstyle-error-view overlay from-top')

  # Get the error list from the command and display the result
  #
  # reportList The list of errors from the reports
  process: (reportList) ->
    return unless atom.config.get "js-checkstyle.renderListView"
    editorView = atom.workspaceView.getActiveView()
    @checkstyleList = []
    fileList = []
    for row in reportList
      line = row[0]
      message = '(' + line + ') ' + row[1]
      checkstyleError = {line, message}
      fileList.push(checkstyleError)

    @checkstyleList[editorView.id] = fileList
    @setItems(fileList)

    if fileList.length == 0
      console.log "[js-checkstyle] File is clean"
      return

    @storeFocusedElement()
    atom.workspaceView.append(this)
    @focusFilterEditor()

module.exports = PhpCheckstyleView
