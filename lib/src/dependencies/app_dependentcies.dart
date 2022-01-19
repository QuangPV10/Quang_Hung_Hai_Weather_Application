import 'package:flutter_simple_dependency_injection/Injector.dart';

import 'bloc_dependencies.dart';
import 'service_dependencies.dart';

class AppDependencies {
  static Injector injector = AppDependencies().initialise(Injector());
  Injector initialise(Injector injector) {
    ServicesDependencies.initialise(injector);
    BlocsDependencies.initialise(injector);
    return injector;
  }
}
