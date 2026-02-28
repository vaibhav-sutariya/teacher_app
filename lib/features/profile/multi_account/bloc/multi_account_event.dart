import 'package:equatable/equatable.dart';
import '../models/account_model.dart';

abstract class MultiAccountEvent extends Equatable {
  const MultiAccountEvent();

  @override
  List<Object?> get props => [];
}

class LoadAccounts extends MultiAccountEvent {}

class SwitchAccount extends MultiAccountEvent {
  final AccountModel selectedAccount;

  const SwitchAccount({required this.selectedAccount});

  @override
  List<Object?> get props => [selectedAccount];
}
