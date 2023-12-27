import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/screen/options/addSomething/add_dialog/add_dialog_notifier.dart';

import '../../../../core/modele/driver/driver.dart';

extension AddDialogSelectorsException on WidgetRef {
  AddDialogSelectors get addDialogSelectors => AddDialogSelectors(this);
}

class AddDialogSelectors {
  final WidgetRef _ref;

  AddDialogSelectors(this._ref);

  bool get isRegistering =>
      _ref.watch(addDialogProvider.select((value) => value.isRegistering));

  bool get isLoadingUsers =>
      _ref.watch(addDialogProvider.select((value) => value.isLoadingUsers));

  List<DriverCreated>? get drivers =>
      _ref.watch(addDialogProvider.select((value) => value.drivers));

  Exception? get error =>
      _ref.watch(addDialogProvider.select((value) => value.error));
}
