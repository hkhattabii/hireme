import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hireme/blocs/registration/registration_bloc.dart';
import 'package:hireme/models/Candidate.dart';
import 'package:hireme/models/Project.dart';
import 'package:hireme/models/Recruiter.dart';
import 'package:hireme/models/Table.dart';
import 'package:hireme/models/Technology.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/repositories/RecruiterRepository.dart';

class CandidateRepository with Table {
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
    final List<DocumentReference> projectsDoc = await Future.wait(
        candidateRegistration.projects
            .map((project) => Table.insertDocumentAndgetIt(
                "Project", {'name': project.name, 'url': project.url}))
            .toList());

    final DocumentReference candidateRef =
        Table.createDocument("Candidate", user.uid);
    Table.insertDataInExistingDocument("Candidate", candidateRef.documentID, {
      'avatarURL': avatarURL,
      'experience': candidateRegistration.experience,
      'technologies': technologiesDoc,
      'name': candidateRegistration.name,
      'surname': candidateRegistration.surname,
      'role': candidateRegistration.role,
      'platform': candidateRegistration.platforms,
      'certificate': candidateRegistration.certificate,
      'projects': projectsDoc
    });
  }

  static Future<User> retrieveCandidateData(
      String uid, DocumentSnapshot userSnap) async {
    if (userSnap == null) {
      userSnap =
          await Firestore.instance.collection("Candidate").document(uid).get();
    }

    if (userSnap.data == null) return null;
    List<Technology> technologies = List<Technology>();
    List<Project> projects = List<Project>();

    for (DocumentReference technologyRef in userSnap.data["technologies"]) {
      DocumentSnapshot technologySnap =
          await Table.getDocumentSnapshot(technologyRef);
      Technology technology = new Technology.fromJson(
          technologyRef.documentID, technologySnap.data);
      technologies.add(technology);
    }

    for (DocumentReference projectRef in userSnap.data["projects"]) {
      DocumentSnapshot projectSnap =
          await Table.getDocumentSnapshot(projectRef);
      Project project =
          new Project.fromJson(projectRef.documentID, projectSnap.data);
      projects.add(project);
    }

    return new Candidate.fromJson(uid, userSnap.data, technologies, projects);
  }



  /*
 *  Récupère les recruteur que le candidat à déjà aimer et places leurs iD dans une liste
 *  Ensuite récupère les recruteur que le candidat n'a pas encore donner son appréciation 
 */
  static Future<List<Recruiter>> getPotentialRecruiters({Candidate candidate}) async {
    QuerySnapshot interestSnapshot = await Firestore.instance.collection("Interest").where("senderID", isEqualTo: candidate.id).getDocuments();
    List<Recruiter> recruiters = List<Recruiter>();
    List<String> recruitersMatched = interestSnapshot.documents.map((document) => document.data["receiverID"].toString()).toList();



    QuerySnapshot recruitersSnap = await Firestore.instance.collection("Recruiter").getDocuments();

    
    for (DocumentSnapshot recruiterSnap in recruitersSnap.documents) {
      
      if (!recruitersMatched.contains(recruiterSnap.documentID)) {
          Recruiter recruiter = await RecruiterRepository.retrieveRecruiterData(recruiterSnap.documentID, recruiterSnap);
          recruiters.add(recruiter);
      }
    }



    return recruiters;



  }
}
