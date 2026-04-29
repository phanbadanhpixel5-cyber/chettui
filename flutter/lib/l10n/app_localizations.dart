import 'package:flutter/material.dart';

class AppLocalizations {
  static const Map<String, Map<String, String>> _localizedStrings = {
    'vi': {
      // App Title
      'app_title': 'Bộ Điều Khiển Thiết Bị TAO',
      
      // Navigation
      'nav_home': 'Trang Chủ',
      'nav_schedule': 'Lịch Trình',
      'nav_settings': 'Cài Đặt',
      'nav_weather': 'Thời Tiết',
      
      // Status
      'status_connected': 'Đã Kết Nối',
      'status_disconnected': 'Chưa Kết Nối',
      'status_connecting': 'Đang Kết Nối...',
      'status_error': 'Lỗi Kết Nối',
      
      // Devices
      'devices_title': 'Thiết Bị',
      'devices_empty': 'Không có thiết bị nào được kết nối',
      'device_on': 'BẬT',
      'device_off': 'TẮT',
      'device_status': 'Trạng Thái',
      'device_control': 'Điều Khiển Thiết Bị',
      
      // Weather
      'weather_title': 'Thời Tiết',
      'weather_temperature': 'Nhiệt Độ',
      'weather_humidity': 'Độ Ẩm',
      'weather_wind_speed': 'Tốc Độ Gió',
      'weather_conditions': 'Điều Kiện',
      'weather_location': 'Vị Trí',
      'weather_update': 'Cập Nhật Lúc',
      'weather_degree': '°C',
      'weather_percent': '%',
      'weather_kmh': 'km/h',
      'weather_refresh': 'Làm Mới',
      'weather_loading': 'Đang Tải Thời Tiết...',
      
      // Schedule
      'schedule_title': 'Lịch Trình',
      'schedule_add_new': 'Thêm Lịch Trình',
      'schedule_device': 'Thiết Bị',
      'schedule_time': 'Thời Gian',
      'schedule_action': 'Hành Động',
      'schedule_action_on': 'Bật',
      'schedule_action_off': 'Tắt',
      'schedule_days': 'Ngày Trong Tuần',
      'schedule_monday': 'Thứ Hai',
      'schedule_tuesday': 'Thứ Ba',
      'schedule_wednesday': 'Thứ Tư',
      'schedule_thursday': 'Thứ Năm',
      'schedule_friday': 'Thứ Sáu',
      'schedule_saturday': 'Thứ Bảy',
      'schedule_sunday': 'Chủ Nhật',
      'schedule_enabled': 'Đã Bật',
      'schedule_disabled': 'Đã Tắt',
      'schedule_edit': 'Chỉnh Sửa',
      'schedule_delete': 'Xóa',
      'schedule_save': 'Lưu',
      'schedule_cancel': 'Hủy',
      'schedule_coming_soon': 'Lịch Trình Sắp Có',
      'schedule_no_schedule': 'Chưa có lịch trình nào',
      
      // Settings
      'settings_title': 'Cài Đặt',
      'settings_backend_url': 'URL Backend',
      'settings_api_key': 'Khóa API',
      'settings_weather_location': 'Vị Trí Thời Tiết',
      'settings_language': 'Ngôn Ngữ',
      'settings_theme': 'Giao Diện',
      'settings_theme_dark': 'Tối',
      'settings_theme_light': 'Sáng',
      'settings_notifications': 'Thông Báo',
      'settings_notifications_enabled': 'Bật Thông Báo',
      'settings_notifications_disabled': 'Tắt Thông Báo',
      'settings_save': 'Lưu Cài Đặt',
      'settings_coming_soon': 'Cài Đặt Sắp Có',
      'settings_about': 'Về Ứng Dụng',
      'settings_version': 'Phiên Bản',
      'settings_help': 'Trợ Giúp',
      
      // Connection Status
      'connection_good': 'Kết Nối Tốt',
      'connection_weak': 'Kết Nối Yếu',
      'connection_poor': 'Kết Nối Kém',
      'connection_offline': 'Ngoại Tuyến',
      'connection_arduino': 'Arduino',
      'connection_firebase': 'Firebase',
      'connection_backend': 'Backend',
      
      // Errors
      'error_connection': 'Lỗi Kết Nối',
      'error_device_control': 'Lỗi Điều Khiển Thiết Bị',
      'error_weather_load': 'Lỗi Tải Thời Tiết',
      'error_invalid_input': 'Đầu Vào Không Hợp Lệ',
      'error_try_again': 'Thử Lại',
      'error_close': 'Đóng',
      
      // General
      'loading': 'Đang Tải...',
      'save': 'Lưu',
      'delete': 'Xóa',
      'edit': 'Chỉnh Sửa',
      'add': 'Thêm',
      'back': 'Quay Lại',
      'confirm': 'Xác Nhận',
      'cancel': 'Hủy',
      'yes': 'Có',
      'no': 'Không',
      'ok': 'OK',
      'refresh': 'Làm Mới',
      'search': 'Tìm Kiếm',
      'filter': 'Lọc',
      'sort': 'Sắp Xếp',
      'more': 'Thêm',
      'info': 'Thông Tin',
      'time': 'Thời Gian',
      'date': 'Ngày',
      'duration': 'Thời Lượng',
    },
  };

