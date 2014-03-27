{exec} = require 'child_process'
_ = require 'underscore-plus'

# Wrapper class for all shell commands
# Provides shelling out commands so it is performed in one place
class Shell

  # Constructor
  # @param @command The shell command we will execute
  constructor: (@commands) ->

  # Executor
  # Execute the shell command
  # @param callback The callback once the shell command is complete
  execute: (callback) ->
    overall = ''
    for command in @commands
      overall += command.getCommand() + '; '

    console.log "[js-checkstyle]" + overall
    exec overall, callback


# Phpcs command to represent jscs
class CommandPhpcs

  # Constructor
  # @param @path   The path to the file we want to jscs on
  # @param @config The configuration for the command (Such as coding standard)
  constructor: (@path, @config) ->

  # Getter for the command to execute
  getCommand: ->
    command = ''
    command += @config.executablePath + " --standard=" + @config.standard
    command += " -n"  if @config.warnings is false
    command += ' --report=checkstyle '
    command += @path
    return command

  # Given the report, now process into workable data
  # @param err    Any errors occured via exec
  # @param stdout Overall standard output
  # @param stderr Overall standard errors
  process: (error, stdout, stderr) ->
    pattern = /.*line="(.+?)" column="(.+?)" severity="(.+?)" message="(.*)" source.*/g
    errorList = []
    while (line = pattern.exec(stdout)) isnt null
      item = [line[1], _.unescape(line[4])]
      errorList.push item
    return errorList


# Linter command
class CommandLinter

  # Constructor
  # @param @path   The path to the file we want to jscs on
  # @param @config The configuration for the command (Such as coding standard)
  constructor: (@path, @config) ->

  # Getter for the command to execute
  getCommand: ->
    command = @config.executablePath + " -l -d display_errors=On " + @path
    return command

  # Given the report, now process into workable data
  # @param err    Any errors occured via exec
  # @param stdout Overall standard output
  # @param stderr Overall standard errors
  process: (error, stdout, stderr) ->
    pattern = /(.*) on line (.*)/g
    errorList = []
    while (line = pattern.exec(stdout)) isnt null
      item = [line[2], line[1]]
      errorList.push item
    return errorList


# Mess Detection command (utilising jsmd)
class CommandMessDetector

  # Constructor
  # @param @path   The path to the file we want to jsmd on
  # @param @config The configuration for the command (Such as coding standard)
  constructor: (@path, @config) ->

  # Getter for the command to execute
  getCommand: ->
    command = @config.executablePath + ' ' + @path + ' text ' + @config.ruleSets
    return command

  # Given the report, now process into workable data
  # @param err    Any errors occured via exec
  # @param stdout Overall standard output
  # @param stderr Overall standard errors
  process: (error, stdout, stderr) ->
    pattern = /.*:(\d+)[ \t]+(.*)/g
    errorList = []
    while (line = pattern.exec(stdout)) isnt null
      item = [line[1], _.unescape(line[2])]
      errorList.push item
    return errorList


# JS CS Fixer command
class CommandPhpcsFixer

  # Constructor
  # @param @path   The path to the file we want to execute js-cs-fixer on
  # @param @config The configuration for the command such as which level
  constructor: (@path, @config) ->

  # Formulate the js-cs-fixer command
  getCommand: ->
    command = ''
    command += @config.executablePath
    command += ' --level=' + @config.level
    command += ' --verbose'
    command += ' fix '
    command += @path
    return command

  # Process the data out of js-cs-fixer
  # @param err    Any errors occured via exec
  # @param stdout Overall standard output
  # @param stderr Overall standard errors
  process: (error, stdout, stderr) ->
    pattern = /.*(.+?)\) (.*) (\(.*\))/g
    errorList = []
    while (line = pattern.exec(stdout)) isnt null
      item = [0, "Fixed: " + line[3]]
      errorList.push item
    return errorList

module.exports = {Shell, CommandPhpcs, CommandLinter, CommandPhpcsFixer, CommandMessDetector}
