module.exports =
class FreelogMdpubView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('freelog-mdpub')

    # enter user info
    user_info = document.createElement('div')
    user_info.classList.add('freelog-credential')

    #email and pw
    user_email = document.createElement('input')
    user_email.type = 'email'
    user_password = document.createElement('input')
    user_password.type = 'password'
    #submit button
    submit_button = document.createElement('button')
    submit_button.textContent = 'submit'

    user_info.appendChild(user_email)
    user_info.appendChild(user_password)
    @element.appendChild(user_info)
    @element.appendChild(submit_button)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  setCount: (count) ->
    displayText = "there are #{count} words."
    @element.children[0].textContent = displayText
