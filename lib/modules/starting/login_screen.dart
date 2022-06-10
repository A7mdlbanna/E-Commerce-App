import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shop_app/shared/Network/local/cached_helper.dart';
import 'package:shop_app/shared/cubit/theme_cubit/app_theme_cubit.dart';

import '../../shared/constants.dart';
import '../../shared/cubit/app_cubit/app_cubit.dart';
import '../../shared/cubit/app_cubit/app_states.dart';
import '../../shared/cubit/starting_cubit/starting_cubit.dart';
import '../../shared/cubit/starting_cubit/starting_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  String savedEmail = '';
  String savedPassword = '';
  late BuildContext ctx;
  Future<String?> userLogin(LoginData data, context, ctx)async{
    // debugPrint('email: ${data.name}, Password: ${data.password}');
    return await StartingCubit.get(context).userLogin(email: data.name, password: data.password).then((value) {
        StartingCubit.get(context).loginData!.status ? {
          CacheHelper.saveData('doneLogin', true),
          CacheHelper.saveData('password', data.password),
          AppCubit.get(context).getHomeData(),
          AppCubit.get(context).getFavItems(context: ctx),
          AppCubit.get(context).getCartItems(context: ctx, showCartSnack: false),
          AppCubit.get(context).getCategoriesItems(),
          savedEmail = data.name,
          savedPassword = data.password,
        } : null;
      return StartingCubit.get(context).loginData!.status ? null : StartingCubit.get(context).loginData?.message;
    });
  }

  Future<String?> userRegister(SignupData data, context) async{
      debugPrint('Signup Email: ${data.name}, Password: ${data.password}, name: ${data.additionalSignupData!['Full Name']}, phoneNumber: ${data.additionalSignupData!['Phone Number']}');
    return await StartingCubit.get(context).userSignUp(name: data.additionalSignupData!['Full Name'], email: data.name, password: data.password, phone: data.additionalSignupData!['Phone Number']).then((value) {
      return StartingCubit.get(context).signUpData!.status ? null : StartingCubit.get(context).signUpData?.message;
      });
  }
  // Future<String> _recoverPassword(String name, context) {
  //   debugPrint('Name: $name');
  //   return Future.delayed(loginTime).then((_){
  //     return !users.containsKey(name) ? 'User not exists' : '';
  //   });
  // }

  @override
  Widget build(BuildContext ctx) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return FlutterLogin(
          title: 'Login',
          onLogin: (data) {
            // cubit.changeForgetPassword(false);
            return userLogin(data, context, ctx);
          },
          onSignup: (data) {
            // cubit.changeForgetPassword(true);
            return userRegister(data, context);
          },
          savedEmail: savedEmail,
          savedPassword: savedPassword,
          loginAfterSignUp: false,
          // hideForgotPasswordButton: cubit.forgetPassword,
          onRecoverPassword: (data) => null, // _recoverPassword(data, context),
          onSubmitAnimationCompleted: () {
            debugPrint(home.toString());
            debugPrint(fav.toString());
            debugPrint(cart.toString());
            return home && fav
              ? Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (route) => false)
              : const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 8, 60, 82),
                ),
              );
          },
          additionalSignupFields: const [
            UserFormField(keyName: 'Full Name'),
            UserFormField(keyName: 'Phone Number', icon: Icon(Icons.phone_android), userType: LoginUserType.phone),
          ],

          theme: LoginTheme(
              titleStyle: const TextStyle(fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(color: Colors.black,
                        blurRadius: 1.0,
                        offset: Offset.zero)
                  ]),
              primaryColor: const Color.fromARGB(255, 20, 127, 180),
              cardTheme: const CardTheme(
                  elevation: 20,
                  color: Color.fromARGB(255, 204, 204, 204)
              )
          ),
          loginProviders: <LoginProvider>[
            LoginProvider(
              icon: Icons.add,
              callback: () async {
                debugPrint('start google sign in');
                await Future.delayed(const Duration(milliseconds: 1000));
                debugPrint('stop google sign in');
                return null;
              },
            ),
            // LoginProvider(
            //   icon: Icon(FaIcon(FontAwesomeIcons.facebookF)),
            //   label: 'Facebook',
            //   callback: () async {
            //     debugPrint('start facebook sign in');
            //     await Future.delayed(loginTime);
            //     debugPrint('stop facebook sign in');
            //     return null;
            //   },
            // ),
            // LoginProvider(
            //   icon: Icon(FaIcon(FontAwesomeIcons.linkedinIn)),
            //   callback: () async {
            //     debugPrint('start linkdin sign in');
            //     await Future.delayed(loginTime);
            //     debugPrint('stop linkdin sign in');
            //     return null;
            //   },
            // ),
            // LoginProvider(
            //   icon: Icon(FaIcon(FontAwesomeIcon.githubAlt)),
            //   callback: () async {
            //     debugPrint('start github sign in');
            //     await Future.delayed(loginTime);
            //     debugPrint('stop github sign in');
            //     return null;
            //   },
            // ),
          ],
        );
      }
    );
  }
}
