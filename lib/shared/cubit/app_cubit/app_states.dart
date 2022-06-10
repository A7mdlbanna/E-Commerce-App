abstract class AppStates{}

class AppInitialState extends AppStates{}

class HomeChangeIndexState extends AppStates{}

class HomeLoadingState extends AppStates{}
class HomeSuccessfulState extends AppStates{}
class HomeErrorState extends AppStates{}

class FavLoadingState extends AppStates{}
class FavSuccessfulState extends AppStates{}
class FavErrorState extends AppStates{}

class ChangeFavState extends AppStates{}
class ChangeFavIndexState extends AppStates{}

class CartLoadingState extends AppStates{}
class CartSuccessfulState extends AppStates{}
class CartErrorState extends AppStates{}

class CategoriesLoadingState extends AppStates{}
class CategoriesSuccessfulState extends AppStates{}
class CategoriesErrorState extends AppStates{}

class ChangeCartState extends AppStates{}
class ChangeCartIndexState extends AppStates{}


////////////////GetProfile///////////////////
class GetProfileLoadingState extends AppStates{}
class GetProfileSuccessfulState extends AppStates{}
class GetProfileErrorState extends AppStates{}

class GetImage extends AppStates{}

class ChangePic extends AppStates{}
