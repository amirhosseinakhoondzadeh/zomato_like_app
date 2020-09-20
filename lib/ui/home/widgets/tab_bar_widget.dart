import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zomato_like_app/blocs/home/home_bloc.dart';
import 'package:zomato_like_app/core/styles/colors.dart';

class TabBarWidget extends StatefulWidget {
  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        vsync: this,
        length: BlocProvider.of<HomeBloc>(context).state.cuisines.length);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (p, c) => p.cuisines != c.cuisines,
      builder: (context, state) => Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          height: 34,
          child: TabBar(
            isScrollable: true,
            unselectedLabelColor: const Color(0xff656565),
            labelColor: app_side_bar_selected,
            controller: _tabController,
            unselectedLabelStyle: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.w500),
            labelStyle: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.w500),
            indicator: BoxDecoration(
              color: app_side_bar_color,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            tabs: state.cuisines
                .map<Widget>(
                  (item) => Tab(
                    text: item,
                  ),
                )
                .toList(),
            onTap: (index) => BlocProvider.of<HomeBloc>(context)
                .add(ChangeCuisine(index: index)),
          ),
        ),
      ),
    );
  }
}
