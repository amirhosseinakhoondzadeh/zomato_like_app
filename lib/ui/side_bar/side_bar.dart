import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zomato_like_app/blocs/side_bar/side_bar_bloc.dart';
import 'package:zomato_like_app/core/styles/colors.dart';
import 'package:zomato_like_app/dependency_injection/injection_container.dart';
import 'package:zomato_like_app/ui/side_bar/side_bar_custom_clipper.dart';
import 'package:zomato_like_app/ui/side_bar/side_bar_item_widget.dart';

class SideBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<SideBarBloc>(),
        child: SideBarWidget(),
      ),
    );
  }
}

class SideBarWidget extends StatefulWidget {
  @override
  _SideBarWidgetState createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> with AfterLayoutMixin {
  final LabeledGlobalKey _homeKey = LabeledGlobalKey("homeKey");

  final LabeledGlobalKey _invoiceKey = LabeledGlobalKey("invoiceKey");

  final LabeledGlobalKey _notificationKey = LabeledGlobalKey("notificationKey");

  final LabeledGlobalKey _myProfileKey = LabeledGlobalKey("myProfileKey");

  @override
  Widget build(BuildContext context) {
    return BlocListener<SideBarBloc, SideBarState>(
      listener: (context, state) {},
      child: BlocBuilder<SideBarBloc, SideBarState>(
        buildWhen: (previous, current) =>
            previous.currentIndex != current.currentIndex,
        builder: (context, state) => Stack(
          children: [
            Positioned(
              left: 0,
              width: 90,
              bottom: 0,
              top: 0,
              child: ClipPath(
                clipper: SideBarCustomClipper(
                    startYPosition: state?.currentIndexStartYPosition == null
                        ? 0
                        : state.currentIndexStartYPosition - 35,
                    endYPosition: state?.currentIndexStartYPosition == null
                        ? 0
                        : state.currentIndexStartYPosition + 85),
                child: Container(
                  color: app_side_bar_color,
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 0,
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    height: 50,
                  ),
                  Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(
                        "assets/icons/ic_dashboard.svg",
                        allowDrawingOutsideViewBox: false,
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(
                        "assets/icons/ic_search.svg",
                        allowDrawingOutsideViewBox: false,
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SideBarItemWidget(
                          key: _myProfileKey,
                          title: "My Profile",
                          isSelected: state.currentIndex == 3,
                          onTapped: () {
                            final RenderBox renderBox =
                                _myProfileKey.currentContext.findRenderObject();
                            BlocProvider.of<SideBarBloc>(context).add(
                                SideBarTabChanged(
                                    index: 3,
                                    currentIndexStartYPosition: renderBox
                                        .localToGlobal(Offset.zero)
                                        .dy));
                          },
                        ),
                        Spacer(),
                        SideBarItemWidget(
                          key: _notificationKey,
                          title: "Notification",
                          isSelected: state.currentIndex == 2,
                          onTapped: () {
                            final RenderBox renderBox = _notificationKey
                                .currentContext
                                .findRenderObject();
                            BlocProvider.of<SideBarBloc>(context).add(
                                SideBarTabChanged(
                                    index: 2,
                                    currentIndexStartYPosition: renderBox
                                        .localToGlobal(Offset.zero)
                                        .dy));
                          },
                        ),
                        Spacer(),
                        SideBarItemWidget(
                          key: _invoiceKey,
                          title: "Invoice",
                          isSelected: state.currentIndex == 1,
                          onTapped: () {
                            final RenderBox renderBox =
                                _invoiceKey.currentContext.findRenderObject();
                            BlocProvider.of<SideBarBloc>(context).add(
                                SideBarTabChanged(
                                    index: 1,
                                    currentIndexStartYPosition: renderBox
                                        .localToGlobal(Offset.zero)
                                        .dy));
                          },
                        ),
                        Spacer(),
                        SideBarItemWidget(
                          key: _homeKey,
                          title: "Home",
                          isSelected: state.currentIndex == 0,
                          onTapped: () {
                            final RenderBox renderBox =
                                _homeKey.currentContext.findRenderObject();
                            BlocProvider.of<SideBarBloc>(context).add(
                                SideBarTabChanged(
                                    index: 0,
                                    currentIndexStartYPosition: renderBox
                                        .localToGlobal(Offset.zero)
                                        .dy));
                          },
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(
                        "assets/icons/ic_cart.svg",
                        allowDrawingOutsideViewBox: false,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    final RenderBox renderBox = _homeKey.currentContext.findRenderObject();
    BlocProvider.of<SideBarBloc>(context).add(SlideBarInitialized(
        index: 0,
        currentIndexStartYPosition: renderBox.localToGlobal(Offset.zero).dy));
  }
}
