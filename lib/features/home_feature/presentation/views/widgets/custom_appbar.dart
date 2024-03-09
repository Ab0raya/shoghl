import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoghl/constants/colors.dart';
import 'package:shoghl/constants/media_query.dart';
import 'package:shoghl/core/utils/styles.dart';
import 'package:shoghl/features/home_feature/presentation/views/widgets/shadow_container.dart';

import '../../../../../core/utils/app_router.dart';
import 'custom_container.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const ShadowContainer(
              child: CircleAvatar(
                backgroundColor: DarkMode.kPrimaryColor,
                radius: 30,
                child: Icon(
                  CupertinoIcons.person,
                  color: DarkMode.kBgColor,
                  size: 50,
                ),
              ),
            ),
            SizedBox(
              width: getScreenWidth(context) * 0.03,
            ),
            const Text('مرحبا, ', style: Styles.titleTextStyle),
            Text(
              'حاج سيد',
              style:
                  Styles.titleTextStyle.copyWith(color: DarkMode.kPrimaryColor),
            ),
          ],
        ),
        SizedBox(
          width: getScreenWidth(context) * 0.3,
        ),
         ShadowContainer(
           child: CustomContainer(
            height: 60,
            width: 60,
            onTap: () {
            },
            child: const Icon(
              CupertinoIcons.list_bullet,
              color: DarkMode.kPrimaryColor,
              size: 30,
            ),
                   ),
         ),
      ],
    );
  }
}

class AccountDetailsAppBar extends StatelessWidget {
  const AccountDetailsAppBar({super.key, required this.addIcon, required this.printIcon});
  final void Function() addIcon;
  final void Function() printIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed:addIcon,
          icon: const Icon(
            CupertinoIcons.add_circled_solid,
            color: DarkMode.kPrimaryColor,
            size: 30,
          ),
        ),
        IconButton(
          onPressed:printIcon,
          icon: const Icon(
            CupertinoIcons.printer_fill,
            color: DarkMode.kPrimaryColor,
            size: 30,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
           context.go(AppRouter.homeViewPath);
          },
          icon: const Icon(
            CupertinoIcons.forward,
            size: 30,
          ),
        ),
      ],
    );
  }
}

