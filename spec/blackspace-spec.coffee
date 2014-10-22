path = require 'path'
fs = require 'fs-plus'
{WorkspaceView} = require 'atom'
temp = require 'temp'
Blackspace = require '../lib/blackspace'

describe 'Blackspace', ->
  editor = null
  buffer = null

  beforeEach ->
    directory = temp.mkdirSync()
    atom.project.setPaths(directory)
    atom.workspaceView = new WorkspaceView()
    atom.workspace = atom.workspaceView.model
    filePath = path.join(directory, 'blackspace.coffee')
    fs.writeFileSync(filePath, '')

    waitsForPromise ->
      atom.workspace.open(filePath).then (o) -> editor = o

    waitsForPromise ->
      atom.packages.activatePackage('blackspace')

  it 'moves the (auto inserted) whitespace from a blank line to the next line', ->
    editor.setText("  hello\n  ")
    atom.workspaceView.getActiveView().trigger('blackspace:strip-auto-whitespace')
    bufferText = editor.getText()
    bufferText = bufferText.replace(/\n/g, '=').replace(/\s/g, '-')
    expect(bufferText).toBe("--hello==--")
