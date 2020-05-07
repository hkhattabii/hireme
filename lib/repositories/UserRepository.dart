import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hireme/models/Candidate.dart';
import 'package:hireme/models/Notification.dart';
import 'package:hireme/models/Recruiter.dart';
import 'package:hireme/models/Table.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/repositories/CandidateRepository.dart';
import 'package:hireme/repositories/RecruiterRepository.dart';

class UserRepository with Table {
  /**
   * Se connecte directement à l'application si un utilisateur est déjà connecté dans firebase
   * Si Aucun utilisateur est connecté, renvoie null et est renvoyer vers l'écran d'acceuil
   */
  static Future<User> getCurrentUser() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    print('FIREBASEUSER: $firebaseUser');
    if (firebaseUser == null) {
      return null;
    }

    return getAccountDependingOnType(firebaseUser.uid);
  }

  //Lorsque l'utilisateur se connecte retourne le bon objet dependant du type de compte, Recruteur ou Candidat
  static Future<User> signIn(String email, String password) async {
    if (email != null) {
      try {
        AuthResult authResult = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print('lutilisateur se connecte');
        return getAccountDependingOnType(authResult.user.uid);
      } catch (e) {
        print(e);
        throw e.message;
      }
    } else {
      throw "Le champ email ne peut être vide";
    }
  }

/*
  * Renvoie le bon type de compte (Recruteur ou candidat)
  * Si dans la méthode "retriveCandidateData", le base de donnée ne trouve pas le candidat (null)
  * Dans ce cas renvoie un recruteur. Si le candidat existe, renvoie le candidat
  * On spécifie null dans la méthode pour dire qu'on est pas en possesion d'un document pour crée l'object, 
  * il va donc aller le chercher dans la base de donnée
 */
  static Future<User> getAccountDependingOnType(String userID) async {
    final FirebaseMessaging fcm = new FirebaseMessaging();
    final String fcmToken = await fcm.getToken();
    Candidate candidate =
        await CandidateRepository.retrieveCandidateData(userID, null);

    if (candidate == null) {
      Recruiter recruiter =
          await RecruiterRepository.retrieveRecruiterData(userID, null);
      if (fcmToken != null) {
        QuerySnapshot userSnapshot = await Firestore.instance
            .collection("Recruiter")
            .where("token", isEqualTo: recruiter.token)
            .getDocuments();
        userSnapshot.documents.forEach((document) => {
              document.reference
                  .updateData(<String, dynamic>{'token': fcmToken})
            });
        recruiter.token = fcmToken;
        print("HOLAAAAAA");
      }
      return recruiter;
    }

    if (fcmToken != null && fcmToken != candidate.token) {
      QuerySnapshot userSnapshot = await Firestore.instance
          .collection("Candidate")
          .where("token", isEqualTo: candidate.token)
          .getDocuments();
      userSnapshot.documents.forEach((document) => {
            document.reference.updateData(<String, dynamic>{'token': fcmToken})
          });
      candidate.token = fcmToken;
    }
    return candidate;
  }

  static Future<List<UserNotification>> getNotifications(String userID) async {
    QuerySnapshot notificationSnapshot = await Firestore.instance
        .collection("Notification")
        .where("owner", isEqualTo: userID)
        .getDocuments();

    List<UserNotification> notifications = notificationSnapshot.documents
        .map((document) =>
            new UserNotification.fromJson(document.documentID, document.data))
        .toList();

    return notifications;
  }

/*
 * Si les deux sont match, il ne se rencontreront jamais
 * Si un des deux sont match affiche seulement la personne qui a matché cette personne.
 */
  static void interest({User sender, User receiver}) async {
    QuerySnapshot isInterestMe = await Firestore.instance
        .collection("Interest")
        .where("receiverID", isEqualTo: sender.id)
        .where("senderID", isEqualTo: receiver.id)
        .getDocuments();
    if (isInterestMe.documents.isNotEmpty) {
      //Si un ID existe c'est qu'il y'a un match, envoie une notificiation
      sendNotification(sender, receiver);
    }

    Firestore.instance
        .collection("Interest")
        .document()
        .setData({'senderID': sender.id, 'receiverID': receiver.id});
  }

  static sendNotification(User sender, User receiver) {
    if (sender is Recruiter) {
      Firestore.instance.collection("Notification").document().setData({
        "message": sender.companyName + " a matché avec vous",
        "owner": receiver.id,
      });
    } else if (sender is Candidate) {
      Firestore.instance.collection("Notification").document().setData({
        "message": sender.name + " " + sender.surname + " a matché avec vous",
        "owner": receiver.id,
      });
    }
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
