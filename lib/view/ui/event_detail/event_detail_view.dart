import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_app/app/static_info.dart';
import 'package:event_app/models/blog_model.dart';
import 'package:event_app/view/widgets/rect_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventDetailView extends StatelessWidget {
  final BlogModel blogModel;

  EventDetailView({this.blogModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Event Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: blogModel.id,
              child: RectImage(
                imageUrl: blogModel.image,
                width: MediaQuery.of(context).size.width,
                height: 300,
              ),
            ),
            Divider(
              height: 2,
              thickness: 3,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      blogModel.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: Get.width,
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Date: ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat("E-d-MMM-y").format(blogModel.timeOfBlog) +
                            " to " +
                            DateFormat("E-d-MMM-y")
                                .format(blogModel.timeOfBlog),
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Start Time: ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat(DateFormat.HOUR_MINUTE)
                            .format(blogModel.timeOfBlog),
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Price: ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "100.0 USD",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  if (StaticInfo.userModel.userType != "admin")
                    Container(
                      width: Get.width * 0.7,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(27.5)),
                      child: Center(
                        child: Text(
                          "Join Now",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
