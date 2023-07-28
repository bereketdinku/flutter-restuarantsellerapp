import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/controller/home_controller.dart';
import 'package:seller_app/views/home_screen/home_screen.dart';
import 'package:seller_app/views/orders/orders_screen.dart';
import 'package:seller_app/views/products/product_screen.dart';
import 'package:seller_app/views/settings/setting_screen.dart';
import 'package:seller_app/widgets/text_stryle.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      HomeScreen(),
      ProductScreen(),
      OrdersScreen(),
      SettingsScreen()
    ];
    var bottomNavbar = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            width: 24,
            color: darkgrey,
          ),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            width: 24,
            color: darkgrey,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSetting,
            width: 24,
            color: darkgrey,
          ),
          label: settings),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          items: bottomNavbar,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkgrey,
        ),
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: boldText(text: dashboard, color: fontGrey, size: 18.0),
      // ),
      body: Obx(
        () => Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
