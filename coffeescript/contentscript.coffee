handleMessage = (request, sender, sendResponse) ->
  element = document.activeElement
  element.value = request.email
  return

chrome.runtime.onMessage.addListener(handleMessage)