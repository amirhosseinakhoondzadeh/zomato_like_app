import 'package:get_it/get_it.dart';

abstract class Injector {
  GetIt sl = GetIt.instance;

  init() async {
    initBloc();
    initUseCases();
    initRepository();
    initDataSources();
  }

  initBloc();

  initUseCases();

  initRepository();

  initDataSources();
}
