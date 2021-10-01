import 'package:event_app/app/constants.dart';
import 'package:event_app/app/static_info.dart';
import 'package:event_app/models/user_model.dart';
import 'package:event_app/view/ui/admin_home/admin_home_view.dart';
import 'package:event_app/view/ui/signup/signup_view.dart';
import 'package:event_app/view/widgets/filled_button.dart';
import 'package:event_app/view/widgets/inputfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Scaffold(
              body: ModalProgressHUD(
                inAsyncCall: model.loading,
                child: Column(
                  children: [
                    Image.asset("assets/top_image.png"),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: hMargin),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.15,
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'LOGIN',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 24,
                                    ),
                                  )),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              InputFieldWidget(
                                hint: "Email",
                                prefixIcon: Icons.person,
                                controller: emailCon,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              InputFieldWidget(
                                hint: "Password",
                                prefixIcon: Icons.lock,
                                obscure: true,
                                controller: passwordCon,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Transform.scale(
                                          scale: 0.7,
                                          child: CupertinoSwitch(
                                              value: model.isRemember,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              onChanged: model.setIsRemember),
                                        ),
                                        Text(
                                          'Remember me',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //   'Forgot Password?',
                                  //   style: TextStyle(
                                  //     color: Theme.of(context).accentColor,
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.normal,
                                  //   ),
                                  // )
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              InkWell(
                                onTap: () {
                                  StaticInfo.userModel =
                                      UserModel(userType: "admin");
                                  Get.to(() => AdminHomeView());
                                },
                                child: FilledButton(
                                  title: "LOGIN",
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.05,
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    'Don’t have an account?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Get.to(SignUpView()),
                                    child: Text(
                                      ' Register now',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
