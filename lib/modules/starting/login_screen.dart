import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shop_app/shared/Network/local/cached_helper.dart';
import 'package:shop_app/shared/cubit/theme_cubit/app_theme_cubit.dart';

import '../../shared/cubit/starting_cubit/starting_cubit.dart';
import '../../shared/cubit/starting_cubit/starting_states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<String?> userLogin(LoginData data, context)async{
    // debugPrint('email: ${data.name}, Password: ${data.password}');
    return await StartingCubit.get(context).userLogin(email: data.name, password: data.password).then((value) {
      debugPrint('UserLoginData: ${StartingCubit.get(context).loginData?.message}');
      StartingCubit.get(context).loginData!.status ? CacheHelper.saveData('doneLogin', false) : null;
      return StartingCubit.get(context).loginData!.status ? null : StartingCubit.get(context).loginData?.message;
    });
  }

  Future<String>? userRegister(SignupData data, context) {
    debugPrint('Signup Email: ${data.name}, Password: ${data.password}, phoneNumber: ${''}, phoneNumber: ${''}, phoneNumber: ${''}');
      return null;
  }
  // Future<String> _recoverPassword(String name, context) {
  //   debugPrint('Name: $name');
  //   return Future.delayed(loginTime).then((_){
  //     return !users.containsKey(name) ? 'User not exists' : '';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => StartingCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocConsumer<StartingCubit, StartingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          StartingCubit cubit = StartingCubit.get(context);
          return FlutterLogin(
            title: 'Login',
            onLogin: (data) {
              cubit.changeForgetPassword(false);
              return userLogin(data, context);
            },
            onSignup: (data) {
              cubit.changeForgetPassword(true);
              return userRegister(data, context);
            },
            hideForgotPasswordButton: cubit.forgetPassword,
            onRecoverPassword: (data)=> null,
                // _recoverPassword(data, context),
            onSubmitAnimationCompleted: ()  => Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (route) => false),
            additionalSignupFields: [UserFormField(keyName: 'Full Name')],

            theme: LoginTheme(
              titleStyle: TextStyle(fontWeight: FontWeight.w500, shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset.zero)]),
                primaryColor: const Color.fromARGB(255, 20, 127, 180),
                cardTheme: const CardTheme(
                    elevation: 20,
                    color: Color.fromARGB(255, 255, 255, 255)
                )
            ),
            // loginProviders: <LoginProvider>[
            //   LoginProvider(
            //     icon: Icon(FaIcon(FontAwesomeIcons.google),
            //     label: 'Google'),
            //     callback: () async {
            //       debugPrint('start google sign in');
            //       await Future.delayed(loginTime);
            //       debugPrint('stop google sign in');
            //       return null;
            //     },
            //   ),
            //   LoginProvider(
            //     icon: Icon(FaIcon(FontAwesomeIcons.facebookF)),
            //     label: 'Facebook',
            //     callback: () async {
            //       debugPrint('start facebook sign in');
            //       await Future.delayed(loginTime);
            //       debugPrint('stop facebook sign in');
            //       return null;
            //     },
            //   ),
            //   LoginProvider(
            //     icon: Icon(FaIcon(FontAwesomeIcons.linkedinIn)),
            //     callback: () async {
            //       debugPrint('start linkdin sign in');
            //       await Future.delayed(loginTime);
            //       debugPrint('stop linkdin sign in');
            //       return null;
            //     },
            //   ),
            //   LoginProvider(
            //     icon: Icon(FaIcon(FontAwesomeIcon.githubAlt)),
            //     callback: () async {
            //       debugPrint('start github sign in');
            //       await Future.delayed(loginTime);
            //       debugPrint('stop github sign in');
            //       return null;
            //     },
            //   ),
            // ],
          );
        }
      ),
    );
  }
}
