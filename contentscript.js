// Generated by CoffeeScript 1.11.1
(function() {
  var handleMessage;

  handleMessage = function(request, sender, sendResponse) {
    var element;
    element = document.activeElement;
    element.value = request.email;
  };

  chrome.runtime.onMessage.addListener(handleMessage);

}).call(this);

//# sourceMappingURL=contentscript.js.map
