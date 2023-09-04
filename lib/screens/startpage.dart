import 'package:flutter/material.dart';

import 'login.dart';


class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(25),
      color: Color.fromRGBO(225, 155, 164, 1.0),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        splashColor: Colors.black.withOpacity(0.2),
        onPressed:(){


          Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage ()));

        } ,
        child: Text("Get Started",textAlign: TextAlign.center,
          style:TextStyle(fontSize: 15,fontFamily:'Arimo',color: Colors.black,fontWeight: FontWeight.bold) ,
        ),
      ),

    );
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          children: <Widget>[
            SizedBox(height: 190),
            ClipRRect(
                child: Image.asset("assets/img_2.png",
                  fit: BoxFit.fill,
                  height: 350,
                  width: 450,
                )),
            Text('Get Things Done With ReMain',style: TextStyle(fontSize: 20,fontFamily: 'Arimo',fontWeight: FontWeight.w900,color: Colors.black),textAlign: TextAlign.center,),
            SizedBox(height: 10),
            SizedBox(height: 120),
            loginButton,

          ],
        ),

      ),
    );
  }
}
