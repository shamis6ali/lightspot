import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:lightspot_v1/common/di/injection_container.config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  sl.allowReassignment = true;
  // core
  await _injectSharedPreferences();
  await _initPrefs();
  sl.pushNewScope(init: (_) {
    sl.init();
  });
  
  await _afterInitialization();
}

Future<void> _initPrefs() async {
  //await AppPreferences.init();
}

Future<void> _afterInitialization() async {
  //await sl<LoginInfoCubit>().init();
}

Future<void> _injectSharedPreferences() async {
  sl.registerLazySingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance());
}

SharedPreferences get sharedPreferences => sl<SharedPreferences>();
