firebase.initializeApp({messagingSenderId: "360023013400"});
const messaging = firebase.messaging();
messaging.usePublicVapidKey('BNiXIyTmHO_7jMvGguwIEWVHogKuwqqkRi7etMlLsqlbCfr0AvJU2i1UhCiZFZRKYWZ7AS2Lc6PZ88l7e4HRw9I');

function setToken() {
  messaging.getToken().then(function(currentToken) {
    var element = document.getElementById('user_browser_subscription_id');
    element.value = currentToken;
  });
}

messaging.requestPermission().then(function() {
  setToken();
}).catch(function(err) {
  console.log('Unable to get permission to notify.', err);
});


messaging.onTokenRefresh(function() {
  messaging.getToken().then(function(refreshedToken) {
    setToken();
  }).catch(function(err) {
    console.log('Unable to retrieve refreshed token ', err);
  });
});
