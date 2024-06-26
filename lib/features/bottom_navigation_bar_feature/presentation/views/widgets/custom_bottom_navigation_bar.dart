import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoghl/constants/colors.dart';
import 'package:shoghl/constants/media_query.dart';
import 'package:shoghl/core/utils/styles.dart';
import '../../controller/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
      builder: (context, state) {
        if (state is BottomNavigationBarHidden) {
          return Container();
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 13),
          width: getScreenWidth(context) * 0.75,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: DarkMode.kBgColor(context),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 20,
                offset: const Offset(0, 2),
                color: DarkMode.kPrimaryColor(context).withOpacity(0.2),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  BlocProvider.of<BottomNavigationBarCubit>(context)
                      .bottomNavBarDataF(context)
                      .length,
                      (index) => Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<BottomNavigationBarCubit>(context)
                              .changeItem(index);
                        },
                        icon: Icon(
                          BlocProvider.of<BottomNavigationBarCubit>(context)
                              .bottomNavBarDataF(context)[index]['icon'],
                          color: BlocProvider.of<BottomNavigationBarCubit>(
                              context)
                              .currentIndex ==
                              BlocProvider.of<BottomNavigationBarCubit>(
                                  context)
                                  .bottomNavBarDataF(context)[index]['index']
                              ? DarkMode.kPrimaryColor(context)
                              : DarkMode.kWhiteColor(context),
                          size: 33,
                        ),
                      ),
                      Visibility(
                        visible: BlocProvider.of<BottomNavigationBarCubit>(
                            context)
                            .currentIndex ==
                            BlocProvider.of<BottomNavigationBarCubit>(
                                context)
                                .bottomNavBarDataF(context)[index]['index'],
                        child: Text(
                          BlocProvider.of<BottomNavigationBarCubit>(context)
                              .bottomNavBarDataF(context)[index]['label'],
                          style: Styles.textStyle24.copyWith(
                            color: BlocProvider.of<BottomNavigationBarCubit>(
                                context)
                                .currentIndex ==
                                BlocProvider.of<BottomNavigationBarCubit>(
                                    context)
                                    .bottomNavBarDataF(context)[index]['index']
                                ? DarkMode.kPrimaryColor(context)
                                : DarkMode.kWhiteColor(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
