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
class LoginSuccessfulState extends StartingStates{}
class LoginErrorState extends StartingStates{}

///////////////update//////////////////
class UpdateProfileLoadingState extends StartingStates{}
class UpdateProfileSuccessfulState extends StartingStates{}
class UpdateProfileErrorState extends StartingStates{}

///////////////signup//////////////////
class SignUpLoadingState extends StartingStates{}
class SignUpSuccessfulState extends StartingStates{}
class SignUpErrorState extends StartingStates{}

////////////////logOut///////////////////
class LogoutLoadingState extends StartingStates{}
class LogoutSuccessfulState extends StartingStates{}
class LogoutErrorState extends StartingStates{}

/////////////user/////////////////////
