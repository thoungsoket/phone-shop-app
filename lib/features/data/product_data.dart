class ProductData {
  static final List<Map<String, dynamic>> allProducts = [
    // ========== APPLE PRODUCTS (30 total) ==========
    {'id': 1, 'name': 'iPhone 17 Pro Max', 'price': 1399, 'brand': 'Apple', 'rating': 4.9, 'category': 'Smartphones', 'image': 'assets/images/ip17promax.png', 'isNew': true, 'isUsed': false},
    {'id': 2, 'name': 'iPhone 17 Pro', 'price': 1199, 'brand': 'Apple', 'rating': 4.8, 'category': 'Smartphones', 'image': 'assets/images/ip17pro.png', 'isNew': true, 'isUsed': false},
    {'id': 3, 'name': 'iPhone 17', 'price': 999, 'brand': 'Apple', 'rating': 4.7, 'category': 'Smartphones', 'image': 'assets/images/ip17.png', 'isNew': true, 'isUsed': false},
    {'id': 4, 'name': 'iPhone 16 Pro Max', 'price': 1099, 'brand': 'Apple', 'rating': 4.8, 'category': 'Smartphones', 'image': 'assets/images/ip16promax.png', 'isNew': false, 'isUsed': false},
    {'id': 5, 'name': 'iPhone 16 Pro', 'price': 999, 'brand': 'Apple', 'rating': 4.7, 'category': 'Smartphones', 'image': 'assets/images/ip16pro.png', 'isNew': false, 'isUsed': false},
    {'id': 6, 'name': 'iPhone 16 Plus', 'price': 899, 'brand': 'Apple', 'rating': 4.6, 'category': 'Smartphones', 'image': 'assets/images/ip16plus.png', 'isNew': false, 'isUsed': true},
    {'id': 7, 'name': 'iPhone 16', 'price': 799, 'brand': 'Apple', 'rating': 4.6, 'category': 'Smartphones', 'image': 'assets/images/ip16.png', 'isNew': false, 'isUsed': true},
    {'id': 8, 'name': 'iPhone XR', 'price': 599, 'brand': 'Apple', 'rating': 4.4, 'category': 'Smartphones', 'image': 'assets/images/ipxr.png', 'isNew': false, 'isUsed': true},
    {'id': 9, 'name': 'iPhone XS Max', 'price': 699, 'brand': 'Apple', 'rating': 4.5, 'category': 'Smartphones', 'image': 'assets/images/ipxsmax.png', 'isNew': false, 'isUsed': true},
    {'id': 10, 'name': 'iPhone 15 Pro Max', 'price': 899, 'brand': 'Apple', 'rating': 4.5, 'category': 'Smartphones', 'image': 'assets/images/ip15promax.png', 'isNew': false, 'isUsed': true},
    {'id': 11, 'name': 'iPhone 15 Pro', 'price': 799, 'brand': 'Apple', 'rating': 4.4, 'category': 'Smartphones', 'image': 'assets/images/ip15pro.png', 'isNew': false, 'isUsed': true},
    {'id': 12, 'name': 'iPhone 15', 'price': 699, 'brand': 'Apple', 'rating': 4.3, 'category': 'Smartphones', 'image': 'assets/images/ip15.png', 'isNew': false, 'isUsed': true},
    {'id': 13, 'name': 'iPad Pro M4 13"', 'price': 1299, 'brand': 'Apple', 'rating': 4.9, 'category': 'Tablets', 'image': 'assets/images/ipad_pro_m4_13.png', 'isNew': true, 'isUsed': false},
    {'id': 14, 'name': 'iPad Pro M4 11"', 'price': 1099, 'brand': 'Apple', 'rating': 4.8, 'category': 'Tablets', 'image': 'assets/images/ipad_pro_m4_11.png', 'isNew': true, 'isUsed': false},
    {'id': 15, 'name': 'iPad Air M3', 'price': 799, 'brand': 'Apple', 'rating': 4.7, 'category': 'Tablets', 'image': 'assets/images/ipad_air_m3.png', 'isNew': true, 'isUsed': false},
    {'id': 16, 'name': 'iPad 10th Gen', 'price': 449, 'brand': 'Apple', 'rating': 4.5, 'category': 'Tablets', 'image': 'assets/images/ipad_10th.png', 'isNew': false, 'isUsed': true},
    {'id': 17, 'name': 'iPad Mini 7', 'price': 499, 'brand': 'Apple', 'rating': 4.6, 'category': 'Tablets', 'image': 'assets/images/ipad_mini7.png', 'isNew': true, 'isUsed': false},
    {'id': 18, 'name': 'iPad 9th Gen', 'price': 329, 'brand': 'Apple', 'rating': 4.4, 'category': 'Tablets', 'image': 'assets/images/ipad_9th.png', 'isNew': false, 'isUsed': true},
    {'id': 19, 'name': 'Apple Watch Ultra 3', 'price': 799, 'brand': 'Apple', 'rating': 4.9, 'category': 'Wearables', 'image': 'assets/images/watch_ultra3.png', 'isNew': true, 'isUsed': false},
    {'id': 20, 'name': 'Apple Watch Series 10', 'price': 499, 'brand': 'Apple', 'rating': 4.8, 'category': 'Wearables', 'image': 'assets/images/watch_series10.png', 'isNew': true, 'isUsed': false},
    {'id': 21, 'name': 'Apple Watch SE 3', 'price': 299, 'brand': 'Apple', 'rating': 4.6, 'category': 'Wearables', 'image': 'assets/images/watch_se3.png', 'isNew': true, 'isUsed': false},
    {'id': 22, 'name': 'Apple Watch Series 9', 'price': 399, 'brand': 'Apple', 'rating': 4.7, 'category': 'Wearables', 'image': 'assets/images/watch_series9.png', 'isNew': false, 'isUsed': true},
    {'id': 23, 'name': 'Apple Watch Ultra 2', 'price': 699, 'brand': 'Apple', 'rating': 4.8, 'category': 'Wearables', 'image': 'assets/images/watch_ultra2.png', 'isNew': false, 'isUsed': true},
    {'id': 24, 'name': 'AirPods Pro 3', 'price': 249, 'brand': 'Apple', 'rating': 4.7, 'category': 'Accessories', 'image': 'assets/images/airpods_pro3.png', 'isNew': true, 'isUsed': false},
    {'id': 25, 'name': 'AirPods Max 2', 'price': 549, 'brand': 'Apple', 'rating': 4.8, 'category': 'Accessories', 'image': 'assets/images/airpods_max2.png', 'isNew': true, 'isUsed': false},
    {'id': 26, 'name': 'AirPods 4', 'price': 179, 'brand': 'Apple', 'rating': 4.5, 'category': 'Accessories', 'image': 'assets/images/airpods4.png', 'isNew': true, 'isUsed': false},
    {'id': 27, 'name': 'AirPods Pro 2', 'price': 199, 'brand': 'Apple', 'rating': 4.6, 'category': 'Accessories', 'image': 'assets/images/airpods_pro2.png', 'isNew': false, 'isUsed': true},
    {'id': 28, 'name': 'MagSafe Battery Pack', 'price': 99, 'brand': 'Apple', 'rating': 4.3, 'category': 'Accessories', 'image': 'assets/images/magsafe_battery.png', 'isNew': false, 'isUsed': true},
    {'id': 29, 'name': 'Apple Pencil Pro', 'price': 129, 'brand': 'Apple', 'rating': 4.7, 'category': 'Accessories', 'image': 'assets/images/pencil_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 30, 'name': 'Magic Keyboard', 'price': 299, 'brand': 'Apple', 'rating': 4.5, 'category': 'Accessories', 'image': 'assets/images/magic_keyboard.png', 'isNew': false, 'isUsed': true},

    // ========== SAMSUNG PRODUCTS (29 total) ==========
    {'id': 31, 'name': 'Galaxy S26 Ultra', 'price': 1399, 'brand': 'Samsung', 'rating': 4.9, 'category': 'Smartphones', 'image': 'assets/images/s26_ultra.png', 'isNew': true, 'isUsed': false},
    {'id': 32, 'name': 'Galaxy S26 Plus', 'price': 1199, 'brand': 'Samsung', 'rating': 4.8, 'category': 'Smartphones', 'image': 'assets/images/s26_plus.png', 'isNew': true, 'isUsed': false},
    {'id': 33, 'name': 'Galaxy S26', 'price': 999, 'brand': 'Samsung', 'rating': 4.7, 'category': 'Smartphones', 'image': 'assets/images/s26.png', 'isNew': true, 'isUsed': false},
    {'id': 34, 'name': 'Galaxy Z Fold 7', 'price': 1999, 'brand': 'Samsung', 'rating': 4.9, 'category': 'Smartphones', 'image': 'assets/images/z_fold7.png', 'isNew': true, 'isUsed': false},
    {'id': 35, 'name': 'Galaxy Z Flip 7', 'price': 1199, 'brand': 'Samsung', 'rating': 4.7, 'category': 'Smartphones', 'image': 'assets/images/z_flip7.png', 'isNew': true, 'isUsed': false},
    {'id': 36, 'name': 'Galaxy Z Fold 6', 'price': 1899, 'brand': 'Samsung', 'rating': 4.8, 'category': 'Smartphones', 'image': 'assets/images/z_fold6.png', 'isNew': false, 'isUsed': true},
    {'id': 37, 'name': 'Galaxy Z Flip 6', 'price': 1099, 'brand': 'Samsung', 'rating': 4.6, 'category': 'Smartphones', 'image': 'assets/images/z_flip6.png', 'isNew': false, 'isUsed': true},
    {'id': 38, 'name': 'Galaxy A55 5G', 'price': 449, 'brand': 'Samsung', 'rating': 4.4, 'category': 'Smartphones', 'image': 'assets/images/a55_5g.png', 'isNew': false, 'isUsed': true},
    {'id': 39, 'name': 'Galaxy A35 5G', 'price': 399, 'brand': 'Samsung', 'rating': 4.3, 'category': 'Smartphones', 'image': 'assets/images/a35_5g.png', 'isNew': false, 'isUsed': true},
    {'id': 40, 'name': 'Galaxy S25 Ultra', 'price': 1199, 'brand': 'Samsung', 'rating': 4.7, 'category': 'Smartphones', 'image': 'assets/images/s25_ultra.png', 'isNew': false, 'isUsed': true},
    {'id': 41, 'name': 'Galaxy S25 Plus', 'price': 999, 'brand': 'Samsung', 'rating': 4.6, 'category': 'Smartphones', 'image': 'assets/images/s25_plus.png', 'isNew': false, 'isUsed': true},
    {'id': 42, 'name': 'Galaxy Tab S10 Ultra', 'price': 1199, 'brand': 'Samsung', 'rating': 4.8, 'category': 'Tablets', 'image': 'assets/images/tab_s10_ultra.png', 'isNew': true, 'isUsed': false},
    {'id': 43, 'name': 'Galaxy Tab S10 Plus', 'price': 999, 'brand': 'Samsung', 'rating': 4.7, 'category': 'Tablets', 'image': 'assets/images/tab_s10_plus.png', 'isNew': true, 'isUsed': false},
    {'id': 44, 'name': 'Galaxy Tab S10', 'price': 799, 'brand': 'Samsung', 'rating': 4.6, 'category': 'Tablets', 'image': 'assets/images/tab_s10.png', 'isNew': true, 'isUsed': false},
    {'id': 45, 'name': 'Galaxy Tab S9 FE', 'price': 549, 'brand': 'Samsung', 'rating': 4.5, 'category': 'Tablets', 'image': 'assets/images/tab_s9_fe.png', 'isNew': false, 'isUsed': true},
    {'id': 46, 'name': 'Galaxy Tab A9+', 'price': 299, 'brand': 'Samsung', 'rating': 4.3, 'category': 'Tablets', 'image': 'assets/images/tab_a9_plus.png', 'isNew': false, 'isUsed': true},
    {'id': 47, 'name': 'Galaxy Tab A9', 'price': 249, 'brand': 'Samsung', 'rating': 4.2, 'category': 'Tablets', 'image': 'assets/images/tab_a9.png', 'isNew': false, 'isUsed': true},
    {'id': 48, 'name': 'Galaxy Watch 7 Ultra', 'price': 649, 'brand': 'Samsung', 'rating': 4.8, 'category': 'Wearables', 'image': 'assets/images/watch7_ultra.png', 'isNew': true, 'isUsed': false},
    {'id': 49, 'name': 'Galaxy Watch 7', 'price': 399, 'brand': 'Samsung', 'rating': 4.6, 'category': 'Wearables', 'image': 'assets/images/watch7.png', 'isNew': true, 'isUsed': false},
    {'id': 50, 'name': 'Galaxy Watch 7 Classic', 'price': 499, 'brand': 'Samsung', 'rating': 4.7, 'category': 'Wearables', 'image': 'assets/images/watch7_classic.png', 'isNew': true, 'isUsed': false},
    {'id': 51, 'name': 'Galaxy Watch FE', 'price': 249, 'brand': 'Samsung', 'rating': 4.4, 'category': 'Wearables', 'image': 'assets/images/watch_fe.png', 'isNew': true, 'isUsed': false},
    {'id': 52, 'name': 'Galaxy Watch 6', 'price': 329, 'brand': 'Samsung', 'rating': 4.5, 'category': 'Wearables', 'image': 'assets/images/watch6.png', 'isNew': false, 'isUsed': true},
    {'id': 53, 'name': 'Galaxy Watch 6 Classic', 'price': 429, 'brand': 'Samsung', 'rating': 4.5, 'category': 'Wearables', 'image': 'assets/images/watch6_classic.png', 'isNew': false, 'isUsed': true},
    {'id': 54, 'name': 'Galaxy Buds 3 Pro', 'price': 249, 'brand': 'Samsung', 'rating': 4.6, 'category': 'Accessories', 'image': 'assets/images/buds3_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 55, 'name': 'Galaxy Buds 3', 'price': 179, 'brand': 'Samsung', 'rating': 4.4, 'category': 'Accessories', 'image': 'assets/images/buds3.png', 'isNew': true, 'isUsed': false},
    {'id': 56, 'name': 'Galaxy Buds 2 Pro', 'price': 199, 'brand': 'Samsung', 'rating': 4.5, 'category': 'Accessories', 'image': 'assets/images/buds2_pro.png', 'isNew': false, 'isUsed': true},
    {'id': 57, 'name': 'Galaxy S-Pen Pro', 'price': 99, 'brand': 'Samsung', 'rating': 4.5, 'category': 'Accessories', 'image': 'assets/images/spen_pro.png', 'isNew': false, 'isUsed': true},
    {'id': 58, 'name': 'Galaxy Wireless Charger', 'price': 79, 'brand': 'Samsung', 'rating': 4.3, 'category': 'Accessories', 'image': 'assets/images/wireless_charger.png', 'isNew': false, 'isUsed': true},
    {'id': 59, 'name': 'Galaxy Smart Case', 'price': 49, 'brand': 'Samsung', 'rating': 4.2, 'category': 'Accessories', 'image': 'assets/images/smart_case.png', 'isNew': false, 'isUsed': true},

    // ========== XIAOMI PRODUCTS (25 total) ==========
    {'id': 60, 'name': 'Xiaomi 15 Pro', 'price': 999, 'brand': 'Xiaomi', 'rating': 4.6, 'category': 'Smartphones', 'image': 'assets/images/xiaomi15_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 61, 'name': 'Xiaomi 15', 'price': 849, 'brand': 'Xiaomi', 'rating': 4.5, 'category': 'Smartphones', 'image': 'assets/images/xiaomi15.png', 'isNew': true, 'isUsed': false},
    {'id': 62, 'name': 'Xiaomi 14 Pro', 'price': 899, 'brand': 'Xiaomi', 'rating': 4.5, 'category': 'Smartphones', 'image': 'assets/images/xiaomi14_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 63, 'name': 'Xiaomi 14', 'price': 749, 'brand': 'Xiaomi', 'rating': 4.4, 'category': 'Smartphones', 'image': 'assets/images/xiaomi14.png', 'isNew': true, 'isUsed': false},
    {'id': 64, 'name': 'Xiaomi 14T Pro', 'price': 699, 'brand': 'Xiaomi', 'rating': 4.4, 'category': 'Smartphones', 'image': 'assets/images/xiaomi14t_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 65, 'name': 'Xiaomi 13T Pro', 'price': 649, 'brand': 'Xiaomi', 'rating': 4.3, 'category': 'Smartphones', 'image': 'assets/images/xiaomi13t_pro.png', 'isNew': false, 'isUsed': true},
    {'id': 66, 'name': 'Xiaomi 13', 'price': 599, 'brand': 'Xiaomi', 'rating': 4.3, 'category': 'Smartphones', 'image': 'assets/images/xiaomi13.png', 'isNew': false, 'isUsed': true},
    {'id': 67, 'name': 'Xiaomi 12 Pro', 'price': 549, 'brand': 'Xiaomi', 'rating': 4.2, 'category': 'Smartphones', 'image': 'assets/images/xiaomi12_pro.png', 'isNew': false, 'isUsed': true},
    {'id': 68, 'name': 'Xiaomi 12', 'price': 449, 'brand': 'Xiaomi', 'rating': 4.1, 'category': 'Smartphones', 'image': 'assets/images/xiaomi12.png', 'isNew': false, 'isUsed': true},
    {'id': 69, 'name': 'Xiaomi Poco F6', 'price': 499, 'brand': 'Xiaomi', 'rating': 4.3, 'category': 'Smartphones', 'image': 'assets/images/poco_f6.png', 'isNew': true, 'isUsed': false},
    {'id': 70, 'name': 'Xiaomi Pad 7 Pro', 'price': 599, 'brand': 'Xiaomi', 'rating': 4.5, 'category': 'Tablets', 'image': 'assets/images/pad7_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 71, 'name': 'Xiaomi Pad 7', 'price': 449, 'brand': 'Xiaomi', 'rating': 4.4, 'category': 'Tablets', 'image': 'assets/images/pad7.png', 'isNew': true, 'isUsed': false},
    {'id': 72, 'name': 'Xiaomi Pad 6', 'price': 399, 'brand': 'Xiaomi', 'rating': 4.3, 'category': 'Tablets', 'image': 'assets/images/pad6.png', 'isNew': false, 'isUsed': true},
    {'id': 73, 'name': 'Xiaomi Pad 6S Pro', 'price': 549, 'brand': 'Xiaomi', 'rating': 4.4, 'category': 'Tablets', 'image': 'assets/images/pad6s_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 74, 'name': 'Xiaomi Watch 3 Pro', 'price': 349, 'brand': 'Xiaomi', 'rating': 4.3, 'category': 'Wearables', 'image': 'assets/images/watch3_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 75, 'name': 'Xiaomi Watch 2 Pro', 'price': 299, 'brand': 'Xiaomi', 'rating': 4.2, 'category': 'Wearables', 'image': 'assets/images/watch2_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 76, 'name': 'Xiaomi Band 9', 'price': 59, 'brand': 'Xiaomi', 'rating': 4.4, 'category': 'Wearables', 'image': 'assets/images/band9.png', 'isNew': true, 'isUsed': false},
    {'id': 77, 'name': 'Xiaomi Band 8 Pro', 'price': 99, 'brand': 'Xiaomi', 'rating': 4.3, 'category': 'Wearables', 'image': 'assets/images/band8_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 78, 'name': 'Xiaomi Band 8', 'price': 39, 'brand': 'Xiaomi', 'rating': 4.2, 'category': 'Wearables', 'image': 'assets/images/band8.png', 'isNew': false, 'isUsed': true},
    {'id': 79, 'name': 'Xiaomi Buds 4 Pro', 'price': 149, 'brand': 'Xiaomi', 'rating': 4.3, 'category': 'Accessories', 'image': 'assets/images/buds4_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 80, 'name': 'Xiaomi Buds 4', 'price': 99, 'brand': 'Xiaomi', 'rating': 4.2, 'category': 'Accessories', 'image': 'assets/images/buds4.png', 'isNew': true, 'isUsed': false},
    {'id': 81, 'name': 'Xiaomi Buds 3 Pro', 'price': 79, 'brand': 'Xiaomi', 'rating': 4.2, 'category': 'Accessories', 'image': 'assets/images/buds3_pro.png', 'isNew': false, 'isUsed': true},
    {'id': 82, 'name': 'Xiaomi Power Bank 3', 'price': 49, 'brand': 'Xiaomi', 'rating': 4.3, 'category': 'Accessories', 'image': 'assets/images/power_bank3.png', 'isNew': false, 'isUsed': true},
    {'id': 83, 'name': 'Xiaomi 67W Charger', 'price': 29, 'brand': 'Xiaomi', 'rating': 4.4, 'category': 'Accessories', 'image': 'assets/images/67w_charger.png', 'isNew': true, 'isUsed': false},
    {'id': 84, 'name': 'Xiaomi Smart Band Strap', 'price': 19, 'brand': 'Xiaomi', 'rating': 4.1, 'category': 'Accessories', 'image': 'assets/images/band_strap.png', 'isNew': false, 'isUsed': true},

    // ========== OPPO PRODUCTS (20 total - REMOVED Pad 4 and Watch 4) ==========
    {'id': 85, 'name': 'Oppo Find X8 Ultra', 'price': 1099, 'brand': 'Oppo', 'rating': 4.6, 'category': 'Smartphones', 'image': 'assets/images/find_x8_ultra.png', 'isNew': true, 'isUsed': false},
    {'id': 86, 'name': 'Oppo Find X8 Pro', 'price': 999, 'brand': 'Oppo', 'rating': 4.5, 'category': 'Smartphones', 'image': 'assets/images/find_x8_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 87, 'name': 'Oppo Find X8', 'price': 849, 'brand': 'Oppo', 'rating': 4.4, 'category': 'Smartphones', 'image': 'assets/images/find_x8.png', 'isNew': true, 'isUsed': false},
    {'id': 88, 'name': 'Oppo Find X7 Ultra', 'price': 999, 'brand': 'Oppo', 'rating': 4.5, 'category': 'Smartphones', 'image': 'assets/images/find_x7_ultra.png', 'isNew': true, 'isUsed': false},
    {'id': 89, 'name': 'Oppo Find X7', 'price': 799, 'brand': 'Oppo', 'rating': 4.4, 'category': 'Smartphones', 'image': 'assets/images/find_x7.png', 'isNew': true, 'isUsed': false},
    {'id': 90, 'name': 'Oppo Reno 13 Pro', 'price': 699, 'brand': 'Oppo', 'rating': 4.3, 'category': 'Smartphones', 'image': 'assets/images/reno13_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 91, 'name': 'Oppo Reno 13', 'price': 549, 'brand': 'Oppo', 'rating': 4.2, 'category': 'Smartphones', 'image': 'assets/images/reno13.png', 'isNew': true, 'isUsed': false},
    {'id': 92, 'name': 'Oppo Reno 12 Pro', 'price': 599, 'brand': 'Oppo', 'rating': 4.3, 'category': 'Smartphones', 'image': 'assets/images/reno12_pro.png', 'isNew': false, 'isUsed': true},
    {'id': 93, 'name': 'Oppo Reno 12', 'price': 449, 'brand': 'Oppo', 'rating': 4.2, 'category': 'Smartphones', 'image': 'assets/images/reno12.png', 'isNew': false, 'isUsed': true},
    {'id': 94, 'name': 'Oppo A79 5G', 'price': 299, 'brand': 'Oppo', 'rating': 4.0, 'category': 'Smartphones', 'image': 'assets/images/a79_5g.png', 'isNew': false, 'isUsed': true},
    {'id': 95, 'name': 'Oppo Pad 4 Pro', 'price': 649, 'brand': 'Oppo', 'rating': 4.4, 'category': 'Tablets', 'image': 'assets/images/pad4_pro.png', 'isNew': true, 'isUsed': false},
    // {'id': 96, 'name': 'Oppo Pad 4', ... }  // REMOVED
    {'id': 97, 'name': 'Oppo Pad 3 Pro', 'price': 549, 'brand': 'Oppo', 'rating': 4.3, 'category': 'Tablets', 'image': 'assets/images/pad3_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 98, 'name': 'Oppo Pad 3', 'price': 399, 'brand': 'Oppo', 'rating': 4.2, 'category': 'Tablets', 'image': 'assets/images/pad3.png', 'isNew': false, 'isUsed': true},
    {'id': 99, 'name': 'Oppo Watch 5 Pro', 'price': 449, 'brand': 'Oppo', 'rating': 4.3, 'category': 'Wearables', 'image': 'assets/images/watch5_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 100, 'name': 'Oppo Watch 4 Pro', 'price': 349, 'brand': 'Oppo', 'rating': 4.2, 'category': 'Wearables', 'image': 'assets/images/watch4_pro.png', 'isNew': true, 'isUsed': false},
    // {'id': 101, 'name': 'Oppo Watch 4', ... }  // REMOVED
    {'id': 102, 'name': 'Oppo Band 3', 'price': 49, 'brand': 'Oppo', 'rating': 4.0, 'category': 'Wearables', 'image': 'assets/images/band3.png', 'isNew': true, 'isUsed': false},
    {'id': 103, 'name': 'Oppo Enco X4', 'price': 199, 'brand': 'Oppo', 'rating': 4.3, 'category': 'Accessories', 'image': 'assets/images/enco_x4.png', 'isNew': true, 'isUsed': false},
    {'id': 104, 'name': 'Oppo Enco X3', 'price': 179, 'brand': 'Oppo', 'rating': 4.3, 'category': 'Accessories', 'image': 'assets/images/enco_x3.png', 'isNew': true, 'isUsed': false},
    {'id': 105, 'name': 'Oppo Enco Air 4', 'price': 79, 'brand': 'Oppo', 'rating': 4.1, 'category': 'Accessories', 'image': 'assets/images/enco_air4.png', 'isNew': true, 'isUsed': false},
    {'id': 106, 'name': 'Oppo Enco Air 3', 'price': 59, 'brand': 'Oppo', 'rating': 4.0, 'category': 'Accessories', 'image': 'assets/images/enco_air3.png', 'isNew': false, 'isUsed': true},
    {'id': 107, 'name': 'Oppo SuperVOOC Charger', 'price': 39, 'brand': 'Oppo', 'rating': 4.2, 'category': 'Accessories', 'image': 'assets/images/supervooc_charger.png', 'isNew': false, 'isUsed': true},

    // ========== ONEPLUS PRODUCTS (11 total) ==========
    {'id': 108, 'name': 'OnePlus 12', 'price': 899, 'brand': 'OnePlus', 'rating': 4.5, 'category': 'Smartphones', 'image': 'assets/images/oneplus12.png', 'isNew': true, 'isUsed': false},
    {'id': 109, 'name': 'OnePlus 12R', 'price': 699, 'brand': 'OnePlus', 'rating': 4.4, 'category': 'Smartphones', 'image': 'assets/images/oneplus12r.png', 'isNew': true, 'isUsed': false},
    {'id': 110, 'name': 'OnePlus 11', 'price': 799, 'brand': 'OnePlus', 'rating': 4.4, 'category': 'Smartphones', 'image': 'assets/images/oneplus11.png', 'isNew': false, 'isUsed': true},
    {'id': 111, 'name': 'OnePlus Nord 4', 'price': 499, 'brand': 'OnePlus', 'rating': 4.3, 'category': 'Smartphones', 'image': 'assets/images/nord4.png', 'isNew': true, 'isUsed': false},
    {'id': 112, 'name': 'OnePlus Nord 3', 'price': 399, 'brand': 'OnePlus', 'rating': 4.2, 'category': 'Smartphones', 'image': 'assets/images/nord3.png', 'isNew': false, 'isUsed': true},
    {'id': 113, 'name': 'OnePlus Open', 'price': 1699, 'brand': 'OnePlus', 'rating': 4.5, 'category': 'Smartphones', 'image': 'assets/images/oneplus_open.png', 'isNew': true, 'isUsed': false},
    {'id': 114, 'name': 'OnePlus Pad 2', 'price': 549, 'brand': 'OnePlus', 'rating': 4.3, 'category': 'Tablets', 'image': 'assets/images/oneplus_pad2.png', 'isNew': true, 'isUsed': false},
    {'id': 115, 'name': 'OnePlus Pad', 'price': 479, 'brand': 'OnePlus', 'rating': 4.2, 'category': 'Tablets', 'image': 'assets/images/oneplus_pad.png', 'isNew': false, 'isUsed': true},
    {'id': 116, 'name': 'OnePlus Buds Pro 3', 'price': 179, 'brand': 'OnePlus', 'rating': 4.3, 'category': 'Accessories', 'image': 'assets/images/oneplus_buds_pro3.png', 'isNew': true, 'isUsed': false},
    {'id': 117, 'name': 'OnePlus Buds 3', 'price': 99, 'brand': 'OnePlus', 'rating': 4.2, 'category': 'Accessories', 'image': 'assets/images/oneplus_buds3.png', 'isNew': true, 'isUsed': false},
    {'id': 118, 'name': 'OnePlus Warp Charger', 'price': 49, 'brand': 'OnePlus', 'rating': 4.2, 'category': 'Accessories', 'image': 'assets/images/warp_charger.png', 'isNew': false, 'isUsed': true},

    // ========== VIVO PRODUCTS (8 total) ==========
    {'id': 119, 'name': 'Vivo X100 Ultra', 'price': 1099, 'brand': 'Vivo', 'rating': 4.5, 'category': 'Smartphones', 'image': 'assets/images/vivo_x100_ultra.png', 'isNew': true, 'isUsed': false},
    {'id': 120, 'name': 'Vivo X100 Pro', 'price': 899, 'brand': 'Vivo', 'rating': 4.4, 'category': 'Smartphones', 'image': 'assets/images/vivo_x100_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 121, 'name': 'Vivo X100', 'price': 749, 'brand': 'Vivo', 'rating': 4.3, 'category': 'Smartphones', 'image': 'assets/images/vivo_x100.png', 'isNew': true, 'isUsed': false},
    {'id': 122, 'name': 'Vivo V40 Pro', 'price': 599, 'brand': 'Vivo', 'rating': 4.2, 'category': 'Smartphones', 'image': 'assets/images/vivo_v40_pro.png', 'isNew': true, 'isUsed': false},
    {'id': 123, 'name': 'Vivo V40', 'price': 499, 'brand': 'Vivo', 'rating': 4.1, 'category': 'Smartphones', 'image': 'assets/images/vivo_v40.png', 'isNew': false, 'isUsed': true},
    {'id': 124, 'name': 'Vivo TWS 4', 'price': 129, 'brand': 'Vivo', 'rating': 4.2, 'category': 'Accessories', 'image': 'assets/images/vivo_tws4.png', 'isNew': true, 'isUsed': false},
    {'id': 125, 'name': 'Vivo TWS 3', 'price': 99, 'brand': 'Vivo', 'rating': 4.1, 'category': 'Accessories', 'image': 'assets/images/vivo_tws3.png', 'isNew': false, 'isUsed': true},
    {'id': 126, 'name': 'Vivo 80W Charger', 'price': 39, 'brand': 'Vivo', 'rating': 4.2, 'category': 'Accessories', 'image': 'assets/images/vivo_80w_charger.png', 'isNew': true, 'isUsed': false},
  ];

  // Helper method to get products by category
  static List<Map<String, dynamic>> getByCategory(String category) {
    return allProducts.where((p) => p['category'] == category).toList();
  }

  // Helper method to get products by brand
  static List<Map<String, dynamic>> getByBrand(String brand) {
    return allProducts.where((p) => p['brand'] == brand).toList();
  }

  // Helper method to search products
  static List<Map<String, dynamic>> search(String query) {
    if (query.isEmpty) return [];
    final searchQuery = query.toLowerCase();
    return allProducts.where((product) {
      final name = product['name'].toString().toLowerCase();
      final brand = product['brand'].toString().toLowerCase();
      final category = product['category'].toString().toLowerCase();
      return name.contains(searchQuery) || 
             brand.contains(searchQuery) || 
             category.contains(searchQuery);
    }).toList();
  }
}