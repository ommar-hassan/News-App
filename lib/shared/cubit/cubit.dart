import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business/buisness_screen.dart';
import 'package:news/modules/science/science_screen.dart';
import 'package:news/modules/sports/sports_screen.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =
  [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business_center_sharp),
      label: "Business"
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_soccer_rounded),
        label: "Sports"
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.science_rounded),
        label: "Science"
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusiness(){
    if(business.isEmpty){
      emit(GetBusinessNewsLoadingState());
      DioHelper.getData(url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'business',
            'apiKey': 'e7098e958cef41299acab2907858c14d'
          }
      ).then((value) {
        business = value.data['articles'];

        emit(GetBusinessNewsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(GetBusinessNewsErrorState(error.toString()));
      });
    }else{
      emit(GetBusinessNewsSuccessState());
    }

  }

  void getSports(){
    if(sports.isEmpty){
      emit(GetSportsNewsLoadingState());
      DioHelper.getData(url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'sports',
            'apiKey': 'e7098e958cef41299acab2907858c14d'
          }
      ).then((value) {
        sports = value.data['articles'];

        emit(GetSportsNewsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(GetSportsNewsErrorState(error.toString()));
      });
    }else{
      emit(GetSportsNewsSuccessState());
    }

  }

  void getScience(){
    if(science.isEmpty){
      emit(GetScienceNewsLoadingState());
      DioHelper.getData(url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'science',
            'apiKey': 'e7098e958cef41299acab2907858c14d'
          }
      ).then((value) {
        science = value.data['articles'];

        emit(GetScienceNewsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(GetScienceNewsErrorState(error.toString()));
      });
    }else{
      emit(GetScienceNewsSuccessState());
    }

  }

  void getSearch(String value){
    emit(GetSearchNewsLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': value,
          'apiKey': 'e7098e958cef41299acab2907858c14d'
        }
    ).then((value) {
      search = value.data['articles'];

      emit(GetSearchNewsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetSearchNewsErrorState(error.toString()));
    });

  }

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    switch (currentIndex) {
      case 0:
        emit(BusinessNewsState());
        break;
      case 1:
        getSports();
        emit(SportsNewsState());
        break;
      case 2:
        getScience();
        emit(ScienceNewsState());
        break;
    }
  }

  bool isDark = false;

  void changeTheme({bool? sharedIsDark}){
    if(sharedIsDark != null) {
      isDark = sharedIsDark;
      emit(SwitchAppThemeState());
    }else {
      isDark = !isDark;
      CacheHelper.setMode(key: 'isDark', value: isDark).then((value) =>
        emit(SwitchAppThemeState()) );
    }
  }

}