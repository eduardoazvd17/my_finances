import 'package:get/get.dart';
import '../../data/services/home_service.dart';

import '../../../../core/data/utils/app_routes.dart';

class HomeController extends GetxController {
  final HomeService _homeService;

  HomeController({
    required HomeService documentsService,
  }) : _homeService = documentsService;

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final RxDouble _scrollPosition = RxDouble(0.0);
  double get scrollPosition => _scrollPosition.value;
  set scrollPosition(double value) => _scrollPosition.value = value;

  void goToMyProfilePage() => AppRoutes.goToMyProfilePage();
}
