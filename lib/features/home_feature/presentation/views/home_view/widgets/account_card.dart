import 'package:flutter/material.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/media_query.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/widgets/custom_container.dart';
import '../../../../../../generated/l10n.dart';

class AccountCard extends StatelessWidget {
  const AccountCard(
      {super.key,
      required this.ownerName,
      required this.location,
      required this.lastEdit,
      required this.income,
      required this.expense, required this.onTap,});

  final String ownerName;
  final String location;
  final String lastEdit;
  final int income;
  final int expense;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: CustomContainer(
        height: getScreenHeight(context) * 0.27,
        width: double.infinity,
        onTap: onTap,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  location,
                  style: Styles.textStyle24,
                ),
                Text(
                  ownerName,
                  style: Styles.textStyleNormal18
                      .copyWith(color: DarkMode.kPrimaryColor(context)),
                ),
              ],
            ),
            SizedBox(
              height: getScreenHeight(context) * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          S.of(context).expense,
                          style: Styles.textStyle24.copyWith(
                              fontSize: 35, fontWeight: FontWeight.normal),
                        ),
                        Text(
                          '$expense',
                          style: Styles.textStyle24.copyWith(
                              fontSize: 40, color: DarkMode.kPrimaryColor(context)),
                        ),
                      ],
                    ),
                      VerticalDivider(
                      color: DarkMode.kWhiteColor(context),
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          S.of(context).income,
                          style: Styles.textStyle24.copyWith(
                              fontSize: 35, fontWeight: FontWeight.normal),
                        ),
                        Text(
                          '$income',
                          style: Styles.textStyle24.copyWith(
                              fontSize: 40, color: DarkMode.kPrimaryColor(context)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getScreenHeight(context) * 0.02,
            ),
            Text(
              '${S.of(context).creationDate} : $lastEdit',
              style: Styles.textStyleNormal18
                  .copyWith(color: DarkMode.kPrimaryColor(context)),
            ),
          ],
        ),
      ),
    );
  }
}
