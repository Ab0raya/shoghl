import 'package:flutter/material.dart';
import 'package:shoghl/constants/colors.dart';
import 'package:shoghl/features/home_feature/presentation/views/account_details_view/widgets/account_details_view_body.dart';

class AccountDetailsView extends StatelessWidget {
  const AccountDetailsView(
      {super.key, required this.accountData,});


  final  Map<String, dynamic> accountData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkMode.kBgColor(context),
      body: AccountDetailsViewBody(
        accountData: accountData,
      ),
    );
  }
}
