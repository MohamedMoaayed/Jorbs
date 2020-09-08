import 'package:Jorbs/Data/SaveFilters.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerSingleton<SavedFilters>(SavedFilters());
}
