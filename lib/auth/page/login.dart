import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jolly_podcast/app_startup.dart';
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
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: const _LoginView(),
    );
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

  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  // keep UI fixed, but scroll inside form area when keyboard covers it
  final ScrollController _formScroll = ScrollController();

  bool _isButtonClicked = false;
  bool _isLoading = false;


  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _formScroll.dispose();
    super.dispose();
  }

  void _scrollToBottomOfForm() {
    // When keyboard opens and a field is focused, make sure bottom widgets are visible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_formScroll.hasClients) return;
      _formScroll.animateTo(
        _formScroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents ANY layout resizing
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
                  child: Stack(
                    children: [
                      /// CENTER CONTENT (logo + text)
                      Center(
                        child: Transform.translate(
                          offset: Offset(
                            0,
                            -170.h,
                          ), // move up (increase value to move higher)
                          child: Column(
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
                        ),
                      ),

                      /// BOTTOM FORM (fixed position; scrolls internally when keyboard covers it)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 435.h, // fixed height so it never shifts
                          child: SingleChildScrollView(
                            controller: _formScroll,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Form(
                              key: _formKey,
                              autovalidateMode: _isButtonClicked
                                  ? AutovalidateMode.always
                                  : AutovalidateMode.disabled,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
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
                                    onTap: _scrollToBottomOfForm,
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomTextFormField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocus,
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
                                    onTap: _scrollToBottomOfForm,
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
                                      "Already have an account, Login",
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
                          ),
                        ),
                      ),
                    ],
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
