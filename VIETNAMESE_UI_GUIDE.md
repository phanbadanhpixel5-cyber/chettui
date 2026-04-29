# Hướng Dẫn Giao Diện Tiếng Việt

## Tổng Quan

Ứng dụng TAO Device Controller đã được cập nhật với giao diện tiếng Việt hoàn chỉnh. Tất cả các nhãn, nút, và thông báo đều hiển thị bằng tiếng Việt.

## Các Thay Đổi Chính

### 1. Hệ Thống Bản Địa Hóa (Localization)

- **Tập tin mới**: `lib/l10n/app_localizations.dart`
- Chứa tất cả các chuỗi tiếng Việt
- Hỗ trợ mở rộng cho nhiều ngôn ngữ

### 2. Giao Diện Tiếng Việt

#### Tiêu đề Ứng Dụng
- Tiếng Anh: "TAO Device Controller"
- Tiếng Việt: "Bộ Điều Khiển Thiết Bị TAO"

#### Menu Điều Hướng
- **Trang Chủ** (Home) - Hiển thị các thiết bị và thời tiết
- **Lịch Trình** (Schedule) - Quản lý lịch trình tự động
- **Cài Đặt** (Settings) - Cấu hình ứng dụng

#### Điều Khiển Thiết Bị
- **BẬT** - Thiết bị đang bật
- **TẮT** - Thiết bị đang tắt
- **Trạng Thái** - Hiển thị trạng thái hiện tại

#### Thông Tin Thời Tiết
- **Nhiệt Độ** - °C
- **Độ Ẩm** - %
- **Tốc Độ Gió** - km/h
- **Điều Kiện** - Mô tả thời tiết

#### Trạng Thái Kết Nối
- **Đã Kết Nối** - Kết nối tốt
- **Chưa Kết Nối** - Mất kết nối
- **Đang Kết Nối...** - Đang kết nối
- **Lỗi Kết Nối** - Có lỗi

### 3. Các Bản Dịch Chính

```dart
// Ứng dụng
'app_title': 'Bộ Điều Khiển Thiết Bị TAO'

// Điều Hướng
'nav_home': 'Trang Chủ'
'nav_schedule': 'Lịch Trình'
'nav_settings': 'Cài Đặt'
'nav_weather': 'Thời Tiết'

// Thiết Bị
'devices_title': 'Thiết Bị'
'devices_empty': 'Không có thiết bị nào được kết nối'
'device_on': 'BẬT'
'device_off': 'TẮT'

// Thời Tiết
'weather_temperature': 'Nhiệt Độ'
'weather_humidity': 'Độ Ẩm'
'weather_wind_speed': 'Tốc Độ Gió'

// Lịch Trình
'schedule_title': 'Lịch Trình'
'schedule_add_new': 'Thêm Lịch Trình'
'schedule_days': 'Ngày Trong Tuần'

// Cài Đặt
'settings_title': 'Cài Đặt'
'settings_language': 'Ngôn Ngữ'
'settings_theme': 'Giao Diện'
```

## Cách Thêm Ngôn Ngữ Mới

Để thêm ngôn ngữ mới (ví dụ: tiếng Anh), chỉnh sửa file `lib/l10n/app_localizations.dart`:

```dart
static const Map<String, Map<String, String>> _localizedStrings = {
  'vi': {
    // ... Tiếng Việt
  },
  'en': {
    // Thêm các bản dịch tiếng Anh ở đây
    'app_title': 'TAO Device Controller',
    'nav_home': 'Home',
    // ...
  },
};
```

Sau đó cập nhật `lib/main.dart` để hỗ trợ ngôn ngữ mới:

```dart
supportedLocales: const [
  Locale('vi'),
  Locale('en'),
  Locale('fr'), // Ví dụ: thêm tiếng Pháp
],
```

## Sử Dụng Bản Địa Hóa Trong Widget

### Cách 1: Sử dụng AppLocalizations trực tiếp

```dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Text(l10n.appTitle);
  }
}
```

### Cách 2: Sử dụng phương thức getter

```dart
String title = AppLocalizations.of(context).navHome;
```

### Cách 3: Sử dụng phương thức translate

```dart
String text = AppLocalizations.of(context).translate('device_on');
```

## Danh Sách Các Nhãn Tiếng Việt

### Tiêu Đề
- `app_title` = "Bộ Điều Khiển Thiết Bị TAO"
- `devices_title` = "Thiết Bị"
- `weather_title` = "Thời Tiết"
- `schedule_title` = "Lịch Trình"
- `settings_title` = "Cài Đặt"

### Nút Bấm
- `save` = "Lưu"
- `delete` = "Xóa"
- `edit` = "Chỉnh Sửa"
- `add` = "Thêm"
- `cancel` = "Hủy"
- `confirm` = "Xác Nhận"

### Trạng Thái
- `device_on` = "BẬT"
- `device_off` = "TẮT"
- `status_connected` = "Đã Kết Nối"
- `status_disconnected` = "Chưa Kết Nối"
- `status_connecting` = "Đang Kết Nối..."

### Thời Tiết
- `weather_temperature` = "Nhiệt Độ"
- `weather_humidity` = "Độ Ẩm"
- `weather_wind_speed` = "Tốc Độ Gió"
- `weather_degree` = "°C"

## Kiểm Tra Giao Diện Tiếng Việt

1. Chạy ứng dụng Flutter:
   ```bash
   flutter run
   ```

2. Kiểm tra các màn hình sau:
   - ✓ Tiêu đề ứng dụng hiển thị "Bộ Điều Khiển Thiết Bị TAO"
   - ✓ Menu điều hướng: "Trang Chủ", "Lịch Trình", "Cài Đặt"
   - ✓ Nhãn thiết bị: "Thiết Bị", "BẬT", "TẮT"
   - ✓ Thông tin thời tiết: "Nhiệt Độ", "Độ Ẩm", "Tốc Độ Gió"
   - ✓ Trạng thái kết nối: "Đã Kết Nối" hoặc "Chưa Kết Nối"

## Mẹo Bảo Trì

- Tất cả các chuỗi được tập trung trong một file (`app_localizations.dart`)
- Thêm chuỗi mới: chỉnh sửa `_localizedStrings` map
- Thêm getter mới: thêm property getter tương ứng
- Hỗ trợ ngôn ngữ mới: thêm mục mới vào map và cập nhật `supportedLocales`

## Chuyển Đổi Ngôn Ngữ (Tương Lai)

Để cho phép người dùng chuyển đổi ngôn ngữ, có thể thêm vào cài đặt:

```dart
// Trong SettingsTab, thêm dropdown để chọn ngôn ngữ
DropdownButton(
  value: selectedLanguage,
  onChanged: (newLanguage) {
    setState(() {
      selectedLanguage = newLanguage;
      // Thay đổi locale
    });
  },
  items: [
    DropdownMenuItem(value: 'vi', child: Text('Tiếng Việt')),
    DropdownMenuItem(value: 'en', child: Text('English')),
  ],
)
```

## Liên Hệ & Hỗ Trợ

Nếu cần thêm hoặc chỉnh sửa bản dịch:
1. Chỉnh sửa `lib/l10n/app_localizations.dart`
2. Thêm chuỗi mới vào map tiếng Việt
3. Thêm getter mới nếu cần
4. Cập nhật các widget để sử dụng bản dịch mới

---

**Phiên Bản**: 1.0.0  
**Ngôn Ngữ Chính**: Tiếng Việt (vi)  
**Ngôn Ngữ Hỗ Trợ**: Tiếng Anh (en)
