import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rlink_test/features/Auth/bloc/auth_bloc.dart';
import 'package:rlink_test/src/components/app_button.dart';
import 'package:rlink_test/src/components/custom_text_field.dart';
import 'package:rlink_test/src/components/loading_widget.dart';
import 'package:rlink_test/src/di/services_locator.dart';
import 'package:rlink_test/src/extensions/iterable_extension.dart';
import 'package:rlink_test/src/routing/routes.dart';
import 'package:rlink_test/src/themes/app_colors.dart';
import 'package:rlink_test/src/themes/app_theme.dart';
import 'package:rlink_test/src/utils/widget_extension.dart';
import 'package:rlink_test/src/validation/email_validator.dart';
import 'package:rlink_test/src/validation/password_validator.dart';
import 'package:rlink_test/src/validation/phone_validator.dart';
import 'package:rlink_test/src/validation/required_validator.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Create New Account',style: textTheme.displaySmall,),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (_) => sl.get<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is SuccessState){

              Navigator.pushReplacementNamed(context, Routes.homeRoute);;
            }
          },
          builder: (context, state) {
            var bloc = context.read<AuthBloc>();
            return LoadingWidget(
              isLoading: state.isLoading,
              child: Form(
                  key: bloc.registerFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(radius: 65.r,
                            //if there is no selected image yet use a placholder
                            backgroundImage: bloc.selectedImage==null ? const NetworkImage("https://test.quantumgate.io/storage/12/3.png"):
                              FileImage(bloc.selectedImage,) as ImageProvider,
                            ).inkWell(() {bloc.pickImage();}),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.light, // Change to the desired color
                                ),
                                padding: REdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 24.0.r,
                                ),
                              ),)
                          ],
                        ),
                        TextFieldWithTitle(
                          title: 'Name',
                          widget: TextFormFieldWidget(
                            // keyboardType: TextInputType.number,
                            controller: bloc.nameController,
                            validator:RequiredValidator(),
                            label: 'enter your full name',
                            prefix:const Icon(Icons.person),
                          ),
                        ),
                        TextFieldWithTitle(
                          title: 'E-mail Address',
                          widget: TextFormFieldWidget(
                            // keyboardType: TextInputType.number,
                            controller: bloc.emailController,
                            validator:EmailValidator(),
                            label: 'enter your email address',
                            prefix:const Icon(Icons.email_outlined),
                          ),
                        ),
                        TextFieldWithTitle(
                          title: 'Phone Number',
                          widget: TextFormFieldWidget(
                             keyboardType: TextInputType.number,
                            controller: bloc.phoneController,
                            validator:PhoneValidator(),
                            label: 'enter your phone number',
                            prefix:const Icon(Icons.call_outlined),
                          ),
                        ),
                        TextFieldWithTitle(
                          title: 'Password',
                          widget: TextFormFieldWidget(

                            prefix: const Icon(Icons.lock_outlined),
                            secure: true,
                            hideText: true,
                            controller: bloc.passwordController,
                            label: 'enter your password',
                            validator: PasswordValidator(),
                          ),
                        ),
                        TextFieldWithTitle(
                          title: 'Password Confirmation',
                          widget: TextFormFieldWidget(

                            prefix: const Icon(Icons.lock_outlined),
                            secure: true,
                            hideText: true,
                            controller: bloc.passwordConfController,
                            label: 'enter your password again',
                            validator: PasswordValidator(),
                          ),
                        ),
                        AppButton(
                          bgColor: AppColors.primary,
                          title: 'Register',
                          onPressed: () {
                            if (bloc.registerFormKey.currentState!.validate()&&bloc.passwordController.text==bloc.passwordConfController.text) {
                              bloc.add(RegisterEvent());
                            }
                          },
                        ),
                        const Divider().pSymmetric(v: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'already have an account with  ',
                              style: textTheme.bodyLarge,
                            ),

                            Text(
                              'R-link',
                              style: textTheme.bodyLarge!.copyWith(color: AppColors.primary),
                            ),
                            Text(
                              ' ?',
                              style: textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        AppButton(
                          bgColor: AppColors.white,
                          textColor: AppColors.primary,
                          title: 'log in to your account',
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, Routes.loginRoute);

                          },
                        ),
                      ].addSpaces(height: 16.h).toList(), // to add sizes between children
                    ).pSymmetric(h: 16.w), //to add padding
                  )),
            );
          },
        ),
      ),
    );
  }
}
