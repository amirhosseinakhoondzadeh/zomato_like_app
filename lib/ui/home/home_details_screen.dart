import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zomato_like_app/core/styles/colors.dart';
import 'package:zomato_like_app/entities/restaurant_entity.dart';

class HomeDetailsScreen extends StatelessWidget {
  final RestaurantEntity item;

  HomeDetailsScreen(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.93,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _lastLayout(context),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.13,
            left: 0,
            right: 0,
            child: _middleLayout(context),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.25,
            top: 0,
            left: 0,
            right: 0,
            child: _topLayout(context),
          ),
        ],
      ),
    );
  }

  Widget _topLayout(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(44),
          topRight: Radius.circular(44),
          bottomRight: Radius.circular(11),
          bottomLeft: Radius.circular(44),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 8,
          ),
          Container(
            width: 24,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.5),
              color: const Color(0xff365eff),
            ),
          ),
          Container(
            height: 4,
          ),
          Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 16),
              child: LikeButtonWidget()),
          Container(
            height: 16,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
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
              PlayWidget()
            ],
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
                left: 32, right: MediaQuery.of(context).size.width * 0.3),
            child: DescriptionsWidget(
              title: item?.name ?? "",
              shortDescription: item?.description ?? "",
              currency: item.currency,
              price: item.price.toString(),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _middleLayout(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.only(
        left: 32,
        right: 32,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(11),
          bottomLeft: Radius.circular(44),
        ),
        color: app_side_bar_color,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: QuantityWidget(),
      ),
    );
  }

  Widget _lastLayout(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding:
          EdgeInsets.only(bottom: (MediaQuery.of(context).size.height * 0.07)),
      color: app_side_bar_selected,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: // Adobe XD layer: 'Add to card' (text)
            Text(
          'Add to card',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: const Color(0xffffffff),
              height: 1.3333333333333333,
            ),
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

/// Play Button
class PlayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100.0),
          topRight: Radius.circular(32.0),
          bottomRight: Radius.circular(100.0),
          bottomLeft: Radius.circular(32.0),
        ),
        color: const Color(0x99373737),
      ),
      child: Center(
        child: SizedBox(
          width: 10,
          height: 16,
          child: SvgPicture.string(
            '<svg viewBox="7.9 4.0 10.0 16.0" ><path transform="translate(7.87, 4.0)" d="M 9.778535842895508 8.493793487548828 C 9.918789863586426 8.375452041625977 9.999500274658203 8.204324722290039 9.999995231628418 8.024245262145996 C 10.00049018859863 7.844165325164795 9.920721054077148 7.672625541687012 9.781119346618652 7.553563594818115 L 1.072293400764465 0.1555073708295822 C 0.8816385865211487 -0.006591226439923048 0.6105725169181824 -0.045630794018507 0.3794079720973969 0.05571639910340309 C 0.1482434570789337 0.1570635885000229 -0.0001858084578998387 0.3800183832645416 6.267201229093189e-07 0.6256221532821655 L 6.267201229093189e-07 15.37422275543213 C -0.0002484316355548799 15.619553565979 0.1477976590394974 15.8423490524292 0.3785530030727386 15.94390869140625 C 0.6093083024024963 16.04546737670898 0.8801144361495972 16.00701522827148 1.071001529693604 15.84558868408203 L 9.778535842895508 8.493793487548828 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

/// Like Button
class LikeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32.0),
          bottomLeft: Radius.circular(32.0),
        ),
        color: const Color(0xff99adff),
      ),
      child: Center(
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
    );
  }
}

/// Description Widget
class DescriptionsWidget extends StatelessWidget {
  final String currency;
  final String price;
  final String title;
  final String shortDescription;

  DescriptionsWidget(
      {@required this.currency,
      @required this.price,
      @required this.title,
      @required this.shortDescription});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "$currency$price",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 24,
                color: const Color(0xff365eff),
                fontWeight: FontWeight.w600),
          ),
          textAlign: TextAlign.left,
        ),
        Container(
          height: 8,
        ),
        // Adobe XD layer: 'Chicken Hamburger' (text)
        Text(
          title ?? "",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: const Color(0xff373737),
            ),
          ),
          textAlign: TextAlign.left,
        ),
        Container(
          height: 14,
        ),
        Text(
          shortDescription ?? "",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: const Color(0xff656565),
              height: 1.5,
            ),
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

/// Quantity Widget
class QuantityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Quality',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: const Color(0xff656565),
              ),
            ),
            textAlign: TextAlign.left,
          ),
          Spacer(),
          GestureDetector(
            onTap: _onMinusTapped,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: const Color(0xffffffff),
              ),
              child: Center(
                child: SizedBox(
                  width: 16,
                  height: 2,
                  child: SvgPicture.asset(
                    "assets/icons/ic_minus.svg",
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 24,
          ),
          Text(
            '1',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: const Color(0xff656565),
              ),
            ),
            textAlign: TextAlign.left,
          ),
          Container(
            width: 24,
          ),
          GestureDetector(
            onTap: _onPlusTapped,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: const Color(0xffffffff),
              ),
              child: Center(
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: SvgPicture.asset(
                    "assets/icons/ic_plus.svg",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMinusTapped() {}

  void _onPlusTapped() {}
}
