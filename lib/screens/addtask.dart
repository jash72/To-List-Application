import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:remainder_jash/main.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  TextEditingController usertitleController = TextEditingController();
  TextEditingController userdescController = TextEditingController();
  TextEditingController userdateController = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  late DatabaseReference dbRef;
  TimeOfDay time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('remainders');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add Task to Remain",
          style: TextStyle(
            fontFamily: 'Arimo',
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  TextFormField(
                    autofocus: false,
                    controller: usertitleController,
                    style: TextStyle(fontFamily: 'Arimo'),
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      usertitleController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.title,
                        color: Color.fromRGBO(77, 0, 114, 1),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Enter the title here",
                      hintStyle: TextStyle(fontFamily: 'Arimo'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: null,
                    autofocus: false,
                    controller: userdescController,
                    style: TextStyle(fontFamily: 'Arimo'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("please enter the Description");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userdescController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.description,
                        color: Color.fromRGBO(77, 0, 114, 1),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 50),
                      hintText: "Description of the Task",
                      hintStyle: TextStyle(fontFamily: 'Arimo'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: userdateController,
                    autofocus: false,
                    style: TextStyle(fontFamily: 'Arimo'),
                    onTap: () async {
                      DateTime? pickdate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 0)),
                        lastDate: DateTime(2050),
                      );
                      if (pickdate != null) {
                        setState(() {
                          userdateController.text =
                              DateFormat('dd-MM-yyyy').format(pickdate);
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
                      userdateController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Color.fromRGBO(77, 0, 114, 1),
                      ),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color.fromRGBO(77, 0, 114, 1),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "date",
                      hintStyle: TextStyle(fontFamily: 'Arimo'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: timeinput,
                    style: TextStyle(
                      fontFamily: 'Arimo',
                    ),
                    keyboardType: TextInputType.number,
                    onTap: () async {
                      TimeOfDay? picktime = await showTimePicker(
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
                      if (picktime != null) {
                        setState(() {
                          timeinput.text = picktime.format(context);
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
                      timeinput.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      prefixIcon: Icon(
                        Icons.access_time,
                        color: Color.fromRGBO(77, 0, 114, 1),
                      ),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color.fromRGBO(77, 0, 114, 1),
                      ),
                      hintText: "Time",
                      hintStyle: TextStyle(
                        fontFamily: 'Arimo',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      // Call the method to send the notification to FCM

                      Map<String, String> remainders = {
                        'title': usertitleController.text,
                        'desc': userdescController.text,
                        'Date': userdateController.text,
                        'time': timeinput.text
                      };

                      dbRef.push().set(remainders);
                    },
                    child: Text('Add Task'),
                    color: Colors.red,
                    textColor: Colors.white,
                    minWidth: 300,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


// ...
}
