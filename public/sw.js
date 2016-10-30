console.log('Started', self);

self.addEventListener('install', function(event) {
  self.skipWaiting();
  console.log('Installed', event);
});

self.addEventListener('activate', function(event) {
  console.log('Activated', event);
});

self.addEventListener('push', function(event) {
  var title = 'Push message';

  // TODO: adjust body, icon, title
  event.waitUntil(
    self.registration.showNotification(title, {
     body: 'The Message',
     icon: 'images/icon.png'
   }));
});
