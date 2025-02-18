// ignore_for_file: avoid_print

import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Logger {
  static final Logger _instance = Logger._internal();
  File? _logFile;
  bool _isInitialized = false;
  final List<String> _pendingLogs = [];

  // Factory constructor to ensure singleton
  factory Logger() {
    return _instance;
  }

  // Constructor private
  Logger._internal() {
    _init();
  }

  Future<void> _init() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      String path = directory.path;

      _logFile = File('$path/log.txt');

      if (!await _logFile!.exists()) {
        await _logFile!.create();
      }

      _isInitialized = true;

      // Process pending logs
      if (_pendingLogs.isNotEmpty) {
        for (String logMessage in _pendingLogs) {
          await _writeLogToFile(logMessage);
        }

        _pendingLogs.clear();
      }
    } catch (e) {
      print("Error initializing logger: $e");
    }
  }

  String _getLogDetails(StackTrace stackTrace) {
    final now = DateTime.now().toIso8601String();
    final stackList = stackTrace.toString().split('\n');
    final executionLine =
        stackList.length > 1 ? stackList[1].trim() : 'Unknown line';

    return '[$now] $executionLine';
  }

  Future<void> _writeLogToFile(String logMessage) async {
    if (!_isInitialized || _logFile == null) {
      // Save log to queue if not initialized yet
      _pendingLogs.add(logMessage);

      return;
    }

    try {
      final sink = _logFile!.openWrite(mode: FileMode.write);

      sink.writeln(logMessage);

      await sink.flush();
      await sink.close();
    } catch (e) {
      print("Logging error: $e");
    }
  }

  // debug
  void d(dynamic message) {
    final stackTrace = StackTrace.current;
    final logDetails = _getLogDetails(stackTrace);

    _writeLogToFile('$logDetails - DEBUG: $message');
  }

  // info
  void i(dynamic message) {
    final stackTrace = StackTrace.current;
    final logDetails = _getLogDetails(stackTrace);

    _writeLogToFile('$logDetails - INFO: $message');
  }

  // warning
  void w(dynamic message) {
    final stackTrace = StackTrace.current;
    final logDetails = _getLogDetails(stackTrace);

    _writeLogToFile('$logDetails - WARN: $message');
  }

  // error
  void e(dynamic message) {
    final stackTrace = StackTrace.current;
    final logDetails = _getLogDetails(stackTrace);

    _writeLogToFile('$logDetails - ERROR: $message');
  }

  Future<String> readLogs() async {
    if (!_isInitialized || _logFile == null) {
      return "Logger not initialized";
    }

    try {
      if (await _logFile!.exists()) {
        return await _logFile!.readAsString();
      }

      return "No log yet";
    } catch (e) {
      return "Error reading log: $e";
    }
  }

  Future<void> clearLogs() async {
    if (!_isInitialized || _logFile == null) {
      return;
    }

    try {
      if (await _logFile!.exists()) {
        await _logFile!.writeAsString('', mode: FileMode.write);
      }
    } catch (e) {
      print("Error deleting log: $e");
    }
  }
}
