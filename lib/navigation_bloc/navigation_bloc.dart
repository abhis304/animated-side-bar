import 'package:animated_sidebar/pages/HomePage.dart';
import 'package:animated_sidebar/pages/account_page.dart';
import 'package:animated_sidebar/pages/order_page.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

enum NavigationEvents {
  HomePageClickEvent,
  MyAccountPageClickEvent,
  MyOrdersPageClickEvent,
}

abstract class NavigationState {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationState> {
  @override
  NavigationState get initialState => HomePage();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyAccountPageClickEvent:
        yield AccountPage();
        break;
      case NavigationEvents.MyOrdersPageClickEvent:
        yield OrderPage();
        break;
    }
  }
}
