const functions = require('firebase-functions');
const admin = require('firebase-admin')

admin.initializeApp(functions.config().functions);


exports.messageTrigger = functions.firestore.document('Notification/{notificationId}').onCreate(async snapshot => {
    if (!snapshot.exists) {
        console.log('No devices');
        return;
    }
    let token = ''
    const notification = snapshot.data()
    const candidateSnapshot = await admin.firestore().collection('Candidate').doc(notification.owner).get()
    let recruiterSnapshot = undefined;
    console.log(candidateSnapshot.data())
    if (candidateSnapshot.data() === undefined) {
        recruiterSnapshot = await admin.firestore().collection('Recruiter').doc(notification.owner).get()
        token = recruiterSnapshot.get('token')
    } else {
        token = candidateSnapshot.get('token')
    }
 
    console.log('CANDIDATE TOKEN : ' + token)



    const payload = {
        notification: {
            title: 'MATCH !',
            body: notification.message,
            sound: 'default',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    }


    try {
        const response = await admin.messaging().sendToDevice(token, payload)
        console.log('Notification sent successfully')
        console.log(response)
    } catch (err) {
        console.log('Error sending notifications')
    }
})