module.exports =
  activate: (state) ->
    @blackspace = new Blackspace(atom)

class Blackspace
  constructor: (atom) ->
    @atom = atom
    @atom.commands.add 'atom-text-editor',
      'blackspace:newline': (e) => @newline(e)
      'blackspace:newline-above': (e) => @newline(e, {above: true})

  newline: (e, {above}={}) ->
    editor = @atom.workspace.getActiveTextEditor()
    buffer = editor.getBuffer()
    cursor = editor.getLastCursor()
    currentRow = cursor.getBufferRow()
    if buffer.isRowBlank(currentRow)
      editor.transact ->
        rowRange = buffer.rangeForRow(currentRow, false)
        rowText = editor.getTextInBufferRange(rowRange)
        editor.setTextInBufferRange(rowRange, '')
        if above
          editor.insertText(rowText + "\n", {autoIndent: false})
          cursor.moveUp()
          cursor.moveToEndOfLine()
        else
          editor.insertText("\n" + rowText, {autoIndent: false})
    else
      e.abortKeyBinding()
