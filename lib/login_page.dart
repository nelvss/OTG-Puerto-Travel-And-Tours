import 'package:flutter/material.dart';
import 'package:booking_system2/admin_dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false; // Add loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF87CEEB), // Sky blue
                  Color(0xFF4169E1), // Royal blue
                  Color(0xFF1E90FF), // Dodger blue
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/Logo.png',
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      Text(
                        'Welcome to Paradise',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      SizedBox(
                        width: 350,
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Text(
                                    'Admin Login',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4169E1),
                                    ),
                                  ),
                                  SizedBox(height: 16),

                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Color(0xFF4169E1),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Color(0xFF4169E1),
                                          width: 2,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Color(
                                        0xFFF0F8FF,
                                      ), // Alice blue
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your username';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 20),

                                  // Email field
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Color(0xFF4169E1),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Color(0xFF4169E1),
                                          width: 2,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Color(
                                        0xFFF0F8FF,
                                      ), // Alice blue
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                      ).hasMatch(value)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 20),

                                  // Password field
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Color(0xFF4169E1),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Color(0xFF4169E1),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Color(0xFF4169E1),
                                          width: 2,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFF0F8FF),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 12),

                                  // Forgot password
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: Color(0xFF4169E1),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 20),

                                  // Login button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: _isLoading
                                          ? null
                                          : () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                await Future.delayed(
                                                  Duration(seconds: 3),
                                                );
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                Navigator.of(
                                                  context,
                                                ).pushReplacementNamed(
                                                  '/admin',
                                                );
                                              }
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(
                                          0xFFFF6B35,
                                        ), // Coral orange
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 3,
                                      ),
                                      child: _isLoading
                                          ? SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                      Color
                                                    >(Colors.white),
                                                strokeWidth: 3,
                                              ),
                                            )
                                          : Text(
                                              'Login',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ),

                                  SizedBox(height: 20),

                                  // Sign up link
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account? ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'OTG Puerto Galera Travel And Tours',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/admin': (context) => AdminDashboard(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
