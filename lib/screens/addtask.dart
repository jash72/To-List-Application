import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  TextEditingController userTitleController = TextEditingController();
  TextEditingController userDescController = TextEditingController();
  TextEditingController userDateController = TextEditingController();
  TextEditingController timeInput = TextEditingController();
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
            fontFamily: 'Primo',
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
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: [
                SizedBox(height: 5),
                TextFormField(
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
                      color: Color.fromRGBO(77, 0, 114, 1),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Enter the title here",
                    hintStyle: TextStyle(fontFamily: 'Primo'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                      color: Color.fromRGBO(77, 0, 114, 1),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 50),
                    hintText: "Description of the Task",
                    hintStyle: TextStyle(fontFamily: 'Primo'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                      color: Color.fromRGBO(77, 0, 114, 1),
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromRGBO(77, 0, 114, 1),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "date",
                    hintStyle: TextStyle(fontFamily: 'Primo'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                      color: Color.fromRGBO(77, 0, 114, 1),
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromRGBO(77, 0, 114, 1),
                    ),
                    hintText: "Time",
                    hintStyle: TextStyle(
                      fontFamily: 'Primo',
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
                      'title': userTitleController.text,
                      'desc': userDescController.text,
                      'Date': userDateController.text,
                      'time': timeInput.text
                    };

                    dbRef.push().set(remainders);
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  minWidth: 300,
                  height: 40,
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


// ...
}
