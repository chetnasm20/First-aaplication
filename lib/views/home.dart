import 'package:careercounselling/dashboard.dart';
import 'package:careercounselling/services/database.dart';
import 'package:careercounselling/views/create_quiz.dart';
import 'package:careercounselling/views/profile.dart';
import 'package:careercounselling/views/quiz_play.dart';
import 'package:careercounselling/widgets/my_drawer_header.dart';
import 'package:careercounselling/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream? quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return QuizTile(
                      noOfQuestions: snapshot.data.documents.length,
                      desc: snapshot.data.documents[index].data["quizDesc"],
                      imgUrl: snapshot.data.documents[index].data["quizImgurl"],
                      title: snapshot.data.documents[index].data["quizTitle"],
                      quizid: snapshot.data.documents[index].data["quizId"],
                    );
                  });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizezData().then((val) {
      quizStream = val;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.black12,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: quizList(),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox.fromSize(
        size: Size.square(50),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateQuiz()));
          },
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.dashboard_outlined),
            title: Text(
              'Dashboard',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Person',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizid;
  final int noOfQuestions;

  QuizTile(
      {required this.desc,
      required this.imgUrl,
      required this.title,
      required this.quizid,
      required this.noOfQuestions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuizPlay(quizid)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imgUrl,
                  width: MediaQuery.of(context).size.width - 48,
                  fit: BoxFit.cover),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
