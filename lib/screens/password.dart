import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      // Send password reset email to the user
      // Implement your own password reset logic here
      print('Reset password for: ${emailController.text}');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Password Reset'),
          content: Text('An email with password reset instructions has been sent to ${emailController.text}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailField = Material(
      elevation: 3,
      child: TextFormField(
        autofocus: false,
        controller: emailController,
        style: TextStyle(fontFamily: 'Arimo'),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty || !value.contains('@')) {
            return 'Please enter a valid email address.';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail, color: Colors.black),
          hintText: 'Enter your email',
          hintStyle: TextStyle(fontFamily: 'Arimo'),
          border: OutlineInputBorder(),
        ),
      ),
    );

    final resetButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(25),
      color: Color.fromRGBO(225, 155, 164, 1.0),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        minWidth: MediaQuery.of(context).size.width,
        splashColor: Colors.black.withOpacity(0.2),
        onPressed: _resetPassword,
        child: Text(
          'Reset Password',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Arimo',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      backgroundColor: Color.fromRGBO(253, 233, 236, 1.0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Forgot Your Password?',
                  style: TextStyle(fontSize: 25, fontFamily: 'Arimo', fontWeight: FontWeight.w900, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Enter your email address to reset your password.',
                  style: TextStyle(fontSize: 12, fontFamily: 'Arimo', fontWeight: FontWeight.w400, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                ClipRRect(
                  child: Image.asset(
                    'assets/img_2.png',
                    fit: BoxFit.fitWidth,
                    height: 350,
                    width: 500,
                  ),
                ),
                SizedBox(height: 8),
                emailField,
                SizedBox(height: 25),
                resetButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
