import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/account_model.dart';
import 'multi_account_event.dart';
import 'multi_account_state.dart';

class MultiAccountBloc extends Bloc<MultiAccountEvent, MultiAccountState> {
  MultiAccountBloc() : super(const MultiAccountState()) {
    on<LoadAccounts>(_onLoadAccounts);
    on<SwitchAccount>(_onSwitchAccount);

    // Load initial mock accounts
    add(LoadAccounts());
  }

  void _onLoadAccounts(LoadAccounts event, Emitter<MultiAccountState> emit) {
    final mockAccounts = AccountModel.getMockAccounts();
    if (mockAccounts.isNotEmpty) {
      emit(
        state.copyWith(
          availableAccounts: mockAccounts,
          activeAccount: mockAccounts.first, // Default to first user
        ),
      );
    }
  }

  void _onSwitchAccount(SwitchAccount event, Emitter<MultiAccountState> emit) {
    emit(state.copyWith(activeAccount: event.selectedAccount));
  }
}
