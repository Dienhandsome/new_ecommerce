import 'package:final_ecommerce/screens/account_screen/account_screens.dart';
import 'package:final_ecommerce/screens/auth_ui/cart_screen/cart_screen.dart';
import 'package:final_ecommerce/screens/favorite_screen/favorite_screen.dart';
import 'package:final_ecommerce/screens/home/home.dart';
import 'package:final_ecommerce/screens/order_screen/order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomBottomBar extends StatefulWidget {
  
  const CustomBottomBar({final Key?  key,})
      : super(key: key);


  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  PersistentTabController _controller = PersistentTabController() ;
  final bool _hideNavBar = false;



  List<Widget> _buildScreens() => [
        const Home(),
        const CartScreen(),
        const OrderScreen(),
        const AccountScreen(),
        
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            inactiveIcon: const Icon(Icons.home_outlined), // khi push Icon mới có outline
            title: "Home",
            activeColorPrimary: Color.fromARGB(255, 229, 44, 66),
           // inactiveColorPrimary: Color.fromARGB(255, 152, 149, 149),
            inactiveColorSecondary: Color.fromARGB(255, 138, 136, 136)
            ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_cart),
           inactiveIcon: const Icon(Icons.shopping_cart_outlined),
          title: "Cart",
          activeColorPrimary: Color.fromARGB(255, 17, 101, 61),
          inactiveColorPrimary:Color.fromARGB(255, 152, 149, 149), // màu viền icon
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.favorite),
          inactiveIcon: const Icon(Icons.circle_outlined),
          title: "Orders",
          activeColorPrimary: Color.fromARGB(255, 227, 25, 146),// màu của action khi push 
          inactiveColorPrimary: Color.fromARGB(255, 152, 149, 149), // màu viền icon
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_outline),
          title: "Profile",
          activeColorPrimary: Color.fromARGB(255, 26, 121, 161), // màu của action khi push 
          inactiveColorPrimary:Color.fromARGB(255, 152, 149, 149), // màu viền icon
          ),
        
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(

        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,
          
          
          backgroundColor: Theme.of(context).primaryColor, // set sẵn từ file Theme
          hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle: NavBarStyle
              .style1, // Choose the nav bar style with this property
        ),
      );
}