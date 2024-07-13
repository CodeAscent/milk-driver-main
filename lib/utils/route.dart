

import 'package:flutter/material.dart';
import 'package:water/screen/order_detail/order_detail.dart';
import 'package:water/screen/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;

    switch (settings.name) {
      case '/splash_screen':
        return MaterialPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        );
    
      case '/order_detail':
        return MaterialPageRoute(
          builder: (context) {
            return OrderDetails(orderData: args[0],orderHistory: args[1]);
          },
        );
    
      default: {

      //   if(settings.name != null && (settings.name!.contains('/order/'))){
      
      //   var id  = int.parse(settings.name!.split('/').last);

      //   return MaterialPageRoute(
      //     builder: (context) {
      //      return Loader(product: Product(id: int.parse(id.toString())));});
     
      //  } else {

         return MaterialPageRoute(
          builder: (context) {
           return const SplashScreen();
        });
       
      //  }
      }
     
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('Error'),
          ),
        );
      },
    );
  }
}
