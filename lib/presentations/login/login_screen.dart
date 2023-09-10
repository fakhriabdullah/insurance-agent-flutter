import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_agent_flutter/bloc/login/login_cubit.dart';
import 'package:insurance_agent_flutter/presentations/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text(state.message ?? "Wrong username / password"),
                    ),
                  );
                } else if (state is LoginSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 38),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      // style: const TextStyle(color: Colors .white),
                      controller: username,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Username",
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          suffixIcon: InkResponse(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          )),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: (state is LoginLoading)
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context
                                    .read<LoginCubit>()
                                    .login(username.text, password.text);
                              }
                            },
                      child: (state is LoginLoading)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Login"),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
