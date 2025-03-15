import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/enum/load_status.dart';
import '../../model/login.dart';
import '../../http/API.dart';

import '../../widget/noti_bar.dart';
import '../../widget/tabBar_view.dart';
import 'login_cubit.dart';
class LoginScreen extends StatelessWidget {
  static const String route = "LoginScreen";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            Navigator.pushReplacementNamed(context, PageMain.route);
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
            color: Color(0xFFFFEEDB),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 60, 32, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Image(
                    image: AssetImage("assets/images/logo.png"),
                    height: 150,
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
                  const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().login(
                    _username,
                    _password,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFFFFEEDB),
                ),
                child: const Text("Login", style: TextStyle(fontSize: 16, color: Color(0xFF96705B),)),
              ),
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
        prefixIcon: Icon(icon, color: Color(0xFF96705B)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onChanged: onChanged,
    );
  }


  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                // Điều hướng sang màn hình quên mật khẩu
              },
              child: const Text(
                "Forgot password?",
                style: TextStyle(color: Color(0xFF96705B)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'RegisterScreen');
              },
              child: const Text(
                "Not have account?",
                style: TextStyle(color: Color(0xFF96705B)),
              ),
            ),
          ],
        ),
        const Divider(color: Colors.grey, thickness: 1),
        const SizedBox(height: 10),
        const Text("Or login with", style: TextStyle(color: Color(0xFF96705B))),
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