// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:jolly_podcast/app_startup.dart';
// import 'package:jolly_podcast/auth/cubit/auth_cubit.dart';
// import 'package:jolly_podcast/auth/cubit/auth_state.dart';
// import 'package:jolly_podcast/auth/route/routes.dart';
// import 'package:jolly_podcast/utils_folder/app_colors.dart';
// import 'package:jolly_podcast/utils_folder/custom_button.dart';
// import 'package:jolly_podcast/utils_folder/custom_text_form_field.dart';
// import 'package:jolly_podcast/utils_folder/input_validation.dart';
// import 'package:jolly_podcast/utils_folder/navigation_key.dart';
// import 'package:jolly_podcast/utils_folder/show_loader.dart';
// import 'package:jolly_podcast/utils_folder/snack_bar.dart';
// import 'package:jolly_podcast/utils_folder/text_style.dart';

// class RequestOtpPage extends StatefulWidget {
//   const RequestOtpPage({super.key});

//   @override
//   State<RequestOtpPage> createState() => _RequestOtpPageState();
// }

// class _RequestOtpPageState extends State<RequestOtpPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _phoneController = TextEditingController();
//   bool _isButtonClicked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // 🔹 Background image
//           Image.asset(
//             "assets/images/onboardingBackground.png",
//             fit: BoxFit.cover,
//           ),

//           BlocConsumer<AuthCubit, AuthState>(
//             bloc: getIt<AuthCubit>(),
//             listener: (context, state) {
//               if (state is AuthLoading) {
//                 showCustomLoader(context);
//               }

//               if (state is OtpSent) {
//                 navigatorKey.currentState!.pop(); // close loader

//                 customSnackBar(
//                   "OTP sent successfully",
//                   context,
//                   2,
//                   colorPassed: AppColors.color1,
//                 );

//                 navigatorKey.currentState!.pushNamed(
//                   AuthRoutes.verifyOtp,
//                   arguments: {"phone": state.phone},
//                 );
//               }

//               if (state is AuthError) {
//                 navigatorKey.currentState!.pop(); // close loader

//                 customSnackBar(
//                   state.message,
//                   context,
//                   2,
//                   colorPassed: AppColors.color12,
//                 );
//               }
//             },
//             builder: (context, state) {
//               return SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   autovalidateMode: _isButtonClicked
//                       ? AutovalidateMode.always
//                       : AutovalidateMode.disabled,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.w),
//                     child: Column(
//                       children: [
//                         SizedBox(height: 335.h),

//                         // 🔹 Logo
//                         Image.asset(
//                           "assets/images/onboardingLogo.png",
//                           width: 210.w,
//                           height: 108.h,
//                         ),

//                         SizedBox(height: 0.h),

//                         // 🔹 Title
//                         Text(
//                           "PODCASTS FOR\nAFRICA, BY AFRICANS",
//                           textAlign: TextAlign.center,
//                           style: customTextStyle(
//                             context,
//                             26,
//                             AppColors.color2,
//                             FontWeight.w800,
//                             1.3,
//                           ),
//                         ),

//                         SizedBox(height: 10.h),

//                         // 🔹 Phone input
//                         CustomTextFormField(
//                           controller: _phoneController,
//                           keyboardType: TextInputType.phone,
//                           maxLength: 11,
//                           counterText: "",
//                           hintText: "Enter your phone number",
//                           prefixIcon: Image.asset(
//                             "assets/images/prefixIcon.png",
//                           ),
//                           validator: Validator.validateMobile,
//                           borderRadiusPassed: 27,
//                           contentPadding: EdgeInsets.symmetric(
//                             vertical: 14.h,
//                             horizontal: 14.w,
//                           ),
//                         ),

//                         SizedBox(height: 25.h),

//                         // 🔹 Continue button
//                         CustomButton(
//                           text: "Continue",
//                           containerColor: AppColors.color33,
//                           onClick: _onContinue,
//                         ),

//                         SizedBox(height: 10.h),

//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, AuthRoutes.login);
//                           },
//                           child: Text(
//                             "Already have an account, Login",
//                             textAlign: TextAlign.center,
//                             style: customTextStyle(
//                               context,
//                               12,
//                               AppColors.color2,
//                               FontWeight.w400,
//                               1.3,
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 15.h),

//                         Text(
//                           "By proceeding, you agree and accept our T&C",
//                           textAlign: TextAlign.center,
//                           style: customTextStyle(
//                             context,
//                             12,
//                             AppColors.color2,
//                             FontWeight.w100,
//                             1.3,
//                           ),
//                         ),

//                         SizedBox(height: 35.h),

//                         Text(
//                           "BECOME A PODCAST CREATOR",
//                           textAlign: TextAlign.center,
//                           style: customTextStyle(
//                             context,
//                             15,
//                             AppColors.color2,
//                             FontWeight.w900,
//                             1.3,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void _onContinue() {
//     FocusScope.of(context).unfocus();
//     setState(() => _isButtonClicked = true);

//     if (!_formKey.currentState!.validate()) return;

//     final phone = _phoneController.text.trim();

//     getIt<AuthCubit>().requestOtp(phone: phone);
//   }
// }
