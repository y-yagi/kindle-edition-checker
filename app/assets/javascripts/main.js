if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/assets/sw.js').then(function() {
    return navigator.serviceWorker.ready;
  }).then(function(reg) {
    reg.pushManager.subscribe({userVisibleOnly: true}).then(function(sub) {
      var subscriptionId = sub.endpoint.split("/").pop();
      console.log('endpoint:', sub.endpoint);
      console.log('subscriptionId:', subscriptionId);
    });
  }).catch(function(error) {
    console.log('Service Worker error :', error);
  });
}
