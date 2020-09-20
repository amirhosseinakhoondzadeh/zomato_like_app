import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zomato_like_app/blocs/home/home_bloc.dart';
import 'package:zomato_like_app/dependency_injection/injection_container.dart';
import 'package:zomato_like_app/entities/restaurant_entity.dart';
import 'package:zomato_like_app/ui/home/home_details_screen.dart';
import 'package:zomato_like_app/ui/home/widgets/list_item.dart';
import 'package:zomato_like_app/ui/home/widgets/tab_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => sl<HomeBloc>()..add(HomeInitialized()),
        child: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Food & Delivery',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 24,
                      color: const Color(0xff000000),
                      height: 1.5,
                    ),
                  ),
                  textAlign: TextAlign.left,
                ),
                TabBarWidget(),
                Container(
                  height: 6,
                ),
                Text(
                  'Near you',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: const Color(0xff373737),
                      height: 1.25,
                    ),
                  ),
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 15,
                ),
                Container(
                  height: 198,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ListItem(
                        item: state.nearbyRestaurants[index],
                        onTapped: () => _onItemTapped(
                          context,
                          state.nearbyRestaurants[index],
                        ),
                      );
                    },
                    itemCount: state.nearbyRestaurants.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 22, bottom: 15.0),
                  child: Text(
                    'Popular',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: const Color(0xff373737),
                        height: 1.25,
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 198,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ListItem(
                        item: state.popularRestaurants[index],
                        onTapped: () => _onItemTapped(
                            context, state.popularRestaurants[index]),
                      );
                    },
                    itemCount: state.popularRestaurants.length,
                  ),
                ),
                Container(
                  height: 37,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                        topRight: Radius.circular(26.0),
                        bottomRight: Radius.circular(100.0),
                        bottomLeft: Radius.circular(26.0),
                      ),
                      color: const Color(0xff365eff),
                    ),
                    child: Text(
                      'View All',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _onItemTapped(BuildContext context, RestaurantEntity item) {
    showModalBottomSheet(
      context: context,
      builder: (context) => HomeDetailsScreen(
        item,
      ),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(44), topLeft: Radius.circular(44)),
      ),
    );
  }
}
