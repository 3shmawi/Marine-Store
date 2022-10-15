import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'admin_settings_state.dart';

class AdminSettingsCubit extends Cubit<AdminSettingsState> {
  AdminSettingsCubit() : super(AdminSettingsInitial());
}
