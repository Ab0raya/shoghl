part of 'add_account_cubit.dart';


abstract class AddAccountState {}

class AddAccountInitial extends AddAccountState {}
class AddAccountLoading extends AddAccountState {}
class AddAccountSuccessfully extends AddAccountState {}
class AddAccountFailed extends AddAccountState {}
