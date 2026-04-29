# Chạy Trên GitHub Codespaces - Hướng Dẫn Nhanh (5 Phút)

## KHÔNG CẦN MÁY TÍNH - CHỈ CẦN ĐIỆN THOẠI!

---

## ⚡ Nhanh Gọn (5 Phút)

### 1. Đăng Nhập GitHub
- Vào: github.com
- Đăng nhập tài khoản

### 2. Mở Dự Án
- Vào: github.com/YOUR_USERNAME/tao-device-controller

### 3. Mở Codespaces
```
1. Bấm nút xanh "Code"
2. Tab "Codespaces"
3. "Create codespace on main"
4. Chờ 30 giây
```

### 4. Chạy Server
```
1. Nhấn Ctrl + ` (mở terminal)
2. Gõ: cd backend
3. Gõ: npm install (chờ 3 phút)
4. Gõ: npm start
5. Chờ tới "Server started on port 5000"
```

### 5. Copy URL
- Tìm thông báo: "Your application is now available on..."
- Copy URL (ví dụ: https://xxx-5000.github.dev)

### 6. Trên Điện Thoại
- Mở ứng dụng TAO
- Settings → Backend URL
- Dán URL vừa copy
- Bấm Connect
- ✓ XONG!

---

## 📱 Trên Điện Thoại

### Tải Ứng Dụng

**Android:**
- GitHub Releases → Tải APK
- Mở APK → Cài đặt

**iPhone:**
- TestFlight → Tải app
- Hoặc build từ source

### Điều Khiển

| Chức Năng | Cách Làm |
|-----------|---------|
| Bật thiết bị | Tap nút thiết bị |
| Tắt thiết bị | Tap nút thiết bị |
| Xem thời tiết | Tab "Thời Tiết" |
| Lập lịch | Tab "Lịch Trình" |

---

## 🔑 Cài Đặt Environment

### File .env

```bash
# Trong Codespaces terminal

cd backend

# Tạo file .env
cp .env.example .env

# Sửa file:
# Nhấp vào file .env ở bên trái
# Điền:
FIREBASE_PROJECT_ID=your_project
OPENWEATHERMAP_API_KEY=your_key
```

---

## ⚠️ Vấn Đề Thường Gặp

### Không kết nối được

```
1. Kiểm tra URL đúng không
2. Server chạy không (xem terminal)
3. Restart: Ctrl+C → npm start
```

### Server bị dừng

```
1. Codespace tự dừng sau 30 phút
2. Truy cập github.com/codespaces
3. Click để bật lại
4. npm start
```

### Lỗi "Port already in use"

```
Giải pháp: Ctrl+C → npm start
```

---

## 💰 Chi Phí

- **Miễn phí:** 60 giờ/tháng
- **Đủ dùng:** ~2 giờ/ngày
- **Pro:** Không giới hạn

---

## 🎯 Tóm Tắt

✓ Mở GitHub
✓ Click Code → Codespaces → Create
✓ cd backend && npm install && npm start
✓ Copy URL
✓ Dán vào app
✓ Done!

---

**Time: 5 phút | Cost: MIỄN PHÍ | Needs: Trình duyệt + Điện thoại**
