console.log('Started', self);

self.addEventListener('install', function(event) {
  self.skipWaiting();
  console.log('Installed', event);
});

self.addEventListener('activate', function(event) {
  console.log('Activated', event);
});

self.addEventListener('push', function(event) {
  var title = 'Kindle Edition Checker';

  // TODO: adjust body, icon, title
  event.waitUntil(
    self.registration.showNotification(title, {
     body: 'Kindle版が登録された書籍があります',
     icon: 'icon.png'
   }));
});

self.addEventListener('notificationclick', function(event) {
  event.notification.close()
  url = "https://kindle-edition-checker.herokuapp.com/"

  event.waitUntil(
    clients.matchAll({type: 'window'}).then(function() {
      if(clients.openWindow) {
        return clients.openWindow(url)
      }
    })
  )
})
