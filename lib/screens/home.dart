import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:remainder_jash/screens/modifytask.dart';

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
      child:
          Container(
          decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),

      color: const Color.fromRGBO(154, 255, 239, 1),
          ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(remainders['title'],style: TextStyle(fontSize: 20,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
          SizedBox(height: 6,),
          Row(
            children: [
              Text('Desc:', style: TextStyle(fontSize: 17,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.bold),),
              SizedBox(width: 5,),
              Text(
                remainders['desc'],
                style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Arimo'),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children:[
              Text('Date and Time:',style: TextStyle(fontSize: 17,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
              SizedBox(width: 5,),
              Row(
                children:[
                  Text(
                    remainders['Date'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'Arimo'),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    remainders['time'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'Arimo',),
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
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              GestureDetector(
                onTap: () {
                  reference.child(remainders['key']).remove();
                },
                child: Row(
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
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

              Map remainders = snapshot.value as Map;
              remainders['key'] = snapshot.key;

              return listItem(remainders: remainders);

            },
          ),
        )
    );
  }
}