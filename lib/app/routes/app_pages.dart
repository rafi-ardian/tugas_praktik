import 'package:get/get.dart';

import '../modules/data/bindings/data_binding.dart';
import '../modules/data/views/data_view.dart';
import '../modules/form/bindings/form_binding.dart';
import '../modules/form/views/form_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/info/bindings/info_binding.dart';
import '../modules/info/views/info_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INFO,
      page: () => const InfoView(),
      binding: InfoBinding(),
    ),
    GetPage(name: _Paths.FORM, page: () => FormView(), binding: FormBinding()),
    GetPage(name: _Paths.DATA, page: () => DataView(), binding: DataBinding()),
  ];
}
