import 'dart:async';
import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebasestarter/app.dart';
import 'package:firebasestarter/core/presentation/res/app_config.dart';
import 'package:firebasestarter/core/presentation/res/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  if(kIsWeb) {
    runApp(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          location: BannerLocation.topEnd,
          message: "dev",
          textDirection: TextDirection.ltr,
          child: Provider<AppConfig>(
            create: (context) => AppConfig(
              appTitle: AppConstants.appNameDev,
              buildFlavor: AppFlavor.dev,
            ),
            child: App(),
          ),
        ),
      ),
    );
  }else{
    Crashlytics.instance.enableInDevMode = true;
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
    runZoned(() {
      runApp(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Banner(
            location: BannerLocation.topEnd,
            message: "dev",
            textDirection: TextDirection.ltr,
            child: Provider<AppConfig>(
              create: (context) => AppConfig(
                appTitle: AppConstants.appNameDev,
                buildFlavor: AppFlavor.dev,
              ),
              child: App(),
            ),
          ),
        ),
      );
    }, onError: Crashlytics.instance.recordError);
  }
}
