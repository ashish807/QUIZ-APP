import 'package:flutter/material.dart';
import '../services/database.dart';
import '../views/addquestion.dart';
import '../widgets/wid.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  String _quizimageurl, _quiztitle, _quizdescription, quizId;
  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgurl": _quizimageurl,
        "quizTitle": _quiztitle,
        "quizDescription": _quizdescription,
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddQuestion(
                      quizId: quizId,
                    )),
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  children: <Widget>[
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Image URL" : null;
                      },
                      decoration: InputDecoration(hintText: "Quiz Image URl"),
                      onChanged: (val) {
                        _quizimageurl = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Quiz Title" : null;
                      },
                      decoration: InputDecoration(hintText: "Quiz Title"),
                      onChanged: (val) {
                        _quiztitle = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Quiz Description" : null;
                      },
                      decoration: InputDecoration(hintText: "Quiz Description"),
                      onChanged: (val) {
                        _quizdescription = val;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        createQuizOnline();
                      },
                      child: bluebutton(context: context, label: "Create Quiz"),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
