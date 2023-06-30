import 'package:careercounselling/user_form_widget.dart';
import 'package:careercounselling/users_data.dart';
import 'package:careercounselling/views/home.dart';
import 'package:careercounselling/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:careercounselling/user_form_widget.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: CreateProfile(),
    );
  }
}

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilenoController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();

  _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => EditProfilePage()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/image_pic.png'))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              UserFormWidget(
                onSavedUser: (user) async {
                  final id = await UserSheetsApi.getRowCount()+1;
                  final newUser = user.copy(id: id);
                  await UserSheetsApi.insert([newUser.toJson()]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
