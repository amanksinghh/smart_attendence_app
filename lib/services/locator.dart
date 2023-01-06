import 'package:get_it/get_it.dart';

import 'camera.service.dart';
import 'face_detector_service.dart';
import 'ml_service.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerLazySingleton<CameraService>(() => CameraService());
  locator
      .registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());
  //locator.registerLazySingleton<MLService>(() => MLService());
}
