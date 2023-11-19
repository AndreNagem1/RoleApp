import 'package:rolesp/screens/settings_screen/settings_cubit.dart';

abstract class SettingsScreenState {}

class InitialState extends SettingsScreenState {
  List<Object> get props => [];
}

class Loading extends SettingsScreenState {
  List<Object> get props => [];
}

class ErrorState extends SettingsScreenState {
  List<Object> get props => [];
}

class OptionSelected extends SettingsScreenState {
  OptionSelected(this.selectedOption);

  final SelectedOption selectedOption;

  List<Object> get props => [selectedOption];
}