  final String locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations('vi');
  }

  String translate(String key) {
    return _localizedStrings[locale]?[key] ?? _localizedStrings['vi']![key]!;
  }

  String get appTitle => translate('app_title');
  String get navHome => translate('nav_home');
  String get navSchedule => translate('nav_schedule');
  String get navSettings => translate('nav_settings');
  String get navWeather => translate('nav_weather');
  
  String get statusConnected => translate('status_connected');
  String get statusDisconnected => translate('status_disconnected');
  String get statusConnecting => translate('status_connecting');
  String get statusError => translate('status_error');
  
  String get devicesTitle => translate('devices_title');
  String get devicesEmpty => translate('devices_empty');
  String get deviceOn => translate('device_on');
  String get deviceOff => translate('device_off');
  String get deviceStatus => translate('device_status');
  String get deviceControl => translate('device_control');
  
  String get weatherTitle => translate('weather_title');
  String get weatherTemperature => translate('weather_temperature');
  String get weatherHumidity => translate('weather_humidity');
  String get weatherWindSpeed => translate('weather_wind_speed');
  String get weatherConditions => translate('weather_conditions');
  String get weatherLocation => translate('weather_location');
  String get weatherUpdate => translate('weather_update');
  String get weatherDegree => translate('weather_degree');
  String get weatherPercent => translate('weather_percent');
  String get weatherKmh => translate('weather_kmh');
  String get weatherRefresh => translate('weather_refresh');
  String get weatherLoading => translate('weather_loading');
  
  String get scheduleTitle => translate('schedule_title');
  String get scheduleAddNew => translate('schedule_add_new');
  String get scheduleDevice => translate('schedule_device');
  String get scheduleTime => translate('schedule_time');
  String get scheduleAction => translate('schedule_action');
  String get scheduleActionOn => translate('schedule_action_on');
  String get scheduleActionOff => translate('schedule_action_off');
  String get scheduleDays => translate('schedule_days');
  String get scheduleMonday => translate('schedule_monday');
  String get scheduleTuesday => translate('schedule_tuesday');
  String get scheduleWednesday => translate('schedule_wednesday');
  String get scheduleThursday => translate('schedule_thursday');
  String get scheduleFriday => translate('schedule_friday');
  String get scheduleSaturday => translate('schedule_saturday');
  String get scheduleSunday => translate('schedule_sunday');
  String get scheduleEnabled => translate('schedule_enabled');
  String get scheduleDisabled => translate('schedule_disabled');
  String get scheduleEdit => translate('schedule_edit');
  String get scheduleDelete => translate('schedule_delete');
  String get scheduleSave => translate('schedule_save');
  String get scheduleCancel => translate('schedule_cancel');
  String get scheduleComingSoon => translate('schedule_coming_soon');
  String get scheduleNoSchedule => translate('schedule_no_schedule');
  
  String get settingsTitle => translate('settings_title');
  String get settingsBackendUrl => translate('settings_backend_url');
  String get settingsApiKey => translate('settings_api_key');
  String get settingsWeatherLocation => translate('settings_weather_location');
  String get settingsLanguage => translate('settings_language');
  String get settingsTheme => translate('settings_theme');
  String get settingsThemeDark => translate('settings_theme_dark');
  String get settingsThemeLight => translate('settings_theme_light');
  String get settingsNotifications => translate('settings_notifications');
  String get settingsNotificationsEnabled => translate('settings_notifications_enabled');
  String get settingsNotificationsDisabled => translate('settings_notifications_disabled');
  String get settingsSave => translate('settings_save');
  String get settingsComingSoon => translate('settings_coming_soon');
  String get settingsAbout => translate('settings_about');
  String get settingsVersion => translate('settings_version');
  String get settingsHelp => translate('settings_help');
  
  String get connectionGood => translate('connection_good');
  String get connectionWeak => translate('connection_weak');
  String get connectionPoor => translate('connection_poor');
  String get connectionOffline => translate('connection_offline');
  String get connectionArduino => translate('connection_arduino');
  String get connectionFirebase => translate('connection_firebase');
  String get connectionBackend => translate('connection_backend');
  
  String get errorConnection => translate('error_connection');
  String get errorDeviceControl => translate('error_device_control');
  String get errorWeatherLoad => translate('error_weather_load');
  String get errorInvalidInput => translate('error_invalid_input');
  String get errorTryAgain => translate('error_try_again');
  String get errorClose => translate('error_close');
  
  String get loading => translate('loading');
  String get save => translate('save');
  String get delete => translate('delete');
  String get edit => translate('edit');
  String get add => translate('add');
  String get back => translate('back');
  String get confirm => translate('confirm');
  String get cancel => translate('cancel');
  String get yes => translate('yes');
  String get no => translate('no');
  String get ok => translate('ok');
  String get refresh => translate('refresh');
  String get search => translate('search');
  String get filter => translate('filter');
  String get sort => translate('sort');
  String get more => translate('more');
  String get info => translate('info');
  String get time => translate('time');
  String get date => translate('date');
  String get duration => translate('duration');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['vi', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(AppLocalizations(locale.languageCode));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}
