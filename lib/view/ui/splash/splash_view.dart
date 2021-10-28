import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:tajeer/app/constants.dart';
import 'package:tajeer/view/ui/splash/splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Image.asset("assets/top_image.png"),
            Spacer(),
            Container(
                margin: EdgeInsets.symmetric(horizontal: hMargin),
                child:
                    Hero(tag: "logo", child: Image.asset("assets/logo.png"))),
            Spacer(),
          ],
        ),
      ),
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initialise()),
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
