import 'package:flutter/material.dart';
import 'package:flutter_getx_testing/shared/routing.dart';
import 'package:get/get.dart';
import 'package:speed_up_flutter/speed_up_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              (Get.height / 7).h,
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Image.asset('assets/img/btc.png'),
              ),
              const Text(
                'Login to Wallet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 42,
                ),
              ),
              40.h,
              TextField(
                key: const ValueKey('usernameInput'),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Username',
                ),
                onChanged: (username) {},
              ),
              10.h,
              TextField(
                key: const ValueKey('passwordInput'),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Password',
                ),
                onChanged: (password) {},
              ),
              10.h,
              ElevatedButton(
                onPressed: () => Get.offAllNamed(AppRoutes.main),
                child: SizedBox(
                  height: 40,
                  child: Center(
                    child: const Text('Login'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
