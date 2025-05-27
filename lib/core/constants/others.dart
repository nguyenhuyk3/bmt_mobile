// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:app_logger/app_logger.export.dart' as app_logger;
import 'package:rt_mobile/data/services/secure_storage.dart';
import 'package:rt_mobile/presentation/authentication/login/view/export.dart';
import 'package:rt_mobile/presentation/home/page.dart';

// loggers
final appLogger = app_logger.AppLogger();
final logger = Logger();

// dio options
final VALIDATE_ALL_STATUSES = Options(
  validateStatus: (status) => status != null && status < 506,
);

final storage = SecureStorageService();

// storage key
const ACCESS_TOKEN = 'access_token';
const REFRESH_TOKEN = 'refresh_token';

// others
const MINIMUM_LENGTH_FOR_PASSWORD = 8;
const LENGTH_OF_OTP = 6;
const TIME_FOR_RESENDING_MAIL = 10;
const SCREENS = [HomeScreen(), LoginScreen()];
const BASE_URL = 'http://192.168.2.67:8000';

