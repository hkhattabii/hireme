import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireme/blocs/registration/registration_bloc.dart';
import 'package:hireme/models/Project.dart';

class ProjectDialog extends StatefulWidget {
  @override
  _ProjectDialogState createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  String projectName;
  String url;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 16.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Ajouter un projet"),
              onChanged: (text) {
                this.setState(() {
                  projectName = text;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Url du projet (lien du store, site web, ... )"),
              onChanged: (text) {
                this.setState(() {
                  url = text;
                });
              },
            ),
            RaisedButton(
                child: Text('Ajouter'),
                onPressed: () {
                  addProject(context, Project(name: projectName, url: url));
                }),
            Expanded(child: BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (BuildContext context, RegistrationState state) {
              List<Project> projects =
                  (state as CandidateRegistration).projects;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: projects.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(projects[index].name),
                    subtitle: Text(projects[index].url),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        removeProject(context, projects[index]);
                      },
                    ),
                  );
                },
              );
            }))
          ],
        ),
      ),
    );
  }

  addProject(BuildContext context, Project project) {
    BlocProvider.of<RegistrationBloc>(context).add(
        CandidateAddProject(project: project));
  }

  removeProject(BuildContext context, Project project) {
        BlocProvider.of<RegistrationBloc>(context).add(
        CandidateRemoveProject(project: project));
  }
}
