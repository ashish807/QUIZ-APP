import 'package:flutter/material.dart';
import '../services/database.dart';
import '../views/create_quiz.dart';
import '../views/play_quiz.dart';
import '../widgets/wid.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
          stream: quizStream,
          builder: (context, snapshot) {
            return snapshot.data == null
                ? Container()
                : ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return QuizTiles(
                        imgUrl:
                            snapshot.data.documents[index].data["quizImgurl"],
                        title: snapshot.data.documents[index].data["quizTitle"],
                        desc: snapshot
                            .data.documents[index].data["quizDescription"],
                        quizId: snapshot.data.documents[index].data["quizId"],
                      );
                    });
          }),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fantasy.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: quizList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTiles extends StatelessWidget {
  final String imgUrl, title, desc, quizId;
  QuizTiles({
    @required this.imgUrl,
    @required this.title,
    @required this.desc,
    @required this.quizId,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayQuiz(
                      quizId: quizId,
                    )));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 8),
          height: 150,
          child: Stack(
            children: <Widget>[
              new Opacity(
                opacity: 0.45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imgUrl,
                    width: MediaQuery.of(context).size.width - 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black26,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      desc,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
