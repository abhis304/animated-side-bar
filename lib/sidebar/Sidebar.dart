import 'dart:async';

import 'package:animated_sidebar/navigation_bloc/navigation_bloc.dart';
import 'package:animated_sidebar/sidebar/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar>
    with SingleTickerProviderStateMixin<Sidebar> {
  final _animationDuration = const Duration(milliseconds: 500);
  AnimationController _animationController;
  StreamController<bool> isSideBarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);

    isSideBarOpenedStreamController = PublishSubject<bool>();

    isSideBarOpenedStream = isSideBarOpenedStreamController.stream;
    isSideBarOpenedSink = isSideBarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSideBarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;

    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSideBarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context, isSideBarOpened) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpened.data ? 0 : -screenWidth,
          right: isSideBarOpened.data ? 0 : screenWidth - 38,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  color: const Color(0XFF262AAA),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 45.0,
                      ),
                      ListTile(
                        title: Text(
                          'Abhi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Text(
                          'abhisondagar@gmail.com',
                          style: TextStyle(
                            color: Color(0xFF1BB5FD),
                            fontSize: 16.0,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Divider(
                        height: 30.0,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 30,
                        endIndent: 30,
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: 'home',
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.person,
                        title: 'My Account',
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAccountPageClickEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.shopping_basket,
                        title: 'My Order',
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyOrdersPageClickEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.card_giftcard,
                        title: 'Wishlist',
                      ),
                      Divider(
                        height: 30.0,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 30,
                        endIndent: 30,
                      ),
                      MenuItem(
                        icon: Icons.settings,
                        title: 'Settings',
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: 'Log out',
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuCliper(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _animationController.view,
                        color: Color(0xFF1BB5FD),
                        size: 20.0,
                      ),
                      width: 30.0,
                      height: 110,
                      color: Color(0XFF262AAA),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
