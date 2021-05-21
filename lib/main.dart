import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool submitValid = false;

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void verify() {
    print(EmailAuth.validate(
        receiverMail: _emailcontroller.value.text,
        userOTP: _otpcontroller.value.text));
  }

  ///a void funtion to send the OTP to the user
  void sendOtp() async {
    EmailAuth.sessionName = "Chat App";
    bool result =
        await EmailAuth.sendOtp(receiverMail: _emailcontroller.value.text);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Email Auth Free'),
        ),
        body: Center(
            child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _emailcontroller,
              ),
              Card(
                margin: const EdgeInsets.only(top: 20),
                elevation: 6,
                child: Container(
                  height: 50,
                  width: 200,
                  color: Colors.green[400],
                  child: GestureDetector(
                    onTap: sendOtp,
                    child: const Center(
                      child: Text(
                        "Request OTP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ///A dynamically rendering text field
              (submitValid)
                  ? TextField(
                      controller: _otpcontroller,
                    )
                  : Container(height: 1),
              (submitValid)
                  ? Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 50,
                      width: 200,
                      color: Colors.green[400],
                      child: GestureDetector(
                        onTap: verify,
                        child: const Center(
                          child: Text(
                            "Verify",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(height: 1)
            ],
          ),
        )),
      ),
    );
  }
}
