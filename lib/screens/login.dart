import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey= GlobalKey<FormState>();
  final TextEditingController emailController =  TextEditingController();
  final TextEditingController passwordController =  TextEditingController();
  bool _isHidden=true;
  @override
  Widget build(BuildContext context) {

    final emailField = Material(
        elevation: 3,
        child:TextFormField(
          autofocus: false,
          controller: emailController,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.emailAddress,
          onSaved: (value)
          {
            emailController.text=value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon:Icon(Icons.mail,color: Colors.black,),
            hintText: "Enter Your Email",
            hintStyle: TextStyle(fontFamily: 'Arimo'),
            border: OutlineInputBorder(),

          ),
        )
    );
    final passwordField = Material(
        elevation: 3,
        child:TextFormField(
          autofocus: false,
          controller: passwordController,

          style: TextStyle(fontFamily: 'Arimo'),
          obscureText: _isHidden,
          onSaved: (value)
          {
            passwordController.text=value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline_rounded,color: Color.fromRGBO(
                0, 0, 0, 1.0),),
            hintText: "Password",
            hintStyle: TextStyle(fontFamily: 'Arimo'),
            suffixIcon: InkWell(
              onTap: _toggleView,
              child: Icon(
                _isHidden
                    ?Icons.visibility_off_outlined
                    :Icons.visibility_outlined,
                color: Color.fromRGBO(0, 0, 0, 1.0),
              ),
            ),
            border: OutlineInputBorder(),

          ),
        )
    );
    final loginButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(25),
      color: Color.fromRGBO(225, 155, 164, 1.0),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        splashColor: Colors.black.withOpacity(0.2),
        onPressed:(){


          Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchData()));

        } ,
        child: Text("Login",textAlign: TextAlign.center,
          style:TextStyle(fontSize: 15,fontFamily:'Arimo',color: Colors.black,fontWeight: FontWeight.bold) ,
        ),
      ),

    );
    return  Scaffold(
      appBar: AppBar(title:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:const [
            SizedBox(height: 5,),
            Row(
              children: [
                Text('Login',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.bold,color: Colors.black),),
                SizedBox(width: 2,),
                Icon(Icons.person_outline,color: Colors.black,)
              ],
            ),
            SizedBox(height: 2,),
          ]
      ),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.deepOrange[50],
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        shadowColor: Colors.white,
      ),
      backgroundColor: Color.fromRGBO(253, 233, 236, 1.0),
      body:  SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey ,
            child: Column(
              children: <Widget>[
                Text('Welcome Back!',style: TextStyle(fontSize: 25,fontFamily: 'Arimo',fontWeight: FontWeight.w900,color: Colors.black),textAlign: TextAlign.center,),
                Text("let's Help you to Remain!......",style: TextStyle(fontSize: 12,fontFamily: 'Arimo',fontWeight: FontWeight.w400,color: Colors.black),textAlign: TextAlign.center,),
                ClipRRect(
                    child: Image.asset("assets/img_1.png",
                      fit: BoxFit.fill,
                      height: 350,
                      width: 500,
                    )),
                SizedBox(height: 8),
                emailField,
                SizedBox(height: 25),
                passwordField,
                SizedBox(height: 17),
                Row(
                    children:[
                      SizedBox(width: 200,),
                      InkWell(child:Text('Forgot password?',style: TextStyle(fontFamily:'Arimo',color: Color.fromRGBO(225, 155, 164, 1.0),fontWeight: FontWeight.bold),),
                        onTap: (){},
                      ),
                    ]
                ),
                SizedBox(height: 15),
                loginButton,
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(child:
                    Divider(color: Colors.black38,indent: 10,endIndent: 10,),),
                    Text('Or',style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black38,fontFamily: 'Arimo'),),
                    Expanded(child:
                    Divider(color: Colors.black38,indent: 10,endIndent: 10))
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?",style: TextStyle(fontFamily:'Arimo',fontWeight:FontWeight.w900)),
                    GestureDetector(onTap: (){
                    },
                      child: Text(" SignUp",

                          style: TextStyle(color:Color.fromRGBO(225, 155, 164, 1.0),fontFamily:'Arimo',fontWeight: FontWeight.bold,fontSize: 14)),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),

      ),

    );

  }
  void _toggleView(){
    setState(() {
      _isHidden=!_isHidden;
    });
  }

}

