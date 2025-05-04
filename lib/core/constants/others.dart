// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:app_logger/app_logger.export.dart' as app_logger;
import 'package:rt_mobile/presentation/authentication/login/view/export.dart';
import 'package:rt_mobile/presentation/home/page.dart';

// loggers
final appLogger = app_logger.AppLogger();
final logger = Logger();

// dio options
final VALIDATE_NON_5XX_STATUS  = Options(
  validateStatus: (status) => status != null && status < 500,
);

// others
const MINIMUM_LENGTH_FOR_PASSWORD = 8;
const LENGTH_OF_OTP = 6;
const TIME_FOR_RESENDING_MAIL = 10;
const SCREENS = [HomePage(), LoginPage()];
const BASE_URL = 'http://192.168.2.67:8000';
