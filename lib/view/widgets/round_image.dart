import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final bool showBorder;
  final Color borderColor;
  final bool showShadow;

  RoundImage(
      {this.imageUrl,
      this.radius = 65.0,
      this.showBorder = false,
      this.borderColor,
      this.showShadow = true});

  @override
  Widget build(BuildContext context) {
    return (imageUrl == "" || imageUrl == null)
        ? Container(
            width: radius,
            height: radius,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x4cd3d1d8),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
                border: Border.all(color: Theme.of(context).primaryColor),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/person_placeholder.png"))),
          )
        : CachedNetworkImage(
            imageUrl: imageUrl,
            color: Colors.white,
            imageBuilder: (context, imageProvider) => Container(
              width: radius,
              height: radius,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
                border: Border.all(
                    color: showBorder
                        ? borderColor != null
                            ? borderColor
                            : Theme.of(context).primaryColor
                        : Colors.transparent),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x4cd3d1d8),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              width: radius,
              height: radius,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).accentColor),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x4cd3d1d8),
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/image-loader.gif"))),
            ),
            errorWidget: (context, url, error) => Container(
              width: radius,
              height: radius,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x4cd3d1d8),
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                  border: Border.all(color: Theme.of(context).accentColor),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/person_placeholder.png"))),
            ),
          );
  }
}
