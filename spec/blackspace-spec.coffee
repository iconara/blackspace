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

  describe 'newline', ->
    it 'moves the (auto inserted) whitespace from a blank line to the next line', ->
      editor = atom.workspace.getActiveTextEditor()
      editor.setText("  hello\n  ")
      atom.commands.dispatch(atom.views.getView(editor), 'blackspace:newline')
      cursor = editor.getLastCursor()
      bufferText = editor.getText()
      bufferText = bufferText.replace(/\n/g, '=').replace(/\s/g, '-')
      expect(bufferText).toBe("--hello==--")
      expect(cursor.getBufferRow()).toBe 2
      expect(cursor.getBufferColumn()).toBe 2

  describe 'newline-above', ->
    it 'moves the (auto inserted) whitespace from a blank line to the line above', ->
      editor = atom.workspace.getActiveTextEditor()
      editor.setText("  hello\n  ")
      atom.commands.dispatch(atom.views.getView(editor), 'blackspace:newline-above')
      cursor = editor.getLastCursor()
      bufferText = editor.getText()
      bufferText = bufferText.replace(/\n/g, '=').replace(/\s/g, '-')
      expect(bufferText).toBe("--hello=--=")
      expect(cursor.getBufferRow()).toBe 1
      expect(cursor.getBufferColumn()).toBe 2
