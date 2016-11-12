chrome.contextMenus.create(
    id: 'spamgourmet'
    title: 'Input disposable email address'
    contexts: ['editable']
)

getDataFromLocalStorage = () ->
  chrome.storage.local.get((items) ->
    if chrome.runtime.lastError
      console.log(chrome.runtime.lastError)
    else
      data = {
        username: items.username
        quantity: items.quantity
        provider: items.provider
        hostname: 'none'
        disposable_email: 'none'
      }
    getUrlFromActiveTabAndExtractHostname(data)
    return
  )
  return

getUrlFromActiveTabAndExtractHostname = (data) ->
  chrome.tabs.query(
    active: true
    lastFocusedWindow: true
    (tabs) ->
      url = new URL(tabs[0].url)
      entire_hostname = url.hostname
      data.hostname = entire_hostname.substring(entire_hostname.indexOf(".") + 1, entire_hostname.lastIndexOf("."));
      if (data.hostname == ".")
        data.hostname = entire_hostname.slice(0, entire_hostname.lastIndexOf("."));
      createDisposableEmailAddress(data)
      return
  )
  return

createDisposableEmailAddress = (data) ->
  if data.username && data.quantity && data.provider && data.hostname
    data.disposable_email = data.hostname + "." + data.username + "." + data.quantity + "@" + data.provider;
  else
    console.log("Some options or hostname is missing. Please refer to the options page first.");
    alert("Some options or hostname is missing. Please refer to the options page first.");
  inputDisposableEmailAddressToActiveForm(data)
  return

inputDisposableEmailAddressToActiveForm = (data) ->
  chrome.tabs.query(
    active: true,
    currentWindow: true
  (tabs) ->
    chrome.tabs.sendMessage(
      tabs[0].id
      {email: data.disposable_email})
    return
  )
  return

chrome.contextMenus.onClicked.addListener(getDataFromLocalStorage)