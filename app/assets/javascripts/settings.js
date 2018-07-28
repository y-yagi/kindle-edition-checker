if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/sw.js').then(function() {
    return navigator.serviceWorker.ready;
  }).then(function(reg) {
    reg.pushManager.subscribe({userVisibleOnly: true}).then(function(sub) {
      var subscriptionId = sub.endpoint.split("/").pop();
      document.getElementById("user_browser_subscription_id").value = subscriptionId;
    });
  }).catch(function(error) {
    console.log('Service Worker error :', error);
  });
}
