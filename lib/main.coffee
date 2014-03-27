PhpCheckstyle = require './js-checkstyle'
PhpCheckstyleView = require './js-checkstyle-view'
PhpCsFixerView = require './js-cs-fixer-view'
PhpCheckstyleGutterView = require './js-checkstyle-gutter-view'
PhpCheckstyleStatusBarView = require './js-checkstyle-statusbar-view'

module.exports =

  configDefaults:
    jscsExecutablePath: '/usr/bin/jscs'
    jscsStandard: 'PSR2'
    jscsDisplayWarnings: false
    jscsFixerExecutablePath: '/usr/bin/js-cs-fixer'
    jscsFixerLevel: 'all'
    jsPath: '/usr/bin/js'
    jsmdExecutablePath: '/usr/bin/jsmd'
    jsmdRuleSets: 'codesize,cleancode,controversial,naming,unusedcode'
    renderGutterMarks: true
    renderStatusBar: true
    renderListView: true
    shouldExecutePhpcs: true
    shouldExecutePhpmd: true
    shouldExecuteLinter: true
    shouldExecuteOnSave: true

  # Activate the plugin
  activate: ->
    listView = new PhpCheckstyleView()
    fixerView = new PhpCsFixerView()
    gutterView = new PhpCheckstyleGutterView()
    statusbarView = new PhpCheckstyleStatusBarView()

    app = new PhpCheckstyle listView, fixerView, gutterView, statusbarView
