// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:rt_mobile/data/services/secure_storage.dart';
import 'package:rt_mobile/presentation/authentication/login/view/login_screen.dart';
import 'package:rt_mobile/presentation/select_seat/select_seat.dart';

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
const BASE_URL = 'http://192.168.1.35:8000';

var SCREENS = [SelectSeatScreen(), const LoginScreen()];
