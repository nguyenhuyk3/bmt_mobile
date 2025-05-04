part of 'bloc.dart';

sealed class RegisterState extends Equatable {
  final FormzSubmissionStatus status;

  const RegisterState({required this.status});

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial() : super(status: FormzSubmissionStatus.initial);
}

class RegisterStepOne extends RegisterState {
  final Email email;

  const RegisterStepOne({required this.email})
    : super(status: FormzSubmissionStatus.inProgress);

  @override
  List<Object?> get props => [email];
}

class RegisterStepTwo extends RegisterState {
  final Otp otp;

  const RegisterStepTwo({required this.otp})
    : super(status: FormzSubmissionStatus.inProgress);

  @override
  List<Object?> get props => [otp];
}

class RegisterStepThree extends RegisterState {
  final Password password;
  final String confirmedPassword;
  final String error;

  const RegisterStepThree({
    required this.password,
    required this.confirmedPassword,
    required this.error,
  }) : super(status: FormzSubmissionStatus.inProgress);

  @override
  List<Object?> get props => [password, confirmedPassword, error];
}

class RegisterStepFour extends RegisterState {
  final String fullName;
  final String birthDate;
  final String sex;
  final String error;

  const RegisterStepFour({
    required this.fullName,
    required this.birthDate,
    this.sex = 'male',
    this.error = '',
  }) : super(status: FormzSubmissionStatus.inProgress);

  @override
  List<Object?> get props => [fullName, birthDate, sex, error];
}

// If other classes have one prop in class then this class will fit with them
class RegisterError extends RegisterState {
  final String error;

  const RegisterError({required this.error})
    : super(status: FormzSubmissionStatus.inProgress);

  @override
  List<Object?> get props => [error];
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess() : super(status: FormzSubmissionStatus.success);
}

// class RegisterCompleted extends RegisterState {
//   // Step 1
//   final String email;
//   // Step 2
//   // Step 3
//   final String password;
//   final String confirmedPassword;
//   // Step 4
//   final String fullName;
//   final String birthDate;
//   final String sex;

//   const RegisterCompleted({
//     this.email = '',
//     this.password = '',
//     this.confirmedPassword = '',
//     this.fullName = '',
//     this.birthDate = '',
//     this.sex = '',
//   }) : super(status: FormzSubmissionStatus.success);

//   RegisterCompleted copyWith({
//     String? email,
//     String? otp,
//     String? password,
//     String? confirmedPassword,
//     String? fullName,
//     String? birthDate,
//     String? sex,
//   }) {
//     return RegisterCompleted(
//       email: email ?? this.email,
//       password: password ?? this.password,
//       confirmedPassword: confirmedPassword ?? this.confirmedPassword,
//       fullName: fullName ?? this.fullName,
//       birthDate: birthDate ?? this.birthDate,
//       sex: sex ?? this.sex,
//     );
//   }

//   @override
//   Map<String, dynamic> toMap() {
//     return {
//       'email': email,
//       'password': password,
//       'confirmed_password': confirmedPassword,
//       'full_name': fullName,
//       'birth_date': birthDate,
//       'sex': sex,
//     };
//   }

//   @override
//   // TODO: implement props
//   @override
//   List<Object?> get props => [email, password, fullName, birthDate, sex];
// }
