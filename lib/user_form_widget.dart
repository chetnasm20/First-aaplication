import 'package:careercounselling/models/feedback_form.dart';
import 'package:flutter/material.dart';
import 'button_widget.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<User>onSavedUser;

  const UserFormWidget({
    Key? key,
    this.user,
    required this.onSavedUser,
}) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late TextEditingController controllermobileno;
  late TextEditingController controllerlocation;
  late TextEditingController controllerqualification;

  @override
  void initState() {
    super.initState();

    initUser();
  }

  @override
  void didUpdateWidget(covariant UserFormWidget oldWidget){
    super.didUpdateWidget(oldWidget);

    initUser();
  }

  void initUser() {

    final name = widget.user==null? '' : widget.user!.name;
    final email = widget.user==null? '' : widget.user!.email;
    final location = widget.user==null? '' : widget.user!.location;
    final mobileno = widget.user==null? '' : widget.user!.mobileno;
    final qualification = widget.user==null? '' : widget.user!.qualification;

    setState((){
    controllerName = TextEditingController(text: name);
    controllerEmail = TextEditingController(text: email);
    controllermobileno = TextEditingController(text: mobileno);
    controllerlocation = TextEditingController(text: location);
    controllerqualification = TextEditingController(text: qualification);
    });
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildName(),
              const SizedBox(height: 16),
              buildEmail(),
              const SizedBox(height: 16),
              buildmobileno(),
              const SizedBox(height: 16),
              buildlocation(),
              const SizedBox(height: 16),
              buildqualification(),
              const SizedBox(height: 16),
              buildSubmit(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Name' : null,
      );

  Widget buildEmail() => TextFormField(
        controller: controllerEmail,
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && !value.contains('@') ? 'Enter Email' : null,
      );

  Widget buildmobileno() => TextFormField(
    controller: controllermobileno,
    decoration: InputDecoration(
      labelText: 'Mobile Number',
      border: OutlineInputBorder(),
    ),
      validator: (value) =>
      value != null && value.isEmpty ? 'Enter Mobile Number' : null,
  );

  Widget buildlocation() => TextFormField(
    controller: controllerlocation,
    decoration: InputDecoration(
      labelText: 'Location',
      border: OutlineInputBorder(),
    ),
    validator: (value) =>
    value != null && value.isEmpty ? 'Enter Location' : null,
  );

  Widget buildqualification() => TextFormField(
    controller: controllerqualification,
    decoration: InputDecoration(
      labelText: 'Qualification',
      border: OutlineInputBorder(),
    ),
    validator: (value) =>
    value != null && value.isEmpty ? 'Enter Qualification' : null,
  );

  Widget buildSubmit() => ButtonWidget(
        text: 'Save',
        onClicked: () {
          final form = formKey.currentState!;
          final isValid = form.validate();

          if (isValid){
            final user = User(
              name: controllerName.text,
              email: controllerEmail.text,
              mobileno: controllermobileno.text,
              location: controllerlocation.text,
              qualification: controllerqualification.text,
            );
            widget.onSavedUser(user);
          }
        },
      );
}
