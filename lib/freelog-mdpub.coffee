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

    # submit via request
    request = require('request')
    done = this.aysnc();
    resource = {
      resource: {
        resource_type: 'markdown',
        meta: '',
        name: 'whatever'
        sharing_policy: '{}',
        content: 'nothing yet'
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
        if (err) {
          console.error('upload failed:', err);
        }
    ).auth('miushock@gmail.com','840304')
