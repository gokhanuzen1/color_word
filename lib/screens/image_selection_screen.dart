import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
// ÖNEMLİ: Boyama ekranının dosya adını buraya doğru yazdığından emin ol
import 'paint_screen.dart'; 

class ImageSelectionScreen extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;
  final Color themeColor;

  const ImageSelectionScreen({
    super.key, 
    required this.categoryId, 
    required this.categoryTitle, 
    required this.themeColor
  });

  Future<List<String>> _loadImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    
    // Senin liste.txt'deki dosya isimlerine göre filtreleme
    // Dosya isimlerin 'ciftlik_1.png' şeklinde olduğu için 
    // sadece ilgili kategoriye ait olanları alıyoruz.
    return manifestMap.keys.where((path) => 
      path.contains('assets/') && // Resimlerin olduğu ana klasör
      path.split('/').last.startsWith(categoryId) // Dosya ismi kategoriyle başlıyorsa
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle), 
        backgroundColor: themeColor,
        elevation: 0,
      ),
      body: FutureBuilder<List<String>>(
        future: _loadImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Hata: Resim bulunamadı. Kategori: $categoryId"));
          }
          
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                // Tıklandığında PaintScreen'e resim yolunu göndererek açar
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => PaintScreen(imagePath: snapshot.data![index])
                  )
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(snapshot.data![index], fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}