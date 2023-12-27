import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/screen/options/addSomething/add_dialog/add_dialog_state.dart';
import 'package:soutenance_app/shared/services/drivers_service.dart';

final addDialogProvider =
    StateNotifierProvider<AddDialogNotifier, AddDialogState>(
        (ref) => AddDialogNotifier(ref));

class AddDialogNotifier extends StateNotifier<AddDialogState> {
  final Ref _ref;

  AddDialogNotifier(this._ref) : super(AddDialogState.initial());

  Future<void> fetchUsers() async {
    try {
      if (state.isLoadingUsers) return;

      state = AddDialogState(
        isRegistering: state.isRegistering,
        isLoadingUsers: true,
        drivers: null,
        error: null,
      );

      final drivers = await _ref.read(driversService).drivers;

      state = state.copyWith(drivers: drivers);
    } on Exception catch (e) {
      state = state.copyWith(error: e);
    } finally {
      state = state.copyWith(isLoadingUsers: false);
    }
  }
}
