# Hướng Dẫn Chạy TAO Device Controller Trên GitHub Codespaces

## Không Cần Máy Tính - Chỉ Cần Điện Thoại & Trình Duyệt!

---

## 📋 Yêu Cầu

- Tài khoản GitHub (miễn phí)
- Điện thoại hoặc máy tính bảng
- Trình duyệt (Chrome, Safari, Firefox)
- Kết nối Internet

**Chi Phí:** HOÀN TOÀN MIỄN PHÍ!

---

## 🚀 Bước 1: Tạo Repository Từ Dự Án Này

### 1. Truy Cập Dự Án Hiện Tại

Tôi giả định bạn đã có dự án trên GitHub. Nếu chưa:

```
1. Đi tới: https://github.com/new
2. Repository name: tao-device-controller
3. Description: IoT Device Control System
4. Chọn "Public"
5. Click "Create repository"
```

### 2. Push Code Lên GitHub

Nếu code chưa trên GitHub, bạn cần push. Nhưng vì không có máy tính, hãy:

**Cách 1: Upload trực tiếp trên GitHub Web**
```
1. Click "Add file" → "Create new file"
2. Paste code từ dự án
3. Commit
```

**Cách 2: Fork dự án (Nếu có sẵn)**
```
1. Truy cập repo gốc
2. Click "Fork"
3. Chọn account của bạn
```

---

## 🔧 Bước 2: Mở GitHub Codespaces

### Mở Từ GitHub Web

```
1. Truy cập: https://github.com/YOUR_USERNAME/tao-device-controller
2. Click nút xanh "Code" (góc trên phải)
3. Chọn tab "Codespaces"
4. Click "Create codespace on main"
5. Chờ ~30 giây để tải
```

### Giao Diện Codespaces Sẽ Hiển Thị

```
┌─────────────────────────────────────┐
│ VS Code (Trình Editor Online)      │
├─────────────────────────────────────┤
│ • Cây thư mục bên trái              │
│ • Editor mã ở giữa                  │
│ • Terminal ở dưới                   │
└─────────────────────────────────────┘
```

---

## 📁 Bước 3: Cấu Trúc Dự Án

Trong Codespaces, bạn sẽ thấy:

```
tao-device-controller/
├── backend/          (Node.js Server)
│   ├── server.js
│   ├── package.json
│   └── ...
├── flutter/          (App mobile)
│   ├── lib/
│   └── pubspec.yaml
├── arduino/          (Code Arduino)
│   └── DeviceController.ino
└── Documentation/    (Các hướng dẫn)
```

---

## 🎯 Bước 4: Chạy Backend Server

### 4.1 Mở Terminal

```
1. Bấm Ctrl + ` (backtick)
   hoặc
2. Click View → Terminal
```

### 4.2 Điều Hướng Tới Backend

```bash
cd backend
```

### 4.3 Cài Đặt Dependencies

```bash
npm install
```

Chờ 2-3 phút để tải các thư viện.

### 4.4 Chạy Server

```bash
npm start
```

Bạn sẽ thấy:

```
✓ Server started on port 5000
✓ Connected to Firebase
✓ Ready to receive commands
```

### 4.5 Lấy Public URL

Codespaces sẽ tự động tạo URL công khai:

```
Notification sẽ hiện: "Your application is now available on..."
URL sẽ giống: https://XXXXX-5000.github.dev
```

**Sao chép URL này - bạn sẽ cần nó cho điện thoại!**

---

## 📱 Bước 5: Kết Nối Từ Điện Thoại

### Trên Điện Thoại Android/iPhone

1. **Mở ứng dụng Flutter** (nếu đã cài)
   - Hoặc download APK từ GitHub Releases

2. **Đi tới Settings/Cài Đặt**
   - Tìm "Backend URL"
   - Dán URL từ Codespaces: `https://XXXXX-5000.github.dev`

3. **Kết Nối**
   - Bấm "Connect"
   - Chờ 3-5 giây
   - Sẽ hiển thị: "Connected ✓"

4. **Điều Khiển Thiết Bị**
   - Bắt đầu bật/tắt thiết bị
   - Xem dữ liệu thời tiết
   - Lập lịch trình

---

## 🌐 Bước 6: Giám Sát Server

### Xem Logs (Nhật Ký)

Terminal sẽ hiển thị mọi hoạt động:

```
[5000] Device 1 turned ON
[5000] Device 2 turned OFF
[5000] Weather updated: 28°C
[5000] Schedule executed
```

### Debug Lỗi

Nếu gặp lỗi:

```
1. Xem thông báo lỗi trong terminal
2. Kiểm tra URL có đúng không
3. Kiểm tra kết nối Internet
4. Restart server: Bấm Ctrl+C, rồi npm start
```

---

## ⏰ Bước 7: Duy Trì Codespace

### Thời Gian Hoạt Động

- **Miễn Phí:** 60 giờ/tháng
- **Pro Plan:** Không giới hạn
- Tự động tắt sau 30 phút không sử dụng

### Cách Quản Lý

```
1. Truy cập: https://github.com/codespaces
2. Xem Codespaces đang chạy
3. Bấm "..." → "Delete" để xóa
4. Bấn "..." → "Stop" để dừng tạm thời
```

### Tiếp Tục Sau

```
1. Truy cập GitHub
2. Click "Code"
3. Chọn Codespace từ danh sách
4. Click để tiếp tục
```

---

## 🔑 Bước 8: Cấu Hình (Quan Trọng!)

### Thiết Lập Environment Variables

