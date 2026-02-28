import 'package:equatable/equatable.dart';
import '../models/account_model.dart';

class MultiAccountState extends Equatable {
  final AccountModel? activeAccount;
  final List<AccountModel> availableAccounts;

  const MultiAccountState({
    this.activeAccount,
    this.availableAccounts = const [],
  });

  MultiAccountState copyWith({
    AccountModel? activeAccount,
    List<AccountModel>? availableAccounts,
  }) {
    return MultiAccountState(
      activeAccount: activeAccount ?? this.activeAccount,
      availableAccounts: availableAccounts ?? this.availableAccounts,
    );
  }

  @override
  List<Object?> get props => [activeAccount, availableAccounts];
}
