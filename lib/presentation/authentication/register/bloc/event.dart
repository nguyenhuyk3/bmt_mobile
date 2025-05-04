part of 'bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

// Step 1
class RegisterEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class RegisterEmailSubmitted extends RegisterEvent {}

// Step 2
class RegisterOtpChanged extends RegisterEvent {
  final String otp;

  const RegisterOtpChanged({required this.otp});

  @override
  List<Object?> get props => [otp];
}

class RegisterOtpSubmitted extends RegisterEvent {}

// Step 3
class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  final String confirmedPassword;

  const RegisterPasswordChanged({
    required this.password,
    required this.confirmedPassword,
  });

  @override
  List<Object?> get props => [password];
}

class RegisterPasswordSubmitted extends RegisterEvent {}

// Step 4
class RegisterInformationChanged extends RegisterEvent {
  final String fullName;
  final String birthDate;
  final String sex;

  const RegisterInformationChanged({
    required this.fullName,
    required this.birthDate,
    required this.sex,
  });

  String get formattedBirthDate {
    return birthDate.split('T').first;
  }

  @override
  List<Object?> get props => [fullName, birthDate, sex];
}

class RegisterSubmitted extends RegisterEvent {}

class RegisterReset extends RegisterEvent {}
