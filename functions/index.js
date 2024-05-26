const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.sendNotificationOnFirestoreUpdate = functions.firestore
    .document('Flights/{id}')
    .onWrite((change, context) => {

        var tokens = [];
        admin.firestore().collection('Tokens').get()
            .then(documents => {
                documents.forEach(doc => {
                    var token = doc.data().token
                    console.log('token:', token);
                    tokens.push(token);
                });

                const message = {
                    notification: {
                        title: "Flight Updated!",
                        body: "Your Flight Details has been changed."
                    },
                    token: tokens
                };

                admin.messaging().send(message)
                    .then((response) => {
                        console.log('Message sent successfully:', response);
                    })
                    .catch((error) => {
                        console.log('Error sending message:', error);
                    });
            });
    });
