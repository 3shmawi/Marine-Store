import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin_settings_state.dart';

class AdminSettingsCubit extends Cubit<AdminSettingsState> {
  AdminSettingsCubit() : super(AdminSettingsInitial());
}
