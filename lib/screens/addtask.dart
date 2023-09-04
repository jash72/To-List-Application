import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remainder_jash/screens/modifytask.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:remainder_jash/screens/theme.dart';
import 'package:remainder_jash/screens/theme_services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  final  userTitleController = TextEditingController();
  final  userDescController = TextEditingController();
  final userDateController = TextEditingController();
  final timeInput = TextEditingController();
  final userStatusController = TextEditingController();
  late DatabaseReference dbRef;
  TimeOfDay time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('remainders');
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'required';
            } else {
              return null;
            }
          },
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
          child: Form(
            child: Column(
              children: [
                ClipRRect(
                    child: Image.asset("assets/img_3.png",
                      fit: BoxFit.fill,
                      height: 150,
                      width: 150,
                    )),
                SizedBox(height: 70),
                taskField,
                const SizedBox(height: 30,),
                desc,
                const SizedBox(height: 30,),
                Date,
                const SizedBox(height: 30,),
                Time,
                const SizedBox(height: 30,),
                const SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () async {

                        showDialog(context: context, builder: (context)
                        {
                          return AlertDialog(
                            content: Container(
                              height: 200,
                              child:Column(

                                children: [

                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:[
                                        Text(''),
                                        InkWell(
                                          child:
                                          Icon(Icons.close,color: Colors.redAccent,),
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchData()));
                                          },
                                        ),

                                      ]
                                  ),

                                  SizedBox(height: 15),
                                  Text("Goal Added",style: TextStyle(fontSize: 18,fontFamily: 'Arimo',color:Color.fromRGBO(
                                      0, 0, 0, 1.0), ),textAlign: TextAlign.center,),
                                  SizedBox(height: 15),
                                  Image.asset('assets/img_4.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                  SizedBox(height: 15,),
                                  Text("successfully",style: TextStyle(fontSize: 19,fontFamily: 'Arimo',color:Color.fromRGBO(
                                      0, 0, 0, 1.0), ),textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          );
                        }
                        );
                        Map<String, String> remainders = {
                          'title': userTitleController.text,
                          'desc': userDescController.text,
                          'Date': userDateController.text,
                          'time': timeInput.text,
                          'status': 'incompleted', // Set the default value
                        };

                        dbRef.push().set(remainders);
                      },
                      color: Color.fromRGBO(225, 155, 164, 1),
                      textColor: Colors.black,
                      minWidth: 70,
                      height: 40,
                      child: Text('Add Task'),
                    ),
                    MaterialButton(
                      onPressed:(){


                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchData()));

                    } ,
                      color: Colors.red,
                      textColor: Colors.white,
                      minWidth: 70,
                      height: 40,
                      child: Text('cancel'),
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
