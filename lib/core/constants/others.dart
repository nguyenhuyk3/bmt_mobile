// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:rt_mobile/data/models/movie/movie.dart';
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
const BASE_URL = 'http://192.168.1.7:8000';

var SCREENS = [HomeScreen(), const LoginScreen()];

final List<Movie> movies = [
    Movie(
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/4/4d/Avengers_Infinity_War_poster.jpg',
      title: 'Avengers - Infinity War',
      genre: 'Action, Adventure, Sci-fi',
      duration: '2h29m',
      rating: 4.8,
      votes: 1222,
    ),
    Movie(
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/4/4d/Avengers_Infinity_War_poster.jpg',
      title: 'Avengers - Infinity War',
      genre: 'Action, Adventure, Sci-fi',
      duration: '2h29m',
      rating: 4.8,
      votes: 1222,
    ),
    Movie(
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/0/0d/Avengers_Endgame_poster.jpg',
      title: 'Avengers - Endgame',
      genre: 'Action, Adventure, Sci-fi',
      duration: '3h1m',
      rating: 4.9,
      votes: 1500,
    ),
  ];
