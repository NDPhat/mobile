import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile/presentation/widget/rounded_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int count = 0;
  final record = Hive.box("record");
  int countLike = 0;
  int countDislike = 0;
  List<String> jokeList = [
    "A child asked his father, \"How were people born?\" "
        "So his father said, \"Adam and Eve made babies, then their babies became adults and made babies, and so on.\""
        "The child then went to his mother, asked her the same question and she told him, \"We were monkeys then we evolved to become like we are now.\""
        "The child ran back to his father and said, \"You lied to me!\""
        "His father replied, \"No, your mom was talking about her side of the family.\"",
    "Teacher: \"Kids,what does the chicken give you?\""
        "Student: \"Meat!\""
        "Teacher: \"Very good! Now what does the pig give you?\""
        "Student: \"Bacon!\""
        "Teacher: \"Great! And what does the fat cow give you?\""
        "Student: \"Homework!\"",
    "The teacher asked Jimmy, \"Why is your cat at school today Jimmy?\" "
        "Jimmy replied crying, \"Because I heard my daddy tell my mommy, 'I am going to eat that pussy once Jimmy leaves for school today!'\"",
    "A housewife, an accountant and a lawyer were asked \"How much is 2+2?\""
        "The housewife replies: \"Four!\"."
        "The accountant says: \"I think it's either 3 or 4.  Let me run those figures through my spreadsheet one more time.\" "
        "The lawyer pulls the drapes, dims the lights and asks in a hushed voice, \"How much do you want it to be?\""
  ];
  late String jokeNow = jokeList[0];
  showEndGameDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('GO'),
              ),
            ],
            title: const Text(
                "That's all the jokes for today! Come back another day!"),
          );
        });
  }

  void increment(String note) {
    if (count == 3) {
      showEndGameDialog();
    } else {
      if (note == "like") {
        countLike++;
        record.put('like', countLike);
      } else {
        countDislike++;
        record.put('dislike', countDislike);
      }
      setState(() {
        count++;
        jokeNow = jokeList[count];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Center(child: Text("Jokee Single Serving APP")),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.greenAccent,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'A joke a day keep the doctor away',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const Text(
                    'If you joke wrong way,your teeth have to pay.(Serious)',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.05, right: size.width * 0.05),
              child: Column(
                children: [
                  Flexible(
                      flex: 3,
                      child: Container(
                        height: size.height * 0.3,
                        padding: EdgeInsets.only(top: size.width * 0.1),
                        child: Text(
                          jokeNow,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      )),
                  const Spacer(
                    flex: 2,
                  ),
                  Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedButton(
                                press: increment,
                                color: Colors.blueAccent,
                                width: size.width * 0.4,
                                note: "like",
                                height: size.height * 0.06,
                                child: const Text("This is Funny!")),
                            RoundedButton(
                                note: "dislike",
                                press: increment,
                                color: Colors.greenAccent,
                                width: size.width * 0.4,
                                height: size.height * 0.06,
                                child: const Text("This is not Funny!")),
                          ],
                        ),
                      )),
                  const Spacer(
                    flex: 1,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'This appis created as part of Hlsolutions program.The materials con-'
                        'tained on this website are provided for general information only and '
                        'do nit constitute any form of advice.HLS assumes no responsibility '
                        'for the accuracy of any particular statement and accpets no liability '
                        'for any loss or damage which may arise from reliance on the infor-',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Center(
                          child: Text(
                        "mation contained on this site.",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 11,
                        ),
                      )),
                      Text('Copyright 2021 HLS')
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
