commands = require '../lib/commands'

describe "CommandPhpcs", ->
  it 'should build the basic command with the config options passed', ->
    options = {
      'executablePath': '/bin/jscs',
      'standard': 'PSR2',
      'warnings': true
    }
    jscs = new commands.CommandPhpcs('/path/to/file', options)
    command = jscs.getCommand()

    expect(command).toBe "/bin/jscs --standard=PSR2 --report=checkstyle /path/to/file"

  it 'should build the command with the -n flag if warnings should be turned off', ->
    options = {
      'executablePath': '/bin/jscs',
      'standard': 'PSR2',
      'warnings': false
    }
    jscs = new commands.CommandPhpcs('/path/to/file', options)
    command = jscs.getCommand()
    expect(command).toBe "/bin/jscs --standard=PSR2 -n --report=checkstyle /path/to/file"

  it 'should parse the report and if there are errors, make an array [line, message]', ->
    jscs = new commands.CommandPhpcs('/path/to/file', {})

    stdout = """
    <?xml version="1.0" encoding="UTF-8"?>
<checkstyle version="1.5.2">
<file name="/path/to/a/file">
<error line="160" column="78" severity="error" message="Expected 1 blank line at end of file; 4 found" source="PSR2.Files.EndFileNewline.TooMany"/>
</file>
</checkstyle>
    """

    report = jscs.process('', stdout, '')
    expect(report).toEqual([['160', 'Expected 1 blank line at end of file; 4 found']])

  it 'should produce an empty report if no errors are found', ->
    jscs = new commands.CommandPhpcs('/path/to/file', {})

    stdout = """
    <?xml version="1.0" encoding="UTF-8"?>
<checkstyle version="1.5.2">
</checkstyle>
    """

    report = jscs.process('', stdout, '')
    expect(report).toEqual([])

  it 'should unescape html errors into text', ->
    jscs = new commands.CommandPhpcs('/path/to/file', {})

    stdout = """
    <?xml version="1.0" encoding="UTF-8"?>
<checkstyle version="1.5.2">
<file name="/path/to/a/file">
<error line="160" column="78" severity="error" message="Class name &quot;Class_Name&quot; is not in camel caps format" source="PSR2.Files.EndFileNewline.TooMany"/>
</file>
</checkstyle>
    """

    report = jscs.process('', stdout, '')
    expect(report).toEqual([['160', 'Class name "Class_Name" is not in camel caps format']])


describe "CommandPhpcsFixer", ->
  it 'should build the basic command with the config options passed', ->
    options = {
      'executablePath': '/bin/js-cs-fixer',
      'level': 'all'
    }
    fixer = new commands.CommandPhpcsFixer('/path/to/file', options)
    command = fixer.getCommand()

    expect(command).toBe "/bin/js-cs-fixer --level=all --verbose fix /path/to/file"

  it 'should parse the report and if there are errors, make an array [fixNumber!, message]', ->
    fixer = new commands.CommandPhpcsFixer('/path/to/file', {})

    stdout = """
1) /home/user/git/path/to/file (braces, something, else)
    """

    report = fixer.process('', stdout, '')
    expect(report).toEqual([[0, 'Fixed: (braces, something, else)']])


describe "CommandLinter", ->
  it 'should build the basic command with display_errors so we can capture output', ->
    options = {
      'executablePath': '/bin/js'
    }
    linter = new commands.CommandLinter('/path/to/file', options)
    command = linter.getCommand()

    expect(command).toBe "/bin/js -l -d display_errors=On /path/to/file"

  it "should parse the report and if there is a parse error, return array with error inside", ->
    linter = new commands.CommandLinter('/path/to/file', {})

    stdout = """
Parse error: parse error in a/random/file/somewhere.js on line 76
Errors parsing a/random/file/somewhere.js

    """

    report = linter.process('', stdout, '')
    expect(report).toEqual([['76', "Parse error: parse error in a/random/file/somewhere.js"]])


describe "CommandMessDetector", ->
  it 'should build the basic command with display_errors so we can capture output', ->
    options = {
      'executablePath': '/bin/jsmd',
      'ruleSets': 'a,b,c,d'
    }
    messDetector = new commands.CommandMessDetector('/path/to/file', options)
    command = messDetector.getCommand()

    expect(command).toBe "/bin/jsmd /path/to/file text a,b,c,d"

  it "should parse the report and if there are any errors, return array with the errors inside", ->
    messDetector = new commands.CommandMessDetector('/path/to/file', {})

    stdout = """
/path/to/file:87	Avoid unused local variables such as '$unused'.
    """

    report = messDetector.process('', stdout, '')
    expect(report).toEqual([['87', "Avoid unused local variables such as '$unused'."]])

  it "should unescape html errors into text", ->
    messDetector = new commands.CommandMessDetector('/path/to/file', {})

    stdout = """
/path/to/file:87	Avoid unused local variables such as &quot;$unused&quot;.
    """

    report = messDetector.process('', stdout, '')
    expect(report).toEqual([['87', 'Avoid unused local variables such as "$unused".']])
