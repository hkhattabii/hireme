"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();
const fcm = admin.messaging();
exports.sendToDevice = functions.firestore.document('Notification/{notificationID}').onCreate(async (snapshot) => {
    const notification = snapshot.data();
    if (notification !== undefined) {
        const candidateSnapshot = await db.collection('Candidate').doc(notification.owner).get();
        const candidate = candidateSnapshot.data();
        const payload = {
            notification: {
                title: 'Vous avez un match !',
                body: notification.message,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }
        };
        if (candidate !== undefined) {
            return fcm.sendToDevice(candidate.token, payload);
        }
    }
    return;
});
//# sourceMappingURL=index.js.map