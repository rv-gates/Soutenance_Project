
import '../../../../core/modele/driver/driver.dart';

class AddDialogState {
  final bool isRegistering, isLoadingUsers;
  final List<DriverCreated>? drivers;
  final Exception? error;

  const AddDialogState({
    required this.isRegistering,
    required this.isLoadingUsers,
    required this.drivers,
    required this.error,
  });

  factory AddDialogState.initial() => const AddDialogState(
        error: null,
        drivers: null,
        isLoadingUsers: false,
        isRegistering: false,
      );

  AddDialogState copyWith({
    bool? isRegistering,
    bool? isLoadingUsers,
    List<DriverCreated>? drivers,
    Exception? error,
  }) =>
      AddDialogState(
        isRegistering: isRegistering ?? this.isRegistering,
        isLoadingUsers: isLoadingUsers ?? this.isLoadingUsers,
        drivers: drivers ?? this.drivers,
        error: error ?? this.error,
      );
}
