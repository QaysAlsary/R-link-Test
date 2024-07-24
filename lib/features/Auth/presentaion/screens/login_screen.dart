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
import 'package:rlink_test/src/validation/password_validator.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Login',style: textTheme.displaySmall,),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (_) => sl.get<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
           if(state is SuccessState){
             // go to service_providers
             Navigator.pushReplacementNamed(context, Routes.homeRoute);
           }
          },
          builder: (context, state) {
            var bloc = context.read<AuthBloc>();
            return LoadingWidget( //widget to show progress indicator if there is loading
              isLoading: state.isLoading,
              child: Form(
                key: bloc.loginFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFieldWithTitle(
                          title: 'User Name',
                          widget: TextFormFieldWidget(
                           // keyboardType: TextInputType.number,
                            controller: bloc.userNameController,
                            validator:bloc.userNameValidator,
                            label: 'enter your email or phone number',
                            prefix:const Icon(Icons.email_outlined),
                          ),
                        ),
                        TextFieldWithTitle(
                          title: 'Password',
                          widget: TextFormFieldWidget(
                            prefixConstraint: const BoxConstraints(maxHeight: 24, maxWidth: 50),
                            prefix: const Icon(Icons.lock_outlined),
                            secure: true,
                            hideText: true,
                            controller: bloc.passwordController,
                            label: 'enter your password',
                            validator: PasswordValidator(),
                          ),
                        ),
                        AppButton(
                          bgColor: AppColors.primary,
                          title: 'Login',
                          onPressed: () {
                            if (bloc.loginFormKey.currentState!.validate()) {
                              //check if the input matches a phone mask then login with phone
                              //or login in with email cause the validator used to validate userName field
                              //accept only email or phone formats
                              if(bloc.phoneValidator.validSy(bloc.userNameController.text.trim())){
                                bloc.add(LoginWithPhoneEvent());
                                print('login in with phone');
                              }else{
                                bloc.add(LoginWithEmailEvent());
                                print('login in with email');
                              }
                            }
                          },
                        ),
                        const Divider().pSymmetric(v: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'new on ',
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
                          title: 'create new account',
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, Routes.registerRoute);
              
                          },
                        ),
                      ].addSpaces(height: 16.h).toList(), //to add sizes between children
                    ).pSymmetric(h: 16.w), // to add padding
                  )),
            );
          },
        ),
      ),
    );
  }
}
