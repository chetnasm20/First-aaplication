import 'package:careercounselling/services/database.dart';
import 'package:careercounselling/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  late String question, option1, option2, option3, option4;
  bool _isLoading = false;

  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if (_formKey.currentState!.validate()) {

      setState((){
        _isLoading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };

      await databaseService.addQuestionData(questionMap, widget.quizId).then((value){
        setState((){
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
        key: _formKey,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Enter Question" : null,
                      decoration: InputDecoration(hintText: "Question"),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Enter Option 1" : null,
                      decoration:
                          InputDecoration(hintText: "Option 1 (Correct Answer)"),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Enter Option 2" : null,
                      decoration: InputDecoration(hintText: "Option 2"),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Enter Option 3" : null,
                      decoration: InputDecoration(hintText: "Option 3"),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Enter Option 4" : null,
                      decoration: InputDecoration(hintText: "Option 4"),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: blueButton(
                              context: context,
                              label: "Submit",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            uploadQuestionData();
                          },
                          child: blueButton(
                              context: context,
                              label: "Add Question",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
          ),
    );
  }
}
