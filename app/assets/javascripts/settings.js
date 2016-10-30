if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/sw.js').then(function() {
    return navigator.serviceWorker.ready;
  }).then(function(reg) {
    reg.pushManager.subscribe({userVisibleOnly: true}).then(function(sub) {
      var subscriptionId = sub.endpoint.split("/").pop();
      console.log(subscriptionId)
      $("#user_chrome_subscription_id").val(subscriptionId);
    });
  }).catch(function(error) {
    console.log('Service Worker error :', error);
  });
}
