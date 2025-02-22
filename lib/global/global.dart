// ignore_for_file: constant_identifier_names

import 'package:logger/logger.dart';
import 'package:app_logger/app_logger.export.dart' as app_logger;

final appLogger = app_logger.AppLogger();
final logger = Logger();

const MINIMUM_LENGTH_FOR_PASSWORD = 8;
const LENGTH_OF_OTP = 6;

// Err
const CONFIRMED_PASSWORD_ERR_DOES_NOT_MATCHED = 'Mật khẩu xác nhận không khớp!!';

const TIME_FOR_RESENDING_MAIL = 10;

// Route
const LOGIN_PAGE = 'login';

const REGISTER_STEP_ONE = 'register-step-one';
const REGISTER_STEP_TWO = 'register-step-two';
const REGISTER_STEP_THREE = 'register-step-three';
const REGISTER_STEP_FOUR = 'register-step-four';