Codespace sẽ cần `.env` file:

```bash
# Trong terminal Codespaces

# Tạo .env file
cd backend
cp .env.example .env

# Chỉnh sửa file
# Nhập các giá trị:
# - Firebase URL
# - OpenWeatherMap API Key
# - Arduino COM Port
```

### Thêm Environment Secrets

```
1. Codespaces Settings
2. Thêm Secret Variables
3. Điền Firebase Key, API Keys
```

---

## 🎮 Bước 9: Sử Dụng Toàn Bộ

### Các Tính Năng Có Sẵn

| Tính Năng | Hoạt Động |
|-----------|-----------|
| Điều Khiển Thiết Bị | ✓ (qua điện thoại) |
| Xem Thời Tiết | ✓ (từ API) |
| Lập Lịch Trình | ✓ (lưu trên Firebase) |
| Nút Vật Lý | ⚠ (cần Arduino kết nối) |
| LED Báo Trạng Thái | ⚠ (cần Arduino kết nối) |

### Các Giới Hạn

- **Codespaces:** Chỉ backend server
- **Arduino:** Cần máy tính riêng để upload (hoặc Codespace khác)
- **Flutter App:** Cần build APK hoặc từ App Store

---

## 🛠️ Bước 10: Khắc Phục Sự Cố

### Lỗi "Cannot connect"

```
Giải pháp:
1. Kiểm tra URL có đúng không
2. Server có chạy không (kiểm tra terminal)
3. Kiểm tra Internet có tốt không
4. Restart server: Ctrl+C → npm start
```

### Lỗi "Firebase not connected"

```
Giải pháp:
1. Kiểm tra .env file có Firebase key không
2. Kiểm tra Firebase account có hoạt động không
3. Xem logs: npm start (debug mode)
```

### Lỗi "Port 5000 already in use"

```
Giải pháp:
1. Terminal: lsof -i :5000
2. Kill process: kill -9 <PID>
3. Hoặc Ctrl+C rồi npm start lại
```

### Server Bị Dừng

```
Giải pháp:
1. Codespace tự động dừng sau 30 phút không dùng
2. Truy cập GitHub Codespaces
3. Click để khởi động lại
4. npm start
```

---

## 💡 Mẹo & Thủ Thuật

### Giữ Codespace Sống

```bash
# Chạy lệnh này trong terminal
while true; do echo "keeping alive"; sleep 30m; done &
```

### Xem Logs Chi Tiết

```bash
npm start -- --verbose
```

### Tạo Alias Nhanh

```bash
alias start-server="cd ~/tao-device-controller/backend && npm start"
```

### Tắt Tự Động

- Đóng tab Codespaces
- Nó sẽ tự động lưu
- Có thể tiếp tục bất kỳ lúc nào

---

## 🔒 Bảo Mật

### Giữ Secrets An Toàn

```
❌ KHÔNG: Commit .env vào GitHub
✓ OK: Sử dụng Codespaces Secrets
✓ OK: Sử dụng Environment Variables
```

### Quản Lý API Keys

```
1. Firebase Key → Codespaces Secret
2. OpenWeatherMap Key → Codespaces Secret
3. Không bao giờ push vào GitHub
```

---

## 📞 Liên Hệ & Hỗ Trợ

### GitHub Support

- https://docs.github.com/codespaces
- https://github.com/github/feedback

### Dự Án Support

- Xem: GITHUB_SETUP_GUIDE.md
- Xem: HUONG_DAN_SU_DUNG.md
- Xem: QUICK_REFERENCE.md

---

## ✅ Checklist Hoàn Tất

- [ ] Tài khoản GitHub tạo
- [ ] Dự án push lên GitHub
- [ ] Codespace tạo thành công
- [ ] Backend dependencies cài (npm install)
- [ ] Server chạy (npm start)
- [ ] URL công khai lấy được
- [ ] Kết nối từ điện thoại thành công
- [ ] Có thể điều khiển thiết bị
- [ ] Xem được thời tiết
- [ ] Lập lịch trình được

---

## 🎉 Thành Công!

Bây giờ bạn có thể:

✓ Chạy backend từ bất kỳ đâu (chỉ cần trình duyệt)
✓ Điều khiển thiết bị từ điện thoại
✓ Không cần máy tính
✓ Hoàn toàn miễn phí
✓ Dữ liệu lưu trên cloud

---

## 📌 Ghi Chú Quan Trọng

### Khi Nào Codespace Bị Xóa?

- Tự động sau 30 giây không dùng (được tạo lại dễ dàng)
- Sau 30 ngày không sử dụng (xóa toàn bộ)
- Khi bạn xóa thủ công

### Cách Giữ Dữ Liệu

- Dữ liệu lưu trên Firebase (cloud)
- Lịch trình không mất
- Trạng thái thiết bị được lưu

### Nếu Cần Máy Tính

- Arduino upload: Cần máy tính với Arduino IDE
- Build APK: Có thể dùng Codespaces + EAS Build (miễn phí)

---

## 🚀 Bắt Đầu Ngay Bây Giờ!

1. Truy cập GitHub
2. Mở dự án
3. Click "Code" → "Codespaces" → "Create"
4. Chờ tải
5. Chạy: `cd backend && npm install && npm start`
6. Lấy URL → Dán vào app
7. Xong!

**Chúc bạn thành công! Happy Coding! 🎉**

---

**Version:** 1.0.0
**Language:** Tiếng Việt
**Last Updated:** 2024
**Status:** Sẵn Sàng Sử Dụng
