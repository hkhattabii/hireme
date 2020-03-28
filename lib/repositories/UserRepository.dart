import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hireme/models/Candidate.dart';
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
    Candidate candidate =
        await CandidateRepository.retrieveCandidateData(userID, null);
    if (candidate == null)
      return await RecruiterRepository.retrieveRecruiterData(userID, null);
    return candidate;
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
      //Si un ID existe c'est qu'il y'a un match, envoie de notificiation
      print('MATCH');
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
        "message": "Match avec " +
            (receiver as Candidate).name +
            " " +
            (receiver as Candidate).surname,
        "owner": sender.id,
      });

      Firestore.instance.collection("Notification").document().setData({
        "message": "Match avec " + sender.companyName,
        "owner": receiver.id,
      });
    } else if (sender is Candidate) {
      Firestore.instance.collection("Notification").document().setData({
        "message": "Match avec " + (receiver as Recruiter).companyName,
        "owner": sender.id,
      });

      Firestore.instance.collection("Notification").document().setData({
        "message": "Match avec " + sender.name + " " + sender.surname,
        "owner": receiver.id,
      });
    }
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
