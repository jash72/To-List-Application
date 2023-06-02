import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remainder_jash/screens/button.dart';
import 'package:remainder_jash/screens/modifytask.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:remainder_jash/screens/theme.dart';
import 'addtask.dart';
import 'package:google_fonts/google_fonts.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Query dbRef = FirebaseDatabase.instance.ref().child('remainders');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('remainders');

  Widget listItem({required Map remainders}) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(255, 234, 231, 1),
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              remainders['title'],
              style: const TextStyle(fontSize: 20, fontFamily: 'Arimo', fontWeight: FontWeight.bold),
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
                  remainders['desc'],
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
                      remainders['Date'],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Arimo'),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      remainders['time'],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Arimo'),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecord(remaindersKey: remainders['key'])));
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6,),
                GestureDetector(
                  onTap: () {
                    reference.child(remainders['key']).remove();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
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
                MyButton(label: "+ Add task", onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InsertData()),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 120,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 35,),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InsertData()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
