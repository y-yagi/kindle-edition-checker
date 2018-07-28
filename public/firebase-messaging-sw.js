importScripts('https://www.gstatic.com/firebasejs/5.3.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/5.3.0/firebase-messaging.js');

firebase.initializeApp({messagingSenderId: "360023013400"});
const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  // Customize notification here
  var notificationTitle = 'Kindle Edition Checker';
  var notificationOptions = {
    body: 'Kindle版がamazonに登録されました',
    icon: 'icon.png'
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});
