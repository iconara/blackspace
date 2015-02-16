path = require 'path'
fs = require 'fs-plus'
temp = require 'temp'
Blackspace = require '../lib/blackspace'

describe 'Blackspace', ->
  beforeEach ->
    directory = temp.mkdirSync()
    atom.project.setPaths(directory)
    filePath = path.join(directory, 'blackspace.coffee')
    fs.writeFileSync(filePath, '')

    waitsForPromise ->
      atom.workspace.open(filePath)

    waitsForPromise ->
      atom.packages.activatePackage('blackspace')

  it 'moves the (auto inserted) whitespace from a blank line to the next line', ->
    editor = atom.workspace.getActiveTextEditor()
    editor.setText("  hello\n  ")
    atom.commands.dispatch(atom.views.getView(editor), 'blackspace:strip-auto-whitespace')
    bufferText = editor.getText()
    bufferText = bufferText.replace(/\n/g, '=').replace(/\s/g, '-')
    expect(bufferText).toBe("--hello==--")
