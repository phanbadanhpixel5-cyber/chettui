# QUICK REFERENCE - HƯỚNG DẪN NHANH (Cheat Sheet)

## Các Tính Năng Chính

| Tính Năng | Cách Sử Dụng | Kết Quả |
|-----------|-----------|--------|
| **Bật Thiết Bị 1** | Nhấn Nút 1 | Thiết Bị 1 bật |
| **Tắt Thiết Bị 1** | Nhấn Nút 1 (lần 2) | Thiết Bị 1 tắt |
| **Xem Thời Tiết** | Tab "Trang Chủ" | Hiện dữ liệu thời tiết |
| **Cập Nhật Thời Tiết** | Vuốt xuống → Làm Mới | Lấy dữ liệu mới |
| **Tạo Lịch Trình** | Tab "Lịch Trình" → Thêm | Tạo tự động |
| **Sửa Lịch Trình** | Nhấn vào lịch → Sửa | Thay đổi thông tin |
| **Xóa Lịch Trình** | Vuốt trái → Xóa | Xóa khỏi hệ thống |

---

## LED Báo Trạng Thái

| Kiểu LED | Ý Nghĩa | Hành Động |
|---------|--------|----------|
| 🔴 Nhấp Nháy Nhanh | Chưa kết nối | Chờ kết nối |
| 🟡 Nhấp Nháy Chậm | Đã kết nối, chờ lệnh | Bình thường |
| 🟢 Sáng Liên Tục | Đang xử lý | Chờ hoàn tất |
| ⚫ Tắt Hoàn Toàn | Hệ Thống Lỗi | Khởi động lại |

---

## Các Nút Điều Khiển

### Nút 1 (GPIO 5)
```
1 lần nhấn → Thiết Bị 1 BẬT
2 lần nhấn → Thiết Bị 1 TẮT
3 lần nhấn → Thiết Bị 1 BẬT
...
```

### Nút 2 (GPIO 6)
```
1 lần nhấn → Thiết Bị 2 BẬT
2 lần nhấn → Thiết Bị 2 TẮT
...
```

### Nút 3 (GPIO 7)
```
1 lần nhấn → Thiết Bị 3 BẬT
2 lần nhấn → Thiết Bị 3 TẮT
...
```

---

## Trạng Thái Kết Nối

| Hiển Thị | Ý Nghĩa | Giải Pháp |
|---------|--------|----------|
| 🟢 Đã Kết Nối | Hệ thống OK | Sử dụng bình thường |
| 🔴 Chưa Kết Nối | Mất kết nối backend | Kiểm tra backend, WiFi |
| 🟡 Đang Kết Nối... | Đang kết nối | Chờ vài giây |

---

## Vấn Đề & Giải Pháp Nhanh

### ❌ Nút Không Phản Hồi
1. Kiểm Tra LED → Còn sáng không?
2. Kiểm Tra kết nối → Đã kết nối chưa?
3. Nhấn mạnh lên nút
4. Khởi động lại Arduino

### ❌ Không Kết Nối Backend
1. Kiểm Tra WiFi có bật không
2. Kiểm Tra backend server đang chạy không
3. Khởi động lại ứng dụng
4. Khởi động lại Arduino

### ❌ Lịch Trình Không Hoạt Động
1. Kiểm Tra backend chạy không
2. Kiểm Tra lịch trình được bật không
3. Kiểm Tra ngày giờ đúng không
4. Kiểm Tra múi giờ điện thoại

### ❌ Thời Tiết Không Cập Nhật
1. Kiểm Tra có Internet không
2. Kiểm Tra API Key
3. Nhấn "Làm Mới" thủ công
4. Chờ 10 phút cập nhật tự động

---

## Phím Tắt Nhanh

### Trên Ứng Dụng

| Hành Động | Kết Quả |
|-----------|--------|
| Nhấn 1 lần vào thẻ thiết bị | Bật/Tắt |
| Vuốt xuống | Làm mới dữ liệu |
| Vuốt sang trái (lịch trình) | Xóa lịch trình |
| Nhấn nút 3 dấu chấm | Tùy chọn thêm |
| Nhấn nút "+" | Thêm mục mới |

---

## Các Chế Độ Làm Việc

### Chế Độ Thường (Normal)
- Điều khiển thiết bị bình thường
- Lịch trình chạy tự động
- Thời tiết cập nhật mỗi 10 phút

### Chế Độ Offline (Offline Mode)
- Không thể điều khiển các thiết bị từ xa
- Lịch trình chạy trên Arduino cục bộ
- Ứng dụng hiển thị trạng thái lần cuối

