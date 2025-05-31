// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:rt_mobile/data/services/storage/secure_storage.dart';
import 'package:rt_mobile/presentation/authentication/login/view/export.dart';
import 'package:rt_mobile/presentation/home/home_screen.dart';

// loggers
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
const PRIVATE_BASE_URL = 'http://192.168.1.7:8000';
const PUBLIC_SHOWTIME_BASE_URL = 'http://192.168.1.7:5005';

var SCREENS = [HomeScreen(), const LoginScreen()];


