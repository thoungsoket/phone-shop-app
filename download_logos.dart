// download_logos.dart - Run this once to download SVG logos
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  final brands = ['apple', 'samsung', 'xiaomi', 'oppo', 'oneplus', 'vivo'];
  final dir = Directory('assets/images/brands');
  if (!await dir.exists()) await dir.create(recursive: true);
  
  for (final brand in brands) {
    final url = 'https://cdn.jsdelivr.net/gh/simple-icons/simple-icons/icons/$brand.svg';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final file = File('${dir.path}/$brand.svg');
        await file.writeAsBytes(response.bodyBytes);
        print('✅ Downloaded: $brand.svg');
      }
    } catch (e) {
      print('❌ Failed: $brand.svg - $e');
    }
  }
  print('🎉 All logos downloaded to assets/images/brands/');
}