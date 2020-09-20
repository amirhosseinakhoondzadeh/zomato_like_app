import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zomato_like_app/core/styles/colors.dart';
import 'package:zomato_like_app/entities/restaurant_entity.dart';

class ListItem extends StatelessWidget {
  final VoidCallback onTapped;
  final RestaurantEntity item;

  ListItem({@required this.onTapped, @required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        width: 184,
        height: 198,
        margin: const EdgeInsets.only(right: 24),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              width: 168,
              height: 190,
              child: Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(top: 8, right: 8),
                        width: 40,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(2.0),
                            bottomLeft: Radius.circular(20.0),
                          ),
                          color: const Color(0xff99adff),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              "assets/icons/ic_like.svg",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 18, right: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item.currency ?? ""}${item.price}",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: const Color(0xff365eff),
                                  fontWeight: FontWeight.w600),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            height: 4,
                          ),
                          Text(
                            item.name ?? "",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff373737),
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            height: 4,
                          ),
                          Text(
                            item.description ?? "",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 10,
                                  color: const Color(0xff656565),
                                  fontWeight: FontWeight.w400),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1a000000),
                      offset: Offset(8, 16),
                      blurRadius: 32,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                  imageUrl: item?.imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                    child: Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                      color: Colors.grey[100],
                      child: Icon(
                        Icons.error,
                        color: app_side_bar_selected,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
