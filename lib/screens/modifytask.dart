import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home.dart';

class UpdateRecord extends StatefulWidget {

  const UpdateRecord({Key? key, required this.remaindersKey}) : super(key: key);

  final String remaindersKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {

  final userTitleController = TextEditingController();
  final userDescController = TextEditingController();
  final userDateController = TextEditingController();
  final timeInput = TextEditingController();
  final userStatusController = TextEditingController();
  late DatabaseReference dbRef;
  TimeOfDay time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('remainders');
    getRemaindersData();
  }

  void getRemaindersData() async {
    DataSnapshot snapshot = await dbRef.child(widget.remaindersKey).get();

    Map remainders = snapshot.value as Map;

    userTitleController.text = remainders['title'];
    userDescController.text = remainders['desc'];
    userDateController.text = remainders['Date'];
    timeInput.text = remainders['time'];
    userStatusController.text = remainders['status'];

  }


  @override
  Widget build(BuildContext context) {
    final taskField = Material(
      elevation: 3,
      child: TextFormField(
        autofocus: false,
        controller: userTitleController,
        style: TextStyle(fontFamily: 'Primo'),
        keyboardType: TextInputType.text,
        onSaved: (value) {
          userTitleController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.title,
            color: Colors.black,
          ),
          hintText: "Enter the Task Title",
          hintStyle: TextStyle(fontFamily: 'Primo'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(),
          ),
        ),
      ),
    );

    final desc = Material(
      elevation: 3,
      child: TextFormField(
        maxLines: null,
        autofocus: false,
        controller: userDescController,
        style: TextStyle(fontFamily: 'Primo'),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return ("please enter the Description");
          }
          return null;
        },
        onSaved: (value) {
          userDescController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.description,
            color: Colors.black,
          ),
          hintText: "Enter the task Description",
          hintStyle: TextStyle(fontFamily: 'Primo'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(),
          ),
        ),
      ),
    );
    final Time = Material(
      elevation: 3,
      child: TextFormField(
        autofocus: false,
        controller: timeInput,
        style: TextStyle(
          fontFamily: 'Primo',
        ),
        keyboardType: TextInputType.number,
        onTap: () async {
          TimeOfDay? pickTime = await showTimePicker(
            context: context,
            initialTime:
            TimeOfDay(hour: time.hour, minute: time.minute),
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: false,
                ),
                child: child!,
              );
            },
          );
          if (pickTime != null) {
            setState(() {
              timeInput.text = pickTime.format(context);
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please select time");
          }
          return null;
        },
        onSaved: (value) {
          timeInput.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          prefixIcon: Icon(
            Icons.access_time,
            color: Colors.black,
          ),
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          hintText: "Click to Select the Time",
          hintStyle: TextStyle(
            fontFamily: 'Primo',
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(),
          ),
        ),
      ),

    );

    final Date = Material(
      elevation: 3,
      child:  TextFormField(
        controller: userDateController,
        autofocus: false,
        style: TextStyle(fontFamily: 'Primo'),
        onTap: () async {
          DateTime? pickDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 0)),
            lastDate: DateTime(2050),
          );
          if (pickDate != null) {
            setState(() {
              userDateController.text =
                  DateFormat('dd-MM-yyyy').format(pickDate);
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please select date");
          }
          return null;
        },
        onSaved: (value) {
          userDateController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.date_range,
            color: Colors.black,
          ),
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Click to Select the date",
          hintStyle: TextStyle(fontFamily: 'Primo'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(),

          ),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(title:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:const [
            SizedBox(height: 5,),
            Row(
              children: [
                Text('ADD TASK',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.bold,color: Colors.pinkAccent),),
              ],
            ),
            SizedBox(height: 2,),
          ]
      ),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.white70,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        shadowColor: Colors.white,
      ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15,right: 10),
          child: Padding(
        padding: EdgeInsets.all(8.0),
    child: Form (
      child: Column(
      children: [
        ClipRRect(
            child: Image.asset("assets/img_3.png",
              fit: BoxFit.fill,
              height: 150,
              width: 150,
            )),
      SizedBox(height: 5),
      taskField,
      const SizedBox(
      height: 20,
      ),
      desc,
      const SizedBox(
      height: 20,
      ),
      Date,
      const SizedBox(
      height: 20,
      ),
      Time,
      const SizedBox(
      height: 20,
      ),
      const SizedBox(
      height: 35,
      ),
      Row(
        children: [
          MaterialButton(
          onPressed: () async {

          Map<String, String> remainders = {
            'title': userTitleController.text,
            'desc': userDescController.text,
            'Date': userDateController.text,
            'time': timeInput.text,
            'status': userStatusController.text,
          };

                        dbRef.child(widget.remaindersKey).update(remainders)
                            .then((value) => {
                          Navigator.pop(context)
                        });

                      },
            color: Color.fromRGBO(225, 155, 164, 1),
            textColor: Colors.black,
            minWidth: 70,
            height: 40,
            child: Text('Add Task'),
                    ),
            SizedBox(width: 175,),
            MaterialButton(
              onPressed:(){


                Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchData()));

              } ,
              color: Colors.red,
              textColor: Colors.white,
              minWidth: 70,
              height: 40,
              child: Text('cancel'),
            ),
        ],
      )
              ],
            ),
    ),
        ),
    ),
    );
  }
}