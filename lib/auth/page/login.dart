import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jolly_podcast/auth/cubit/auth_cubit.dart';
import 'package:jolly_podcast/auth/cubit/auth_state.dart';
import 'package:jolly_podcast/auth/route/routes.dart';
import 'package:jolly_podcast/dashboard/route/routes.dart';
import 'package:jolly_podcast/utils_folder/app_colors.dart';
import 'package:jolly_podcast/utils_folder/custom_button.dart';
import 'package:jolly_podcast/utils_folder/custom_text_form_field.dart';
import 'package:jolly_podcast/utils_folder/input_validation.dart';
import 'package:jolly_podcast/utils_folder/phone_utils.dart';
import 'package:jolly_podcast/utils_folder/text_style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginView(); // ✅ use global AuthCubit from main.dart
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final ScrollController _scrollController = ScrollController();

  bool _isButtonClicked = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/onboardingBackground.png",
              fit: BoxFit.fill,
            ),
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              log('AUTH STATE => ${state.runtimeType}');

              if (state is AuthLoading) {
                setState(() => _isLoading = true);
              }

              if (state is AuthAuthenticated) {
                setState(() => _isLoading = false);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  Navigator.pushReplacementNamed(
                    context,
                    DashboardRoutes.mainScreen,
                  );
                });
              }

              if (state is AuthError) {
                setState(() => _isLoading = false);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SafeArea(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.fromLTRB(
                      16.w,
                      0,
                      16.w,
                      keyboard + 16.h,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60.h),

                        // ✅ Logo + text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/onboardingLogo.png",
                              width: 210.w,
                              height: 108.h,
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "PODCASTS FOR\nAFRICA, BY AFRICANS",
                              textAlign: TextAlign.center,
                              style: customTextStyle(
                                context,
                                26,
                                AppColors.color2,
                                FontWeight.w800,
                                1.3,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 60.h),

                        // ✅ Form block
                        Form(
                          key: _formKey,
                          autovalidateMode: _isButtonClicked
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                controller: _phoneController,
                                focusNode: _phoneFocus,
                                keyboardType: TextInputType.phone,
                                maxLength: 11,
                                counterText: "",
                                hintText: "Enter your phone number",
                                prefixIcon: Image.asset(
                                  "assets/images/prefixIcon.png",
                                ),
                                validator: Validator.validateMobile,
                                borderRadiusPassed: 27,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                  horizontal: 14.w,
                                ),
                                // onTap: () {
                                //   _scrollToBottom();
                                // },
                                onChanged: (_) {
                                  // optional
                                },
                              ),
                              SizedBox(height: 15.h),

                              CustomTextFormField(
                                controller: _passwordController,
                                focusNode: _passwordFocus,
                                obscureText: _obscurePassword,
                                keyboardType: TextInputType.text,
                                maxLength: 20,
                                counterText: "",
                                hintText: "Enter password",
                                validator: Validator.isPasswordValid,
                                borderRadiusPassed: 27,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                  horizontal: 14.w,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(
                                      () =>
                                          _obscurePassword = !_obscurePassword,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                ),

                                onTap: _scrollToBottom,
                              ),

                              SizedBox(height: 15.h),

                              _isLoading
                                  ? const CircularProgressIndicator()
                                  : CustomButton(
                                      text: "Login",
                                      containerColor: AppColors.color33,
                                      onClick: _onLogin,
                                    ),

                              SizedBox(height: 10.h),

                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AuthRoutes.requestOtpPage,
                                  );
                                },
                                child: Text(
                                  "Don't have an account, Signup",
                                  textAlign: TextAlign.center,
                                  style: customTextStyle(
                                    context,
                                    12,
                                    AppColors.color2,
                                    FontWeight.w400,
                                    1.3,
                                  ),
                                ),
                              ),

                              SizedBox(height: 12.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onLogin() {
    FocusScope.of(context).unfocus();
    setState(() => _isButtonClicked = true);

    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().login(
      phone: PhoneUtils.normalize(_phoneController.text),
      password: _passwordController.text.trim(),
    );
  }
}
