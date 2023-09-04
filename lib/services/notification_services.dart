import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/home.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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

    Color statusColor = isCompleted ? Colors.green : Colors.orange;

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontFamily: 'Primo', fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Arimo', color: Colors.white),
                  ),
                ),
              ],
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
                    'Completed time:',
                    style: TextStyle(fontSize: 17, fontFamily: 'Arimo', fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.parse(completedTime)),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Arimo'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void navigateToFetchData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FetchData()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 5,),
            Row(
              children: [
                Text('History',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.bold,color: Colors.pinkAccent),),
                Spacer(),
                Icon(Icons.cancel_outlined),
              ],
            ),
            SizedBox(height: 2,),
          ],
        ),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.white70,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        shadowColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.cancel_outlined, color: Colors.red),
            onPressed: navigateToFetchData,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15,),
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
    );
  }
}
