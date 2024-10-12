import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final navigatorKey = GlobalKey<NavigatorState>();

BuildContext get ctx => navigatorKey.currentState!.context;

/// Use to push new screen which accept route and argument as nullable
Future<T?> push<T>(String routeName, {Object? arg}) async {
  return await Navigator.pushNamed<T>(ctx, routeName, arguments: arg);
}

bool get canPop => Navigator.canPop(ctx);

/// Use to pop the screen if the screen is available in stack else it throws Exception;
void goBack<T>({Object? arg}) async {
  Navigator.of(ctx).maybePop(arg);
}

enum APISTATE { loading, loaded, error, idle }


final sl = GetIt.instance;
