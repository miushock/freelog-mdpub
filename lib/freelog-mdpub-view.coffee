module.exports =
class FreelogMdpubView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('freelog-mdpub')
    message = document.createElement('div')
    @element.appendChild(message)

    # enter user info
    user_info = document.createElement('div')
    user_info.classList.add('freelog-credential')
    #email and pw
    user_email = document.createElement('input')
    user_email.type = 'email'
    user_email.classList.add('freelog-credential-email')
    user_password = document.createElement('input')
    user_password.type = 'password'
    user_password.classList.add('freelog-credential-password')
    #submit button
    submit_button = document.createElement('button')
    submit_button.textContent = 'submit'
    submit_button.classList.add('freelog-submit')

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

  setMsg: (m) ->
    @element.children[0].textContent = m
