import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoghl/constants/colors.dart';
import 'package:shoghl/core/utils/styles.dart';
import 'package:shoghl/features/home_feature/presentation/controller/filter_section_cubit/filter_cubit.dart';
import '../../../../../../generated/l10n.dart';
import '../../../controller/filter_section_cubit/filter_state.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) => buildFilterButton(context, index)),
      ),
    );
  }

  Widget buildFilterButton(BuildContext context, int index) {
    List <String> menus = [
    S.of(context).accounts,
    S.of(context).expenses,
    S.of(context).theIncome,
    ];
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        final filterCubit = BlocProvider.of<FilterCubit>(context);
        return MaterialButton(
          onPressed: () {
            filterCubit.selectIndex(index);
          },
          color: filterCubit.currentIndex == index ? DarkMode.kPrimaryColor(context) : DarkMode.kBgColor(context),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: DarkMode.kWhiteColor(context).withOpacity(0.2), width: 3),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textColor: filterCubit.currentIndex == index ? DarkMode.kBgColor(context) : DarkMode.kPrimaryColor(context),
          child:  Text(
           menus[index],
            style: Styles.textStyle22,
          ),
        );
      },
    );
  }
}
