{WorkspaceView} = require 'atom'
PhpCheckstyle = require '../lib/js-checkstyle'

describe "JS Checkstyle", ->
  beforeEach ->
    atom.workspaceView = new WorkspaceView

  it 'should register the sniffer command', ->
    spyOn(atom.workspaceView, 'command')
    listView = {}
    fixerView = {}
    app = new PhpCheckstyle listView, fixerView
    expect(atom.workspaceView.command).toHaveBeenCalled()
