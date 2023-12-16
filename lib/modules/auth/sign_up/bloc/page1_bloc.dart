import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/func.dart';
/// ----------------------------------------------------------------------------
/// BLOC - Global data refresher bloc
/// ----------------------------------------------------------------------------
class Page1Bloc extends Bloc<Page1Event, Page1State> {
  Page1Bloc() : super(Page1Refresh()) {
    on<Page1ValidateUsernameEvent>((event, emit) async {
      bool isValidEmail1 = isValidEmail(event.username ?? '');
      bool isValidPhone1 = isEightDigits(event.username ?? '');

      emit(
        Page1ValidateUsernameState(
          isValidEmail: isValidEmail1,
          isValidPhone: isValidPhone1,
        ),
      );

      emit(Page1Refresh());
    });

    on<Page1ValidatePassEvent>((event, emit) async {
      bool valid1 = hasMinimumLength(event.pass1 ?? '');
      bool valid2 = hasUppercaseLetter(event.pass1 ?? '');
      bool valid3 = hasLowercaseLetter(event.pass1 ?? '');
      bool valid4 = Func.isNotEmpty(event.pass1) && event.pass1 == event.pass2;

      emit(
        Page1ValidatePassState(
          isValid1: valid1,
          isValid2: valid2,
          isValid3: valid3,
          isValid4: valid4,
        ),
      );

      emit(Page1Refresh());
    });
  }

  bool hasMinimumLength(String password) {
    final regex = RegExp(r"^.{8,}$");
    return regex.hasMatch(password);
  }

  bool hasUppercaseLetter(String password) {
    final regex = RegExp(r".*[A-Z].*");
    return regex.hasMatch(password);
  }

  bool hasLowercaseLetter(String password) {
    final regex = RegExp(r".*[a-z].*");
    return regex.hasMatch(password);
  }

  bool isValidEmail(String email) {
    final regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
    );
    return regex.hasMatch(email);
  }

  bool isEightDigits(String number) {
    final regex = RegExp(r"^\d{8}$");
    return regex.hasMatch(number);
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class Page1Event extends Equatable {
  const Page1Event();

  @override
  List<Object> get props => [];
}

class Page1ValidateUsernameEvent extends Page1Event {
  final String? username;

  const Page1ValidateUsernameEvent({this.username});

  @override
  List<Object> get props => [username ?? ''];
}

class Page1ValidatePassEvent extends Page1Event {
  final String? pass1;
  final String? pass2;

  const Page1ValidatePassEvent({this.pass1, this.pass2});

  @override
  List<Object> get props => [pass1 ?? '', pass2 ?? ''];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class Page1State extends Equatable {
  const Page1State();

  @override
  List<Object> get props => [];
}

class Page1Refresh extends Page1State {}

class Page1ValidatePassState extends Page1State {
  final bool isValid1;
  final bool isValid2;
  final bool isValid3;
  final bool isValid4;

  const Page1ValidatePassState({
    required this.isValid1,
    required this.isValid2,
    required this.isValid3,
    required this.isValid4,
  });

  @override
  List<Object> get props => [isValid1, isValid2, isValid3, isValid4];
}

class Page1ValidateUsernameState extends Page1State {
  final bool isValidEmail;
  final bool isValidPhone;

  const Page1ValidateUsernameState({
    required this.isValidEmail,
    required this.isValidPhone,
  });

  @override
  List<Object> get props => [isValidEmail, isValidPhone];
}
