import 'package:get_it/get_it.dart';
import 'package:thewarehouse/repository/itemRepository.dart';
import 'package:thewarehouse/repository/truckRepository.dart';
import 'package:thewarehouse/repository/userRepository.dart';
import 'package:thewarehouse/services/core/httpService.dart';
import 'package:thewarehouse/services/itemService.dart';
import 'package:thewarehouse/services/truckService.dart';
import 'package:thewarehouse/services/userService.dart';
import 'package:thewarehouse/viewModel/authViewModel.dart';
import 'package:thewarehouse/viewModel/homeViewModel.dart';
import 'package:thewarehouse/viewModel/itemViewModel.dart';
import 'package:thewarehouse/viewModel/scannerViewModel.dart';
import 'package:thewarehouse/viewModel/truckViewModel.dart';

GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<HttpService>(HttpService());

  ///[Repository]
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl(getIt<HttpService>()));
  getIt.registerSingleton<TruckRepository>(TruckRepositoryImp(getIt<HttpService>()));
  getIt.registerSingleton<ItemRepository>(ItemRepositoryImp(getIt<HttpService>()));
//   getIt.registerSingleton<DatabaseRepository>(DatabaeRepositoryIm(getIt<HttpService>()));
//   getIt.registerSingleton<ScriptRepository>(ScriptRepositoryIm(getIt<HttpService>()));

  ///[Service Class]
  getIt.registerSingleton<UserService>(UserService(getIt<UserRepository>()));
  getIt.registerSingleton<TruckService>(TruckService(getIt<TruckRepository>()));
  getIt.registerSingleton<ItemService>(ItemService(getIt<ItemRepository>()));
//   getIt.registerSingleton<DatabaseService>(DatabaseService(getIt<DatabaseRepository>()));
//   getIt.registerSingleton<ScriptServices>(ScriptServices(getIt<ScriptRepository>()));

  ///[View Model]
  getIt.registerFactory<AuthViewModel>(() => AuthViewModel(getIt<UserService>()));
  getIt.registerFactory<HomeViewModel>(() => HomeViewModel());

  getIt.registerFactory<QRScanPageModel>(() => QRScanPageModel());
  getIt.registerFactory<TruckViewModel>(() => TruckViewModel(getIt<TruckService>(), getIt<ItemService>()));
  getIt.registerFactory<ItemViewModel>(() => ItemViewModel(
        getIt<ItemService>(),
        getIt<TruckService>(),
      ));
// //Script
//   getIt.registerFactory<ScriptListViewModel>(() => ScriptListViewModel(getIt<ScriptServices>()));
//   getIt.registerFactory<ScriptDetailViewModel>(() => ScriptDetailViewModel(getIt<ScriptServices>()));
//   getIt.registerFactory<AddScriptViewModel>(() => AddScriptViewModel(getIt<ScriptServices>()));
}
