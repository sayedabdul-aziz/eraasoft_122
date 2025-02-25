import 'package:bookia/core/extenstions/navigation.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/auth/data/models/request/register_params.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_states.dart';
import 'package:bookia/feature/auth/presentation/page/login_screen.dart';
import 'package:bookia/feature/home/presentation/page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/icons/back.png",
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?", style: getSmallTextStyle()),
                TextButton(
                  onPressed: () {
                    context.pushReplacement(RegisterScreen());
                  },
                  child: Text(
                    "Sign Up",
                    style: getSmallTextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
          ),
          body: BlocConsumer<AuthCubit, AuthStates>(
            listener: blocListener,
            builder: blocBuilder,
          )),
    );
  }

  void blocListener(BuildContext context, AuthStates state) {
    if (state is AuthErrorState) {
      Navigator.pop(context);
      showErrorToast(context, state.error);
    } else if (state is AuthSuccessState) {
      context.pushAndRemoveUntil(HomeScreen());
    } else if (state is AuthLoadingState) {
      showLoadingDialog(context);
    }
  }

  Widget blocBuilder(BuildContext context, AuthStates state) {
    var cubit = context.read<AuthCubit>();
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                Text(
                  "Hello! Register to get started!",
                  style: getHeadlineTextStyle(),
                ),
                Gap(30),
                TextFormField(
                  controller: cubit.nameController,
                  decoration: InputDecoration(
                    hintText: "Username",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                Gap(15),
                TextFormField(
                  controller: cubit.emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                Gap(15),
                TextFormField(
                  obscureText: true,
                  controller: cubit.passwordController,
                  decoration: InputDecoration(
                      hintText: "Password",
                      suffixIconConstraints: BoxConstraints(
                          maxHeight: 30,
                          maxWidth: 40,
                          minHeight: 30,
                          minWidth: 30),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(
                          'assets/icons/eye.svg',
                        ),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Gap(15),
                TextFormField(
                  obscureText: true,
                  controller: cubit.passwordConfirmationController,
                  decoration: InputDecoration(
                      hintText: "Confirm password",
                      suffixIconConstraints: BoxConstraints(
                          maxHeight: 30,
                          maxWidth: 40,
                          minHeight: 30,
                          minWidth: 30),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(
                          'assets/icons/eye.svg',
                        ),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your confirm password';
                    }
                    return null;
                  },
                ),
                Gap(30),
                CustomButton(
                  text: "Register",
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.register(RegisterParams(
                        name: cubit.nameController.text,
                        email: cubit.emailController.text,
                        password: cubit.passwordController.text,
                        passwordConfirmation:
                            cubit.passwordConfirmationController.text,
                      ));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SafeArea footer(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an account?", style: getSmallTextStyle()),
          TextButton(
            onPressed: () {
              context.pushReplacement(LoginScreen());
            },
            child: Text(
              "Login Now!",
              style: getSmallTextStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
