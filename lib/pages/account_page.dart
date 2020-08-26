import 'package:animated_sidebar/navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget with NavigationState{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Account Page',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28.0),
      ),
    );
  }
}
