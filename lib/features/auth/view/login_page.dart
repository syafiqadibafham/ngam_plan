import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ngam_plan/features/auth/cubit/auth_cubit.dart';
import 'package:ngam_plan/src/widgets/app_screen.dart';
import 'package:ngam_plan/src/widgets/button.dart';
import 'package:ngam_plan/src/widgets/password_input.dart';
import 'package:ngam_plan/src/widgets/text_input.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: 'Login',
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            context.go('/');
          } else if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'An error occurred',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == AuthStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInput(
                  controller: _emailController,
                  labelText: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                PasswordInput(
                  controller: _passwordController,
                ),
                const SizedBox(height: 16),
                Button(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().signInWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                          );
                    }
                  },
                  label: 'Login',
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     context.read<AuthCubit>().signInWithGoogle();
                //   },
                //   child: const Text('Sign in with Google'),
                // ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.go('/register');
                  },
                  child: const Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
