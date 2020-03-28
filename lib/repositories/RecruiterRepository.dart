import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hireme/blocs/registration/registration_bloc.dart';
import 'package:hireme/models/Candidate.dart';
import 'package:hireme/models/Recruiter.dart';
import 'package:hireme/models/Table.dart';
import 'package:hireme/models/Technology.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/repositories/CandidateRepository.dart';

class RecruiterRepository with Table {



  static void signUp(CandidateRegistration candidateRegistration) async {
    final String fileName = Random().nextInt(10000).toString() +
        "-" +
        candidateRegistration.image.path.split('/').last;
    final FirebaseUser user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: candidateRegistration.email,
                password: candidateRegistration.password))
        .user;
    final StorageReference imageReference =
        FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask =
        imageReference.putFile(candidateRegistration.image);
    final String avatarURL =
        await (await uploadTask.onComplete).ref.getDownloadURL();

    final List<DocumentReference> technologiesDoc = candidateRegistration
        .technologies
        .map((technology) =>
            Table.getDocumentReference("Technology", technology.id))
        .toList();

    final DocumentReference candidateRef =
        Table.createDocument("Recruiter", user.uid);
    Table.insertDataInExistingDocument("Recruiter", candidateRef.documentID, {
      'avatarURL': avatarURL,
      'experience': candidateRegistration.experience,
      'technologies': technologiesDoc,
      'name': candidateRegistration.name,
      'companyLocation': candidateRegistration.surname,
      'role': candidateRegistration.role,
      'platform': candidateRegistration.platforms,
      'certificate': candidateRegistration.certificate,
    });
  }

  static Future<User> retrieveRecruiterData(
      String uid, DocumentSnapshot userSnap) async {
    if (userSnap == null) {
      userSnap = await Firestore.instance
          .collection("Recruiter")
          .document(uid)
          .get(); //Recupère le candidat
    }

    if (userSnap.data == null) return null;

    List<Technology> technologies = List<Technology>();

    for (DocumentReference technologyRef in userSnap.data["technologies"]) {
      DocumentSnapshot technologySnap =
          await Table.getDocumentSnapshot(technologyRef);
      Technology technology = new Technology.fromJson(
          technologyRef.documentID, technologySnap.data);
      technologies.add(technology);
    }

    userSnap.data["technologies"] = technologies;

    return new Recruiter.fromJson(uid, userSnap.data, technologies);
  }

/*
 *  Récupère les candidats que le recruteur à déjà aimer et places leurs iD dans une liste
 *  Ensuite récupère les candidats que le recruteur n'a pas encore donner son appréciation 
 */
  static Future<List<Candidate>> getPotentialCandidate(
      {Recruiter recruiter}) async {
    QuerySnapshot interestSnapshot = await Firestore.instance
        .collection("Interest")
        .where("senderID", isEqualTo: recruiter.id)
        .getDocuments();
    List<Candidate> candidates = List<Candidate>();
    List<String> candidatesMatched = interestSnapshot.documents
        .map((document) => document.data["receiverID"].toString())
        .toList();

    QuerySnapshot candidatesSnapShot =
        await Firestore.instance.collection("Candidate").getDocuments();

    for (DocumentSnapshot candidateSnap in candidatesSnapShot.documents) {
      if (!candidatesMatched.contains(candidateSnap.documentID)) {
        Candidate candidate = await CandidateRepository.retrieveCandidateData(
            candidateSnap.documentID, candidateSnap);
        candidates.add(candidate);
      }
    }

    return candidates;
  }
}
