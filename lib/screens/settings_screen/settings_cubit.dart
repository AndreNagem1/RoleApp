import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/screens/settings_screen/settings_screen_state.dart';

class SettingsCubit extends Cubit<SettingsScreenState> {
  SettingsCubit() : super(InitialState());

  final apiKey = 'apiKey';
  SelectedOption lastOption = SelectedOption.none;

  void setInitialState() {
    emit(InitialState());
  }

  void selectOption(SelectedOption option) {
    if(option == lastOption){
      option = SelectedOption.none;
    }
    lastOption = option;
    emit(OptionSelected(option));
  }
}

enum SelectedOption { configurations, aboutUs, help, none }
