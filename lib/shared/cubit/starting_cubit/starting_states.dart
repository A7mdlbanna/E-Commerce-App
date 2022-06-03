import 'package:shop_app/models/user_login.dart';

abstract class StartingStates{}

class StartingInitialState extends StartingStates{}


//////////onBoarding///////////
class ChangeOnBoardingPage extends StartingStates{}
class ChangeIsDelay extends StartingStates{}
class TimerCancel extends StartingStates{}

///////////////Login//////////////////
class LoginLoadingState extends StartingStates{}
class ChangeForgetPasswordState extends StartingStates{}
class LoginSuccessfulState extends StartingStates{
  late UserLoginData loginData;
  LoginSuccessfulState(this.loginData);
}
class LoginErrorState extends StartingStates{}
