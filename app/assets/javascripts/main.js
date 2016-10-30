if ('serviceWorker' in navigator) {
  console.log('Service Worker is supported');
  navigator.serviceWorker.register('sw.js').then(function() {
    return navigator.serviceWorker.ready;
  }).then(function(reg) {
    console.log('Service Worker is ready :^)', reg);
    reg.pushManager.subscribe({userVisibleOnly: true}).then(function(sub) {
      var subscriptionId = sub.endpoint.split("/").pop();
      console.log('endpoint:', sub.endpoint);
      console.log('subscriptionId:', subscriptionId);
    });
  }).catch(function(error) {
    console.log('Service Worker error :^(', error);
  });
}
