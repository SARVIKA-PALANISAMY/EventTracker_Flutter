import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final String dummyUsername = 'user'; 
  final String dummyPassword = 'password'; 

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: ClipOval(
                child: Container(
                  width: 100, 
                  height: 100, 
                  color: Colors.white, 
                  child: Image.asset(
                    'images/logo.jpg', 
                    fit: BoxFit.cover, 
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0), // Adding space between logo and text fields

            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String enteredUsername = usernameController.text.trim();
                String enteredPassword = passwordController.text.trim();

                if (enteredUsername == dummyUsername &&
                    enteredPassword == dummyPassword) {
                  // Navigate to InsertRecord page upon successful login
                  Navigator.pushNamed(context, '/insertRecord');
                } else {
                  // Show error message for invalid credentials
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid username or password'),
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}