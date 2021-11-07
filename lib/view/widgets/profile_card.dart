import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tajeer/models/user_model.dart';
import 'package:tajeer/view/widgets/round_image.dart';

class ProfileCard extends StatelessWidget {
  final UserModel userModel;

  ProfileCard({this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 370,
      child: Stack(
        children: [
          Container(
            height: 250,
            margin: EdgeInsets.only(top: 55),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 16, right: 16),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    userModel.fistName + " " + userModel.lastName,
                    style: TextStyle(
                        color: Color.fromRGBO(51, 51, 51, 1),
                        fontSize: 16,
                        height: 1.5),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    userModel.phone,
                    style: TextStyle(
                      color: Color.fromRGBO(114, 112, 112, 1),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    userModel.email,
                    style: TextStyle(
                      color: Color.fromRGBO(114, 112, 112, 1),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Opacity(
                    opacity: 0.15,
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff56ccf2), Color(0xff2f80ed)],
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Published',
                            style: TextStyle(
                                color: Color.fromRGBO(114, 112, 112, 1),
                                fontSize: 14,
                                height: 1.5 /*PERCENT not supported*/
                                ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                  "assets/likes_icon.png",
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '1.5k',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                    height: 1.5),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Hides',
                            style: TextStyle(
                              color: Color.fromRGBO(114, 112, 112, 1),
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                  "assets/followers_icon.png",
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '0.5k',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                    height: 1.5),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Rating',
                            style: TextStyle(
                              color: Color.fromRGBO(114, 112, 112, 1),
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                  "assets/star.png",
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '4.8',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                    height: 1.5),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 120,
              width: 120,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 4)),
              child: RoundImage(
                imageUrl: userModel.image,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
