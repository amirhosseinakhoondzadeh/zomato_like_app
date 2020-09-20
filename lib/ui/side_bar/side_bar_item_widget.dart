import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zomato_like_app/core/styles/text_styles.dart';

const Duration slideBarAnimationDuration = const Duration(milliseconds: 200);

class SideBarItemWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback onTapped;

  SideBarItemWidget(
      {Key key,
      @required this.isSelected,
      @required this.title,
      @required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: GestureDetector(
        onTap: onTapped,
        child: Column(
          children: [
            _titleWidget(),
            Container(
              height: 6,
            ),
            _dotIndicatorWidget(),
          ],
        ),
      ),
    );
  }

  Widget _dotIndicatorWidget() {
    return AnimatedContainer(
      duration: slideBarAnimationDuration,
      height: 6,
      width: 6,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : Colors.transparent),
    );
  }

  Widget _titleWidget() {
    return AnimatedDefaultTextStyle(
      child: Text(title),
      duration: slideBarAnimationDuration,
      style: isSelected
          ? GoogleFonts.playfairDisplay(textStyle: side_bar_selected_text_style)
          : GoogleFonts.roboto(textStyle: side_bar_unselected_text_style),
    );
  }
}
