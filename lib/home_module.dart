import 'package:flutter_modular/flutter_modular.dart';
import 'package:rolesp/screens/map_screen/data/datasources/auto_complete_datasource.dart';
import 'package:rolesp/screens/map_screen/data/datasources/google/google_auto_complete_datasource.dart';
import 'package:rolesp/screens/map_screen/data/repositories/auto_complete_repository_impl.dart';
import 'package:rolesp/screens/map_screen/domain/repositories/auto_complete_repository.dart';

import 'bottomNavigator/BottomNavigation.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.add<AutoCompleteDataSource>(GoogleAutoCompleteDatasource.new);
    i.add<AutoCompleteRepository>(AutoCompleteRepositoryImpl.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const BottomNavigation(),
    );
  }
}
