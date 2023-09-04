import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remainder_jash/screens/modifytask.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:remainder_jash/screens/theme.dart';
import 'package:remainder_jash/screens/theme_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remainder_jash/services/notification_services.dart';
import 'addtask.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  final userStatusController = TextEditingController();
  Query dbRef = FirebaseDatabase.instance.ref().child('remainders');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('remainders');

  Widget listItem({required Map? remainders}) {
    if (remainders == null) {
      return Container();
    }

    bool isCompleted = remainders['status'] == 'completed';
    String title = remainders['title'] ?? '';
    String desc = remainders['desc'] ?? '';
    String date = remainders['Date'] ?? '';
    String time = remainders['time'] ?? '';
    String completedTime = remainders['completedTime'] ?? '';
    String status = remainders['status'] ?? '';

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isCompleted ? Color.fromRGBO(175, 255, 175, 1) : Color.fromRGBO(255, 234, 231, 1),
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontFamily: 'Primo', fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6,),
            Row(
              children: [
                const Text(
                  'Desc:',
                  style: TextStyle(fontSize: 17, fontFamily: 'Arimo', fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5,),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Arimo'),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children:[
                const Text(
                  'Date and Time:',
                  style: TextStyle(fontSize: 17, fontFamily: 'Arimo', fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5,),
                Row(
                  children:[
                    Text(
                      date,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Arimo'),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Arimo'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5,),
            if (isCompleted)
              Row(
                children: [
                  const Text(
                    'Status:',
                    style: TextStyle(fontSize: 17, fontFamily: 'Arimo', fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    status,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Arimo'),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!isCompleted) // Only show the check icon if the task is not completed
                  GestureDetector(
                    onTap: () {
                      // Handle completion logic here
                      remainders['status'] = 'completed';
                      remainders['completedTime'] = DateTime.now().toString();
                      reference.child(remainders['key']).update({
                        'status': 'completed',
                        'completedTime': DateTime.now().toString(),
                      });
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline_sharp,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(width: 6,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecord(remaindersKey: remainders['key'])));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        color: Colors.deepOrange,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6,),
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        content: SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Text(''),
                                  InkWell(
                                    child: Icon(Icons.close, color: Colors.redAccent,),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => FetchData()));
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 19),
                              Text(
                                "Goal Deleted",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Arimo',
                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 18),
                              Image.asset(
                                'assets/img_5.png',
                                height: 80,
                                width: 80,
                              ),
                            ],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      );
                    });
                    reference.child(remainders['key']).remove();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red[900],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: subHeadingStyle,
                    ),
                    Text(
                      "Today",
                      style: headingStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15,),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 70,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 12,),
          const SizedBox(height: 10,),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: FirebaseAnimatedList(
                query: dbRef,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  Map remainders = snapshot.value as Map;
                  remainders['key'] = snapshot.key;
                  return listItem(remainders: remainders);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => History()));
                    },
                    child: const Text('History'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[300],
                      minimumSize: const Size(150, 30),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InsertData()));
                    },
                    child: const Text('Add Task'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      minimumSize: const Size(150, 30),

                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.pink[200],
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
        },
        child: const Icon(Icons.nightlight_round, size: 20, color: Colors.black),
      ),
      actions: const [
        Icon(Icons.person, size: 20, color: Colors.black),
        SizedBox(width: 20,),
      ],
    );
  }
}
