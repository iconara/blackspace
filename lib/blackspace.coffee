module.exports =
  activate: (state) ->
    @blackspace = new Blackspace(atom)

class Blackspace
  constructor: (atom) ->
    @atom = atom
    @atom.commands.add 'atom-text-editor',
      'blackspace:strip-auto-whitespace': (e) => @strip(e)

  strip: (e) ->
    editor = @atom.workspace.getActiveTextEditor()
    buffer = editor.getBuffer()
    cursor = editor.getLastCursor()
    currentRow = cursor.getBufferRow()
    if buffer.isRowBlank(currentRow)
      editor.transact ->
        rowRange = buffer.rangeForRow(currentRow, false)
        rowText = editor.getTextInBufferRange(rowRange)
        editor.setTextInBufferRange(rowRange, '')
        editor.insertText("\n" + rowText, {autoIndent: false})
    else
      e.abortKeyBinding()
