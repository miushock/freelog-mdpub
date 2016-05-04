FreelogMdpubView = require './freelog-mdpub-view'
{CompositeDisposable} = require 'atom'
# Request = require 'request'

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

    # add button
    submit_button = document.querySelector('button.freelog-submit')
    submit_button.onclick = ((_this)-> return -> _this.upload())(this)

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
      editor = atom.workspace.getActiveTextEditor
      @modalPanel.show()

  upload: ->
    editor = atom.workspace.getActiveTextEditor()
    user_email = document.querySelector('input.freelog-credential-email').value
    user_password = document.querySelector('input.freelog-credential-password').value
    if editor = atom.workspace.getActiveTextEditor()
      content = editor.getText()
    # submit via request
    request = require('request')
    resource = {
      resource: {
        resource_type: 'markdown',
        meta: {},
        name: 'whatever'
        mime_type: 'text/plain'
        sharing_policy: '{}',
        content: content
      }
    }

    request(
      {
        method: 'post',
        uri: 'http://freelog.co:3000/resources.json',
        json:true,
        body:resource
      },
      (err, response, body) ->
        if (err) then alert(err) else alert(response)
    ).auth(user_email,user_password)
