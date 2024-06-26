import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoghl/core/services/pdf_generation_service/pdf_preview_view.dart';
import 'package:shoghl/core/utils/controller/username_cubit/username_cubit.dart';
import 'package:shoghl/features/home_feature/data/model/pdf_model.dart';
import 'package:shoghl/features/home_feature/presentation/views/personal_account_view/personal_account_view.dart';
import 'package:shoghl/features/invoice_feature/data/services/pdf_generation/invoice_pdf_preview_view.dart';
import 'package:shoghl/features/laborers_feature/presentation/views/laborers_view.dart';
import 'package:shoghl/features/onboarding_feature/presentation/views/onboarding_view.dart';
import '../../features/home_feature/presentation/views/account_details_view/account_details_view.dart';
import '../../features/home_feature/presentation/views/home_view/home_view.dart';
import '../../features/invoice_feature/data/models/invoice.dart';
import '../../features/laborers_feature/presentation/views/laborer_attendance_view.dart';

abstract class AppRouter {
  static String onboardingViewPath = '/OnboardingView';
  static String homeViewPath = '/HomeView';
  static String accountDetailsViewPath = '/accountDetailsView';
  static String laborerViewPath = '/laborerView';
  static String laborerAttendanceViewPath = '/attendanceView';
  static String pdfPreviewViewPath = '/pdfPreviewView';
  static String invoicePdfPreviewViewPath = '/invoicePdfPreviewView';
  static String personalAccountViewPath = '/personalAccountView';
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => FutureBuilder(
            future: context.read<UsernameCubit>().getInitialViewValue(),
            builder: (context,snapshot){

              return snapshot.data == 1 ?const HomeView():const OnboardingView();
            },
        ),
      ),
      GoRoute(
        path: homeViewPath,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: accountDetailsViewPath,
        builder: (context, state) => AccountDetailsView(
          accountData: state.extra as Map<String, dynamic>,
        ),
      ),
      GoRoute(
        path: laborerAttendanceViewPath,
        builder: (context, state) => LaborerAttendanceView(
          laborerId: state.extra as int,
        ),
      ),
      GoRoute(
        path: laborerViewPath,
        builder: (context, state) => const LaborersView(),
      ),
      GoRoute(
        path: pdfPreviewViewPath,
        builder: (context, state) => PdfPreviewView(pdf: state.extra as Pdf),
      ),
      GoRoute(
        path: invoicePdfPreviewViewPath,
        builder: (context, state) => InvoicePdfPreviewView(
          invoicePdf: state.extra as InvoicePdf,
        ),
      ),
      GoRoute(
        path: personalAccountViewPath,
        builder: (context, state) => const PersonalAccountView(),
      ),
    ],
  );
}
