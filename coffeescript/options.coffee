saveOptions = () ->
  data = {
    username: document.getElementById("username").value,
    quantity: document.getElementById("number_of_emails").value,
    provider: document.getElementById("provider").value
  }

  chrome.storage.local.set data, () ->
    status = document.getElementById('status')
    status.textContent = 'Options saved.'
    return
  return

getOptions = () ->
  data = {
    username: '',
    quantity: 3,
    provider: ''
  }
  chrome.storage.local.get data, (items) ->
    document.getElementById('username').value = items.username
    document.getElementById('number_of_emails').value = items.quantity
    document.getElementById('provider').value = items.provider
    return
  return

document.addEventListener("DOMContentLoaded", getOptions)
document.getElementById("save").addEventListener("click", saveOptions)