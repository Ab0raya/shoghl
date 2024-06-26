import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoghl/features/home_feature/data/model/treatment_model.dart';
import 'package:intl/intl.dart';

import '../../../../../core/SQlite/local_database/local_db.dart';
import '../../../../../core/utils/app_router.dart';

part 'treatment_state.dart';

class TreatmentCubit extends Cubit<TreatmentState> {
  TreatmentCubit() : super(TreatmentInitial());

  TextEditingController treatment = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController cost = TextEditingController();
  String hour = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final formKey = GlobalKey<FormState>();
  LocalDatabase sqlDb = LocalDatabase();

  addTreatment({
    required int accId,
    required String title,
    required String time,
    required String details,
    required int cost,
    required bool isIncome,
  }) async {
    emit(TreatmentLoading());

    Treatment treatment = Treatment(
      title: title,
      time: time,
      details: details,
      cost: cost,
      isIncome: isIncome,
    );
    int treatmentInserted =
        await sqlDb.insertTreatmentData(treatment: treatment, accId: accId);
    if (treatmentInserted > 0) {
      emit(TreatmentSuccessfully());
      fetchTotalIncomeAndExpenses(accId: accId);
    }
  }

  Future<void> fetchTotalIncomeAndExpenses({required int accId}) async {
    emit(TreatmentLoading());

    int totalIncome = await fetchTotalIncome(accId: accId);
    int totalExpenses = await fetchTotalExpenses(accId: accId);

    emit(TreatmentIncomeExpensesLoaded(
        totalIncome: totalIncome, totalExpenses: totalExpenses));
  }

  Future<int> fetchTotalIncome({required int accId}) async {
    List<Map<String, dynamic>> treatmentData =
        await sqlDb.getTreatmentData(accId: accId);
    int totalIncome = 0;
    for (var treatment in treatmentData) {
      if (treatment['isIncome'] == 1) {
        totalIncome += treatment['cost'] as int;
      }
    }

    return totalIncome;
  }

  Future<int> fetchTotalExpenses({required int accId}) async {
    List<Map<String, dynamic>> treatmentData =
        await sqlDb.getTreatmentData(accId: accId);
    int totalExpenses = 0;
    for (var treatment in treatmentData) {
      if (treatment['isIncome'] != 1) {
        totalExpenses += treatment['cost'] as int;
      }
    }

    return totalExpenses;
  }

  Future<void> deleteAccountWithTreatments(
      int accountId, BuildContext context) async {
    try {
      await sqlDb.deleteAccountWithTreatments(accountId);
      Navigator.pop(context);
      context.go(AppRouter.homeViewPath);
    } catch (e) {}
  }

  Future<void> deleteTreatment(int treatmentId, {required int accId}) async {
    try {
      await sqlDb.deleteTreatment(treatmentId);
      fetchTotalIncomeAndExpenses(accId: accId);
      emit(TreatmentDeletedSuccessfully());
    } catch (error) {
      emit(TreatmentFailed());
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllData({required accId}) async {
    int totalIncome = await fetchTotalIncome(accId: accId);
    int totalExpenses = await fetchTotalExpenses(accId: accId);
    List<Map<String, dynamic>> treatmentData =
        await sqlDb.getTreatmentData(accId: accId);

    return [
      {
        'totalIncome': totalIncome,
      },
      {
        'totalExpenses': totalExpenses,
      },
      {
        'treatmentData': treatmentData,
      },
    ];
  }

  fetchTreatmentsIncome() async {
    List<Map<String, dynamic>> incomeTreatments =
        await sqlDb.getIncomeTreatments();
    return incomeTreatments;
  }

  fetchTreatmentsExpenses() async {
    List<Map<String, dynamic>> expensesTreatments =
        await sqlDb.getExpensesTreatments();
    return expensesTreatments;
  }
}
