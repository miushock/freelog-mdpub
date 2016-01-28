FreelogMdpubView = require './freelog-mdpub-view'
{CompositeDisposable} = require 'atom'

module.exports = FreelogMdpub =
  freelogMdpubView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @freelogMdpubView = new FreelogMdpubView(state.freelogMdpubViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @freelogMdpubView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'freelog-mdpub:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @freelogMdpubView.destroy()

  serialize: ->
    freelogMdpubViewState: @freelogMdpubView.serialize()

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      words = editor.getText().split(/\s+/).length
      @freelogMdpubView.setCount(words)
      @modalPanel.show()
