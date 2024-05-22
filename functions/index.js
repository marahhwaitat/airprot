/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// Cloud Function (Node.js example)
const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.sendNotificationOnFirestoreUpdate = functions.firestore
    .document('Flights/{docId}')
    .onWrite((change, context) => {
        const newData = change.after.data();

        const message = {
            notification: {
                title: "Data Updated!",
                body: "Your data in Firestore has been changed."
            },
            data: { // Optional data payload for the app
                updatedField: newData.updatedField, // Example field
            },
            android: {
                priority: 'high' // Set priority for Android
            },
            // Add iOS-specific settings if needed
        };

        admin.messaging().sendToTopic('your_topic_name', message)
            .then((response) => {
                console.log('Message sent successfully:', response);
            })
            .catch((error) => {
                console.log('Error sending message:', error);
            });
    });
