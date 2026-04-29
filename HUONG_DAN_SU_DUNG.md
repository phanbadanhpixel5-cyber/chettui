# Hướng Dẫn Sử Dụng - TAO Device Controller

## Mục Lục

1. [Giới Thiệu](#giới-thiệu)
2. [Bắt Đầu Nhanh](#bắt-đầu-nhanh)
3. [Các Tính Năng Chính](#các-tính-năng-chính)
4. [Điều Khiển Thiết Bị](#điều-khiển-thiết-bị)
5. [Xem Thời Tiết](#xem-thời-tiết)
6. [Lập Lịch Trình](#lập-lịch-trình)
7. [Khắc Phục Sự Cố](#khắc-phục-sự-cố)
8. [FAQ](#faq)

---

## Giới Thiệu

TAO Device Controller là ứng dụng di động cho phép bạn:
- Điều khiển 4 thiết bị từ xa qua mạng WiFi hoặc Bluetooth
- Xem dữ liệu thời tiết theo thời gian thực
- Lập lịch trình tự động cho các thiết bị
- Theo dõi trạng thái kết nối của hệ thống

**Yêu Cầu:**
- Android 8.0+ hoặc iOS 12.0+
- Kết nối mạng WiFi hoặc Bluetooth
- Backend server TAO đang chạy

---

## Bắt Đầu Nhanh

### Cài Đặt Ứng Dụng

1. **Tải ứng dụng**
   - Android: Tải APK hoặc từ Google Play Store
   - iOS: Tải từ App Store

2. **Mở ứng dụng**
   - Nhấn biểu tượng TAO Device Controller

3. **Kết Nối Thiết Bị**
   - Ứng dụng sẽ tự động tìm kiếm backend server
   - Chờ tới khi thấy "Đã Kết Nối" ở phía trên màn hình

4. **Bắt Đầu Sử Dụng**
   - Nhấn vào các nút thiết bị để bật/tắt
   - Xem dữ liệu thời tiết
   - Tạo lịch trình nếu cần

---

## Các Tính Năng Chính

### Giao Diện Chính

Ứng dụng có 3 tab chính:

| Tab | Biểu Tượng | Chức Năng |
|-----|-----------|----------|
| **Trang Chủ** | 🏠 | Xem tất cả thiết bị, thời tiết, trạng thái |
| **Lịch Trình** | 📅 | Tạo và quản lý lịch trình tự động |
| **Cài Đặt** | ⚙️ | Tùy chỉnh ứng dụng |

### Trạng Thái Hệ Thống

Ở phía trên cùng màn hình, bạn sẽ thấy:

- **Đã Kết Nối** (xanh lá) - Hệ thống đang hoạt động bình thường
- **Chưa Kết Nối** (đỏ) - Không thể kết nối đến backend
- **Đang Kết Nối...** (vàng) - Đang cố gắng kết nối

---

## Điều Khiển Thiết Bị

### Bật/Tắt Thiết Bị

**Cách 1: Từ Trang Chủ**

1. Tìm thẻ thiết bị bạn muốn điều khiển
2. Nhấn nút **BẬT** để bật hoặc **TẮT** để tắt
3. Trạng thái sẽ cập nhật ngay lập tức

**Cách 2: Nhanh Chóng**
- Chỉ cần nhấn 1 lần vào thẻ thiết bị để chuyển đổi trạng thái

### Các Thiết Bị Có Sẵn

| Thiết Bị | GPIO | Mô Tả | Sử Dụng |
|---------|------|-------|--------|
| Thiết Bị 1 | GPIO 5 | Điều khiển thiết bị thứ nhất | Bật/Tắt |
| Thiết Bị 2 | GPIO 6 | Điều khiển thiết bị thứ hai | Bật/Tắt |
| Thiết Bị 3 | GPIO 7 | Điều khiển thiết bị thứ ba | Bật/Tắt |
| Thiết Bị 4 | Relay 4 | Điều khiển thiết bị thứ tư | Bật/Tắt |

### Hiểu Trạng Thái Thiết Bị

- **BẬT (màu xanh)** - Thiết bị đang hoạt động
- **TẮT (màu xám)** - Thiết bị đang tắt
- **Chỉnh Sửa** - Bạn có thể đổi tên thiết bị (tùy chọn)

---

## Xem Thời Tiết

### Thông Tin Thời Tiết

Trên tab **Trang Chủ**, bạn sẽ thấy widget thời tiết hiển thị:

- **Nhiệt Độ** - Nhiệt độ hiện tại (°C)
- **Cảm Giác** - Cảm giác nhiệt độ
- **Độ Ẩm** - Mức độ ẩm không khí (%)
- **Tốc Độ Gió** - Tốc độ gió (m/s)

### Cập Nhật Thời Tiết

- Thời tiết cập nhật tự động mỗi 10 phút
- Nhấn nút **Làm Mới** để cập nhật ngay lập tức
- Vị trí được xác định tự động dựa trên IP địa chỉ

### Giải Thích Ký Hiệu

| Ký Hiệu | Ý Nghĩa |
|--------|---------|
| ☀️ | Trời nắng |
| ☁️ | Trời mây |
| 🌧️ | Mưa |
| ⛈️ | Giông bão |
| ❄️ | Tuyết |

---

## Lập Lịch Trình

### Tạo Lịch Trình Mới

1. Nhấn tab **Lịch Trình**
2. Nhấn nút **+ Thêm Lịch Trình**
3. Điền thông tin:
   - **Tên Lịch Trình**: Ví dụ: "Bật quạt buổi sáng"
   - **Thiết Bị**: Chọn thiết bị từ danh sách
   - **Hành Động**: Chọn "BẬT" hoặc "TẮT"
   - **Thời Gian**: Chọn giờ và phút
   - **Ngày**: Chọn các ngày thực hiện

4. Nhấn **Lưu**

### Quản Lý Lịch Trình

**Sửa Lịch Trình:**
1. Nhấn vào lịch trình muốn sửa
2. Thay đổi thông tin
3. Nhấn **Lưu**

**Xóa Lịch Trình:**
1. Vuốt sang trái trên lịch trình
2. Nhấn **Xóa**

**Bật/Tắt Lịch Trình:**
- Nhấn nút chuyển đổi bên cạnh lịch trình để bật/tắt

### Ví Dụ Lịch Trình

**Lịch Trình 1: Bật Quạt Buổi Sáng**
- Tên: "Bật quạt 7 giờ sáng"
- Thiết Bị: Thiết Bị 1
- Hành Động: BẬT
- Thời Gian: 07:00
- Ngày: Thứ 2-6

**Lịch Trình 2: Tắt Đèn Trước Khi Đi Ngủ**
- Tên: "Tắt đèn 22 giờ"
- Thiết Bị: Thiết Bị 2
- Hành Động: TẮT
- Thời Gian: 22:00
- Ngày: Mỗi ngày

---

## Khắc Phục Sự Cố

### Vấn Đề 1: Không Thể Kết Nối

**Triệu Chứng:**
- Trạng thái hiển thị "Chưa Kết Nối" (đỏ)
- Không thể điều khiển thiết bị

**Giải Pháp:**

1. **Kiểm Tra Mạng**
   - Đảm bảo điện thoại kết nối WiFi
   - Kiểm Tra kết nối Bluetooth (nếu sử dụng)
   - Thử kết nối với mạng khác

2. **Kiểm Tra Backend**
   - Đảm bảo backend server đang chạy
   - Kiểm tra lại cấu hình IP
   - Khởi động lại backend

3. **Khởi Động Lại Ứng Dụng**
   - Đóng ứng dụng hoàn toàn
   - Chờ 10 giây
   - Mở lại ứng dụng

### Vấn Đề 2: Thiết Bị Không Phản Hồi

**Triệu Chứng:**
- Nhấn nút nhưng thiết bị không bật/tắt
- Trạng thái không thay đổi

**Giải Pháp:**

1. **Kiểm Tra Kết Nối**
   - Kiểm tra trạng thái hệ thống có còn xanh không
   - Thử cập nhật thủ công

2. **Kiểm Tra Arduino**
   - Kiểm tra Arduino có nguồn không
   - Kiểm tra dây nối GPIO
   - Xem Serial Monitor để gỡ lỗi

3. **Tải Lại Firmware**
   - Tải lại code Arduino
   - Xác minh COM port

### Vấn Đề 3: Thời Tiết Không Cập Nhật

**Triệu Chứng:**
- Thông tin thời tiết không thay đổi
- Hiển thị "Lỗi Cập Nhật"

**Giải Pháp:**

1. **Kiểm Tra Mạng**
   - Đảm bảo có kết nối Internet
   - Thử tắt VPN (nếu sử dụng)

2. **Kiểm Tra API Key**
   - Kiểm tra API key OpenWeatherMap
   - Xác minh API key còn hạn không

3. **Cập Nhật Thủ Công**
   - Vuốt xuống trên màn hình
   - Nhấn nút "Làm Mới"

### Vấn Đề 4: Lịch Trình Không Hoạt Động

**Triệu Chứng:**
- Lịch trình không kích hoạt đúng thời gian
- Thiết Bị không bật/tắt theo lịch

**Giải Pháp:**

1. **Kiểm Tra Lịch Trình**
   - Xác minh lịch trình được bật
   - Kiểm tra ngày và giờ chính xác
   - Kiểm tra múi giờ trên điện thoại

2. **Kiểm Tra Backend**
   - Backend phải chạy liên tục
   - Kiểm tra logs để tìm lỗi
   - Khởi động lại nếu cần

3. **Kiểm Tra Thiết Bị**
   - Xác minh thiết Bị được chọn đúng
   - Kiểm tra thiết bị có hoạt động manual không

---

## FAQ

### Câu Hỏi 1: Tôi Có Thể Điều Khiển Thiết Bị Từ Đâu?

**Trả Lời:**
- Miễn là có kết nối WiFi hoặc Bluetooth
- Nếu có tính năng cloud sync, bạn có thể điều khiển từ bất kỳ đâu có Internet

### Câu Hỏi 2: Lịch Trình Có Hoạt Động Khi Tắt Ứng Dụng Không?

**Trả Lời:**
- Có, miễn là backend server vẫn chạy
- Lịch trình được xử lý trên server, không phụ thuộc vào ứng dụng
- Ứng dụng chỉ là giao diện để quản lý

### Câu Hỏi 3: Tôi Có Thể Thêm Nhiều Thiết Bị Không?

**Trả Lời:**
- Hiện tại hệ thống hỗ trợ 4 thiết bị chính
- Để thêm nhiều hơn, cần sửa đổi backend và Arduino code

### Câu Hỏi 4: Tôi Quên Mật Khẩu Backend Làm Sao?

**Trả Lời:**
- Kiểm tra file .env trên backend
- Tìm biến FIREBASE_PASSWORD hoặc tương tự
- Đặt lại mật khẩu từ Firebase Console

### Câu Hỏi 5: Ứng Dụng Tiêu Thụ Bao Nhiêu Pin?

**Trả Lời:**
- Khoảng 1-2% pin mỗi giờ (WiFi)
- Khoảng 3-5% pin mỗi giờ (Bluetooth)
- Tùy thuộc vào tần suất sử dụng

### Câu Hỏi 6: Làm Sao Để Cập Nhật Vị Trí Thời Tiết?

**Trả Lời:**
- Ứng dụng tự động phát hiện vị trí từ IP
- Để thay đổi thủ công, hãy:
  1. Vào Cài Đặt
  2. Nhấn "Vị Trí Thời Tiết"
  3. Nhập tên thành phố mới

### Câu Hỏi 7: Tôi Có Thể Tạo Bao Nhiêu Lịch Trình?

**Trả Lời:**
- Không giới hạn về số lượng
- Chỉ phụ thuộc vào bộ nhớ backend
- Khuyến nghị: 100 lịch trình trở lên

### Câu Hỏi 8: Dữ Liệu Lịch Trình Được Lưu Ở Đâu?

**Trả Lời:**
- Dữ liệu được lưu trên Firebase
- Đồng bộ hóa giữa tất cả thiết bị
- Lưu trữ đám mây an toàn

---

## Mẹo và Thủ Thuật

### Mẹo 1: Sắp Xếp Lịch Trình Hợp Lý

Tạo tên lịch trình rõ ràng để dễ quản lý:
- ✅ "Bật quạt 7 sáng (Thứ 2-6)"
- ❌ "Quạt"

### Mẹo 2: Nhóm Lịch Trình Theo Chủ Đề

Dùng tiền tố để nhóm:
- "Sáng: Bật đèn"
- "Sáng: Bật quạt"
- "Tối: Tắt đèn"

### Mẹo 3: Theo Dõi Tiêu Thụ Điện

Tạo lịch trình để:
- Tắt thiết bị khi không sử dụng
- Chỉ bật vào giờ cần thiết

### Mẹo 4: Sử Dụng Thời Tiết Để Tự Động Hóa

Kết hợp thông tin thời tiết:
- Nếu chỉ số UV cao → Bật quạt
- Nếu mưa → Tắt các thiết bị ngoài trời

### Mẹo 5: Kiểm Tra Định Kỳ

Mỗi tuần:
- Kiểm tra lịch trình hoạt động đúng
- Xem nhật ký hoạt động (nếu có)
- Điều chỉnh nếu cần

---

## Liên Hệ Hỗ Trợ

**Gặp Vấn Đề?**

1. Đọc phần "Khắc Phục Sự Cố" trên
2. Kiểm tra FAQ
3. Xem logs trong phần Cài Đặt
4. Liên hệ nhóm phát triển

**Thông Tin Hữu Ích Cần Cung Cấp:**
- Phiên bản ứng dụng
- Hệ điều hành (Android/iOS)
- Thông báo lỗi đầy đủ
- Các bước để tái hiện lỗi

---

## Bản Quyền & Giấy Phép

TAO Device Controller © 2024. Tất cả quyền được bảo lưu.

**Version:** 1.0.0
**Ngôn Ngữ:** Tiếng Việt
**Cập Nhật Cuối:** 2024