### Chế Độ Kỹ Thuật (Debug Mode)
- Xem nhật ký chi tiết
- Kiểm tra lỗi
- Giúp khắc phục sự cố

---

## Ngưỡng & Giới Hạn

| Thông Số | Giá Trị | Chú Ý |
|---------|--------|-------|
| Số Lịch Trình Tối Đa | Không Giới Hạn | Tùy bộ nhớ server |
| Số Thiết Bị | 4 (có thể mở rộng) | Hiện tại: 4 thiết bị |
| Cập Nhật Thời Tiết | 10 phút | Có thể làm mới thủ công |
| Tần Số Sync | Real-time | Liên tục khi có thay đổi |
| Debounce Nút | 50ms | Chống rung nút |
| Timeout Backend | 30 giây | Mất kết nối sau 30s |

---

## Công Thức Nhanh

### Tính Thời Gian Nhấp Nháy LED
```
Tần suất = 1000ms ÷ Chu kỳ
- Nhấp nháy nhanh: 200ms = 5 lần/giây
- Nhấp nháy chậm: 1000ms = 1 lần/giây
```

### Chuyển Đổi Nhiệt Độ
```
°F = (°C × 9/5) + 32
°C = (°F - 32) × 5/9
```

### Tính Thời Gian Sáng LED
```
Thời gian Sáng = Chu kỳ ÷ 2
- 200ms chu kỳ → 100ms sáng
- 1000ms chu kỳ → 500ms sáng
```

---

## Menu Nhanh

### Menu Trang Chủ
```
┌─ Thiết Bị
│  ├─ Thiết Bị 1: [BẬT] [TẮT]
│  ├─ Thiết Bị 2: [BẬT] [TẮT]
│  ├─ Thiết Bị 3: [BẬT] [TẮT]
│  └─ Thiết Bị 4: [BẬT] [TẮT]
├─ Thời Tiết
│  ├─ Nhiệt độ: 28°C
│  ├─ Độ Ẩm: 65%
│  ├─ Gió: 5 m/s
│  └─ [Làm Mới]
└─ Trạng Thái: [Đã Kết Nối]
```

### Menu Lịch Trình
```
┌─ [+ Thêm Lịch Trình]
├─ Lịch Trình 1
│  ├─ Bật Quạt 7 Sáng (Thứ 2-6)
│  ├─ [Sửa] [Xóa] [Toggle]
└─ Lịch Trình 2
   ├─ Tắt Đèn 22 Giờ (Hàng Ngày)
   └─ [Sửa] [Xóa] [Toggle]
```

---

## Tổ Chức Thư Mục

```
Project/
├─ backend/
│  ├─ server.js (chạy dưới cùng)
│  ├─ controllers/
│  └─ services/
├─ flutter/
│  ├─ lib/
│  │  ├─ main.dart
│  │  ├─ screens/
│  │  └─ providers/
│  └─ pubspec.yaml
├─ arduino/
│  └─ DeviceController.ino (tải lên Arduino)
├─ HUONG_DAN_SU_DUNG.md (đang đọc)
├─ HUONG_DAN_NUT_DIEU_KHIEN.md
└─ README.md
```

---

## Bắt Đầu Trong 5 Phút

1. **Bật Backend** (30 giây)
   ```bash
   cd backend
   npm start
   ```

2. **Tải Arduino** (1 phút)
   - Mở DeviceController.ino
   - Upload lên Arduino

3. **Chạy Ứng Dụng** (1 phút)
   ```bash
   flutter run
   ```

4. **Kiểm Tra LED** (30 giây)
   - LED sáng = OK
   - LED tắt = Lỗi

5. **Thử Nút** (2 phút)
   - Nhấn Nút 1 → Thẻ Thiết Bị 1 thay đổi
   - Thành công!

---

## Liên Hệ Nhanh

**Lỗi Phổ Biến:**
- Xem `HUONG_DAN_SU_DUNG.md` → Khắc Phục Sự Cố
- Xem `HUONG_DAN_NUT_DIEU_KHIEN.md` → Khắc Phục Sự Cố

**Cần Chi Tiết:**
- Xem `README.md` → Tổng Quan Dự Án
- Xem `SETUP_GUIDE.md` → Cài Đặt Chi Tiết

**Vấn Đề Kỹ Thuật:**
- Xem `PROJECT_SUMMARY.md` → Kiến Trúc
- Kiểm Tra Source Code → Xem Cách Thực Hiện

---

**Phiên Bản:** 1.0.0
**Ngôn Ngữ:** Tiếng Việt
**Loại:** Quick Reference
**Cập Nhật:** 2024

💡 **Mẹo:** Lưu file này vào điện thoại để tham khảo nhanh khi cần!
