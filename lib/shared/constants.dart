import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:shop_app/shared/Network/local/cached_helper.dart';

String token = '';

bool onBoarding = true;
bool doneLogin = CacheHelper.getData(key: 'doneLogin')??false;
bool doneGetData = false;

bool home = false;
bool fav = false;
bool cart = false;
bool categories = false;

dynamic userImage;