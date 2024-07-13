import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/network/local/cash_helper.dart';
import '../../Data/network/remote/dio.dart';
import '../../Modules/business/business_screen.dart';
import '../../Modules/science/science_screen.dart';
import '../../Modules/sports/sports_screen.dart';
import 'states_news.dart';


class CubitNews extends Cubit<StatesNews> {
  CubitNews(): super(Inizlization());

  static CubitNews get(context) => BlocProvider.of(context);

  bool isDark = false;
  changeThemesDark({bool? formShared}) {
    emit(LoadingThemesDark());
    if (formShared != null) {
      isDark = formShared;
      emit(ChangeThemesDark());
    }
    else {
      isDark = !isDark;
      CashHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemesDark());
      });
    }
  }



  List<BottomNavigationBarItem> bottomNav = const [
    BottomNavigationBarItem(icon: Icon(Icons.add_business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_bar), label: 'Sports'),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];
  int currentIndex = 0;
  List<Widget> screens = [
    const BusinessScreen(),
    const SportssScreen(),
    const ScienceScreen(),
  ];

  void buttonNavigator(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(ChangeIndexBottomNavigator());
  }

  //
  List<dynamic> businessNews = [];

  void getBusiness() {
    emit(LoadingGetBusinessNews());
    if (businessNews.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apikey': '70c84b24f0b3416da405361d79906233',
      }).then((value) {
        businessNews = value.data['articles'];
        emit(GetBusinessNews());
      }).catchError((onError) {
        emit(CatchErrorGetBusinessNews(onError.toString()));
      });
    } else {
      emit(GetBusinessNews());
    }
  }

  //
  List<dynamic> sportsNews = [];

  void getSports() {
    emit(LoadingGetSportsNews());
    if (sportsNews.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apikey': '70c84b24f0b3416da405361d79906233',
      }).then((value) {
        sportsNews = value.data['articles'];
        emit(GetSportsNews());
      }).catchError((onError) {
        emit(CatchErrorGetSportsNews(onError.toString()));
      });
    } else {
      emit(GetSportsNews());
    }
  }

  //
  List<dynamic> scienceNews = [];

  void getScience() {
    emit(LoadingGetScienceNews());
    if (scienceNews.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apikey': '70c84b24f0b3416da405361d79906233',
      }).then((value) {
        scienceNews = value.data['articles'];
        emit(GetScienceNews());
      }).catchError((onError) {
        emit(CatchErrorGetScienceNews(onError.toString()));
      });
    } else {
      emit(GetScienceNews());
    }
  }

  //
  List<dynamic> searchNews = [];

  void getSearch(String value) {
    emit(LoadingGetSearchNews());
    searchNews = [];
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': value,
          'apikey': '70c84b24f0b3416da405361d79906233',
        }).then((value) {
      searchNews = value.data['articles'];
      emit(GetSearchNews());
    }).catchError((onError) {
      emit(CatchErrorGetSearchNews(onError.toString()));
    });
  }
}
