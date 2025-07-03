import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../http/API.dart';
import '../login_cubit.dart';
class RegisterScreen extends StatelessWidget {
  static const String route = "/register";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<API>()),
      child: Page(),
    );
  }
}

class Page extends StatelessWidget {
  String _username = "";
  String _password = "";
  String _email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            Navigator.pushReplacementNamed(context, '/main');
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Lỗi: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const CircularProgressIndicator();
          }
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.blue.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 60, 32, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Image(
                    image: AssetImage("assets/images/logo.png"),
                    height: 200,
                  ),
                  const SizedBox(height: 40),
                  _buildTextField(
                    hintText: "Username",
                    icon: Icons.account_circle,
                    onChanged: (value) => _username = value,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    hintText: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                    onChanged: (value) => _password = value,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    hintText: "Email@gmail.com",
                    icon: Icons.mail,
                    onChanged: (value) => _email = value,
                  ),
                  const SizedBox(height: 30),
                  _buildRegisterButton(context),
                  const SizedBox(height: 20),
                  _buildFooter(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed:  () {
        context.read<LoginCubit>().register(
          _username,
          _password,
          _email,
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,

      ),
      child: const Text("Register", style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'LoginScreen');
              },
              child: const Text(
                "Signin",
                style: TextStyle(color: Colors.white),
              ),
            ),

        const Divider(color: Colors.grey, thickness: 1),
        const SizedBox(height: 10),
        const Text("Or login with", style: TextStyle(color: Colors.white)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialLoginButton(Icons.facebook, Colors.blue),
            const SizedBox(width: 20),
            _buildSocialLoginButton(Icons.g_mobiledata, Colors.red),
            const SizedBox(width: 20),
            _buildSocialLoginButton(Icons.clear, Colors.black),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialLoginButton(IconData icon, Color color) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}