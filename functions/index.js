const functions = require('firebase-functions');
const admin = require('firebase-admin');

var serviceAccount = require("/home/abdelrahman/Desktop/airprot/functions/airport.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

exports.sendNotificationOnFirestoreUpdate = functions.firestore
    .document('Flights/{id}')
    .onWrite((change, context) => {
        const id = context.params.id

        const message = {
            notification: {
                title: "Flight Updated!",
                body: "Your Flight Details has been changed."
            },
        };

        admin.messaging().sendToTopic('Admin', message)
            .then((response) => {
                console.log('Message sent successfully:', response);
            })
            .catch((error) => {
                console.log('Error sending message:', error);
            });
    });
