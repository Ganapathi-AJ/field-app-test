import 'package:fieldapp_functionality/login/redirect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'loginscreen';
  String? email;
  String? password;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/login_page.png',
                          ),
                          fit: BoxFit.cover)),
                ),
                // Positioned(
                //     top: 35,
                //     left: 20,
                //     child: InkWell(
                //       onTap: () {
                //         Navigator.pushReplacement(context,
                //             MaterialPageRoute(builder: (context) {
                //           return NewInitialScreen();
                //         }));
                //       },
                //       splashColor: Colors.white,
                //       child: Icon(
                //         Icons.arrow_back,
                //         color: Colors.white,
                //       ),
                //     )),
                Positioned(
                    top: 135,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please Enter\nYour \'Credentials\' ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '(We promise they\'re safe) ',
                          style: TextStyle(
                              color: Colors.grey.shade300, fontSize: 15),
                        ),
                      ],
                    )),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 250, 250, 255),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45))),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Form(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                TextFormField(
                  validator: (value) {
                    if (email == null || email!.isEmpty) {
                      return 'Invalid Input: should contain name and surname';
                    }
                    if (email!.length < 5) {
                      return 'Invalid Input: should contain name and surname';
                    }

                    // Check for valid name format (e.g., at least two words separated by space)
                    // final nameParts = fullName!.split(' ');
                    // if (nameParts.length < 2) {
                    //   return 'Please enter a valid full name (first and last name)';
                    // }
                  },
                  onSaved: (newValue) {
                    email = newValue;
                  },
                  onFieldSubmitted: (value) {
                    email = value;
                  },
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey.shade400,
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Color.fromARGB(255, 240, 240, 240),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    // if (fullName == null || fullName!.isEmpty) {
                    //   return 'Invalid Input: should contain name and surname';
                    // }
                    // if (fullName!.length < 5) {
                    //   return 'Invalid Input: should contain name and surname';
                    // }

                    // // Check for valid name format (e.g., at least two words separated by space)
                    // final nameParts = fullName!.split(' ');
                    // if (nameParts.length < 2) {
                    //   return 'Please enter a valid full name (first and last name)';
                    // }
                  },
                  onSaved: (newValue) {
                    password = newValue;
                  },
                  onFieldSubmitted: (value) {
                    password = value;
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline_sharp,
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey.shade500,
                          )),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Color.fromARGB(255, 240, 240, 240),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style:
                          TextStyle(color: Color.fromARGB(255, 127, 128, 131)),
                    )),
              ]),
            )),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Sign in the user with email and password
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email!,
                    password: password!,
                  );

                  // If successful, navigate to the redirect route
                  Navigator.of(context)
                      .pushReplacementNamed(Redirect.routeName);
                } catch (e) {
                  print(e.toString());
                  // Show error message if the sign-in fails
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  elevation: 1,
                  backgroundColor: Color.fromARGB(255, 41, 51, 65),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 150)),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Divider(
                  indent: 80,
                )),
                Text(
                  '  OR  ',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                Expanded(
                    child: Divider(
                  endIndent: 80,
                ))
              ],
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () async {
                // try {
                //   await GoogleAuthServer().signInWithGoo();
                // } catch (e) {
                //   print(e);
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text('Try again: ' + e.toString())));
                // }
                // Navigator.of(context).pushReplacementNamed(Redirect.routeName);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/google.png',
                    scale: 55,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Continue with Google',
                    style: TextStyle(color: Colors.grey.shade600),
                  )
                ],
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      side: BorderSide(color: Colors.grey.shade300)),
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.grey.shade100,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
            )
          ],
        ),
      ),
    );
  }
}
