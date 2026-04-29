# Hướng Dẫn Sử Dụng Các Nút Điều Khiển - TAO Device Controller

## Mục Lục

1. [Các Nút Vật Lý](#các-nút-vật-lý)
2. [Cách Sử Dụng](#cách-sử-dụng)
3. [LED Báo Trạng Thái](#led-báo-trạng-thái)
4. [Tính Năng Nâng Cao](#tính-năng-nâng-cao)

---

## Các Nút Vật Lý

Hệ thống TAO Device Controller có 3 nút điều khiển vật lý kết nối với Arduino:

| Nút | GPIO | Chức Năng | Vị Trí |
|-----|------|----------|--------|
| **Nút 1** | GPIO 5 | Điều khiển Thiết Bị 1 | Phía trước |
| **Nút 2** | GPIO 6 | Điều khiển Thiết Bị 2 | Phía trước |
| **Nút 3** | GPIO 7 | Điều khiển Thiết Bị 3 | Phía trước |

### Cách Nhận Biết Các Nút

```
┌─────────────────────────────────────┐
│  TAO DEVICE CONTROLLER              │
│  ┌─────────────────────────────┐    │
│  │   LCD DISPLAY (optional)    │    │
│  └─────────────────────────────┘    │
│                                     │
│   ⚫    ⚫    ⚫                       │
│  Nút 1 Nút 2 Nút 3                  │
│                                     │
└─────────────────────────────────────┘
```

---

## Cách Sử Dụng

### Bật/Tắt Thiết Bị Qua Nút Vật Lý

**Nút 1 - Điều khiển Thiết Bị 1:**
```
1. Nhấn nút 1 một lần → Thiết Bị 1 bật
2. Nhấn nút 1 lần thứ hai → Thiết Bị 1 tắt
3. Nhấn nút 1 lần thứ ba → Thiết Bị 1 bật
```

**Nút 2 - Điều khiển Thiết Bị 2:**
```
1. Nhấn nút 2 một lần → Thiết Bị 2 bật
2. Nhấn nút 2 lần thứ hai → Thiết Bị 2 tắt
...
```

**Nút 3 - Điều khiển Thiết Bị 3:**
```
Tương tự như nút 1 và 2
```

### Nhấn Nhanh vs Nhấn Lâu

| Kiểu Nhấn | Hành Động | Kết Quả |
|-----------|----------|--------|
| **Nhấn 1 lần (< 1 giây)** | Toggle thiết bị | Bật/Tắt |
| **Nhấn 2 lần nhanh** | Reset | Quay về trạng thái ban đầu |
| **Nhấn lâu (> 3 giây)** | Chế độ kỹ thuật | Xem thông tin debug |

### Thứ Tự Hoạt Động

1. **Nhấn Nút**
   - Khi bạn nhấn một nút
   - Arduino sẽ phát hiện tín hiệu

2. **LED Nhấp Nháy**
   - LED báo trạng thái sẽ nhấp nháy để xác nhận
   - Xem phần "LED Báo Trạng Thái"

3. **Gửi Lệnh**
   - Arduino gửi tín hiệu đến backend qua serial
   - Backend nhận lệnh và xử lý

4. **Cập Nhật Ứng Dụng**
   - Ứng dụng nhận được cập nhật
   - Giao diện thay đổi ngay lập tức

---

## LED Báo Trạng Thái

Hệ thống có một LED báo trạng thái kết nối với GPIO 8

### Các Chế Độ LED

#### 1. Nhấp Nháy Nhanh (Mỗi 0.2 giây)
```
LED: Bật - Tắt - Bật - Tắt - ...
Ý Nghĩa: Hệ thống CHƯA kết nối với backend
Hành Động: Chờ kế nối hoặc kiểm tra backend
```

#### 2. Nhấp Nháy Chậm (Mỗi 1 giây)
```
LED: Bật 0.5s - Tắt 0.5s - Bật 0.5s - ...
Ý Nghĩa: Hệ thống ĐÃ kết nối nhưng không hoạt động
Hành Động: Bình thường, chờ lệnh
```

#### 3. Sáng Liên Tục
```
LED: Sáng liên tục
Ý Nghĩa: Hệ thống đang xử lý lệnh
Hành Động: Chờ hoàn tất
```

#### 4. Tắt Hoàn Toàn
```
LED: Tắt hoàn toàn
Ý Nghĩa: Hệ thống bị lỗi hoặc Arduino bị lỗi
Hành Động: Khởi động lại Arduino
```

### Thay Đổi LED Khi Nhấn Nút

Mỗi khi bạn nhấn một nút (1, 2 hoặc 3):

1. **Trước Khi Nhấn**
   - LED nhấp nháy theo chế độ bình thường

2. **Khi Nhấn**
   - LED sáng đầy để xác nhận
   - Giữ sáng trong 0.5 giây

3. **Sau Khi Nhấn**
   - LED quay lại chế độ bình thường
   - Thay đổi kiểu nhấp nháy nếu trạng thái thay đổi

---

## Tính Năng Nâng Cao

### Phối Hợp Các Nút

Bạn có thể sử dụng các nút cùng lúc:

```
Nhấn Nút 1 + Nút 2 (cùng lúc):
  → Bật Thiết Bị 1 và 2 cùng lúc
  → LED sáng đầy
  → Backend nhận hai lệnh
```

### Kiểm Tra Kết Nối

**Cách 1: Qua LED**
- Nếu LED nhấp nháy nhanh → Chưa kết nối
- Nếu LED nhấp nháy chậm → Đã kết nối

**Cách 2: Nhấn Nút Kiểm Tra**
- Nhấn bất kỳ nút nào
- Nếu thiết bị không phản hồi → Mất kết nối

**Cách 3: Qua Ứng Dụng**
- Xem trạng thái hệ thống ở phía trên
- "Đã Kết Nối" (xanh) hoặc "Chưa Kết Nối" (đỏ)

### Xem Nhật Ký Hoạt Động

Khi bạn nhấn nút, Arduino ghi lại:
- Thời gian nhấn
- Nút nào được nhấn
- Hành động được thực hiện
- Kết Quả

Để xem nhật ký:
1. Mở Arduino IDE
2. Vào Tools → Serial Monitor
3. Đặt baud rate: 9600
4. Nhấn các nút để xem log

### Tùy Chỉnh Chế Độ LED

Để thay đổi tốc độ nhấp nháy LED:

1. Mở file `arduino/DeviceController.ino`
2. Tìm biến `LED_BLINK_SPEED`
3. Thay đổi giá trị (ms - milliseconds)
   - Nhấp nháy nhanh: 200ms
   - Nhấp nháy chậm: 1000ms
   - Có thể tuỳ chỉnh

---

## Khắc Phục Sự Cố

### Vấn Đề 1: Nút Không Phản Hồi

**Triệu Chứng:**
- Nhấn nút nhưng không có gì xảy ra
- LED không thay đổi

**Giải Pháp:**

1. **Kiểm Tra Nút**
   - Kiểm tra dây nối GPIO
   - Thử nhấn nút rất mạnh
   - Kiểm tra liên kết có lỏng không

2. **Kiểm Tra Arduino**
   - Tải lại code Arduino
   - Kiểm tra COM port
   - Xem Serial Monitor để debug

3. **Kiểm Tra Backend**
   - Đảm bảo backend đang chạy
   - Kiểm tra kết nối serial

### Vấn Đề 2: LED Không Hoạt Động

**Triệu Chứng:**
- LED tắt hoàn toàn
- LED sáng liên tục không thay đổi

**Giải Pháp:**

1. **Kiểm Tra Dây Nối**
   - Kiểm tra dây LED nối GPIO 8
   - Kiểm tra điện áp
   - Kiểm tra GND

2. **Kiểm Tra LED**
   - LED có bị hỏng không?
   - Thay LED mới nếu cần

3. **Kiểm Tra Code**
   - Xác minh GPIO 8 đúng trong code
   - Tải lại code

### Vấn Đề 3: Nút Nhấn Khi Không Chạm

**Triệu Chứng:**
- Nút kích hoạt mà không ai nhấn
- Hoạt động không ổn định

**Giải Pháp:**

1. **Thêm Tụ Lọc**
   - Nối tụ 0.1µF giữa GPIO và GND
   - Giúp lọc nhiễu

2. **Kiểm Tra Debounce**
   - Xem phần debounce trong code
   - Tăng độ trễ debounce nếu cần

3. **Kiểm Tra Dây Nối**
   - Kiểm tra dây có quá dài không
   - Rút ngắn dây hoặc thêm lá chắn

---

## Công Thức Tính Toán

### Tính Tốc Độ Nhấp Nháy LED

```
Tần Số = 1000ms / Chu Kỳ
Thời Gian Sáng = Chu Kỳ / 2

Ví Dụ:
- Nhấp Nháy Nhanh: 200ms → 5 lần/giây
- Nhấp Nháy Chậm: 1000ms → 1 lần/giây
```

### Tính Thời Gian Debounce

```
Debounce Time = Thời Gian Chờ (ms)

Khuyến Nghị:
- Nút bình thường: 20-50ms
- Nút cơ học: 50-100ms
- Nút nhạy: 5-20ms
```

---

## Bảng Tham Khảo Nhanh

| Bộ Phận | GPIO | Chức Năng | Trạng Thái |
|--------|------|----------|-----------|
| Nút 1 | GPIO 5 | Điều khiển Thiết Bị 1 | INPUT |
| Nút 2 | GPIO 6 | Điều khiển Thiết Bị 2 | INPUT |
| Nút 3 | GPIO 7 | Điều khiển Thiết Bị 3 | INPUT |
| LED | GPIO 8 | Báo Trạng Thái | OUTPUT |
| Relay 1 | Relay Pin 1 | Thiết Bị 1 | OUTPUT |
| Relay 2 | Relay Pin 2 | Thiết Bị 2 | OUTPUT |
| Relay 3 | Relay Pin 3 | Thiết Bị 3 | OUTPUT |
| Relay 4 | Relay Pin 4 | Thiết Bị 4 | OUTPUT |

---

## Liên Hệ Hỗ Trợ

Gặp vấn đề với các nút? 

- Kiểm tra phần "Khắc Phục Sự Cố" trên
- Đọc Serial Monitor để debug
- Xem code trong `arduino/DeviceController.ino`
- Liên hệ nhóm phát triển

**Thông Tin Cần Cung Cấp:**
- Nút nào không hoạt động
- LED có hoạt động không
- Thông báo Serial Monitor
- Các bước để tái hiện lỗi

---

**Version:** 1.0.0
**Ngôn Ngữ:** Tiếng Việt
**Cập Nhật Cuối:** 2024
