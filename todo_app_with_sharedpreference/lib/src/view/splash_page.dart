import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_with_sharedpreference/common/constants/media_query_extension.dart';
import 'package:todo_app_with_sharedpreference/src/routes/go_route.dart';

import '../../common/constants/global_variable.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), (){
      context.pushNamed(AppRoute.mainPage);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    //  backgroundColor: darkColorScheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png",width: context.width() *0.3,height: context.height() * 0.15,filterQuality: FilterQuality.high,),
              SizedBox(height:context.height() * 0.01 ,),
              Text("Todo App",style: textTheme(context).bodyLarge )
            ],
          ),
        )
    );
  }
}
