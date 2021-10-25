import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/changeFavoritesModel.dart';
import 'package:shop_app/models/categoryModel.dart';
import 'package:shop_app/models/favouritesModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/modules/category/categories.dart';
import 'package:shop_app/modules/favourite/favourite.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/component/componant.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/States.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';
import 'package:shop_app/shared/network/remote/helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ShopChangeThemeState());
    } else {
      isDark = !isDark;
      CacheHelper.setData(key: 'isDark', value: isDark).then((value) {
        emit(ShopChangeThemeState());
      });
    }
  }

  int selectedIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingScreen()
  ];

  void changeBottomScreen(int index) {
    selectedIndex = index;
    emit(ShopChangeNavBarState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      print(error);
    });
  }

  Categories CategoryModel;
  void getCategoryData() {
    DioHelper.getData(url: GET_CATEGORY).then((value) {
      CategoryModel = Categories.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      emit(ShopCategoriesErrorState());
    });
  }

  ChangeFavoritesModel favoriteModel;
  void changeFavourites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      favoriteModel = ChangeFavoritesModel.fromJson(value.data);
      print(favoriteModel);
      if (!favoriteModel.status) {
        favorites[productId] = !favorites[productId];
      }else{
        getFavData();
      }
      showToast(message: favoriteModel.message, time: Toast.LENGTH_SHORT);
      emit(ShopChangeFavoritesSuccessState(favoriteModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopChangeFavoritesErrorState());
    });
  }

  FavouritesModel favouritesModel;
  void getFavData() {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(
        url: FAVORITES,
        token: token).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(ShopFavoritesSuccessState());
    }).catchError((error) {
      emit(ShopFavoritesErrorState());
    });
  }
  LoginModel userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: USER,token: token).then((value) {
      userModel =LoginModel.fromJson(value.data);
      emit(ShopUserDataSuccessState(userModel));
    }).catchError((error) {
      emit(ShopUserDataErrorState());
    });
  }

  void updateUserData({
    @required String name,
    @required String phone,
    @required String email
}) {
    emit(ShopLoadingUpdateDataState());
    DioHelper.putData(
        url: UPDATE,
        token: token,
      data: {
          'name':name,
          'email':email,
          'phone':phone
      }
    ).then((value) {
      userModel =LoginModel.fromJson(value.data);
      emit(ShopUpdateDataSuccessState(userModel));
    }).catchError((error) {
      emit(ShopUpdateDataErrorState());
    });
  }
}
