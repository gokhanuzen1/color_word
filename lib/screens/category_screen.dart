import 'package:flutter/material.dart';
import 'package:color_world/screens/image_selection_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // id: liste.txt'deki ön eklerle birebir aynı
  final List<Map<String, dynamic>> _categories = [
    {'id': 'ciftlik', 'title': 'Çiftlik', 'color': Colors.brown},
    {'id': 'dinozor', 'title': 'Dinozorlar', 'color': Colors.green},
    {'id': 'doga', 'title': 'Doğa', 'color': Colors.lightGreen},
    {'id': 'emoji', 'title': 'Emojiler', 'color': Colors.amber},
    {'id': 'erkek_karakter', 'title': 'Erkek Karakterler', 'color': Colors.blue},
    {'id': 'harfler', 'title': 'Harfler', 'color': Colors.deepPurple},
    {'id': 'insaat', 'title': 'İş Arabaları', 'color': Colors.orange},
    {'id': 'kahraman', 'title': 'Kahramanlar', 'color': Colors.red},
    {'id': 'kiz_karakter', 'title': 'Kız Karakterler', 'color': Colors.pink},
    {'id': 'meslekler', 'title': 'Meslekler', 'color': Colors.teal},
    {'id': 'okyanus', 'title': 'Deniz Altı', 'color': Colors.blueAccent},
    {'id': 'oyuncak', 'title': 'Oyuncak Dünyası', 'color': Colors.yellow},
    {'id': 'robot', 'title': 'Robotlar', 'color': Colors.blueGrey},
    {'id': 'sayilar', 'title': 'Sayılar', 'color': Colors.orangeAccent},
    {'id': 'tasitlar', 'title': 'Taşıtlar', 'color': Colors.purple},
    {'id': 'uzay', 'title': 'Uzay Maceraları', 'color': Colors.indigo},
    {'id': 'vahsi_dostlar', 'title': 'Vahşi Dostlar', 'color': Colors.greenAccent},
    {'id': 'yiyecekler', 'title': 'Yiyecekler', 'color': Colors.lime},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(title: const Text("BOYAMA DÜNYASI"), centerTitle: true),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemCount: _categories.length,
        itemBuilder: (context, i) => GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => 
            ImageSelectionScreen(categoryId: _categories[i]['id'], categoryTitle: _categories[i]['title'], themeColor: _categories[i]['color']))),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
            child: Column(children: [
              // Kapak resmi: Kategorinin 1. resmini gösterir
              Expanded(child: ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), 
                child: Image.asset('assets/templates/${_categories[i]['id']}_1.png', fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.image)))),
              Padding(padding: const EdgeInsets.all(12), child: Text(_categories[i]['title'], style: const TextStyle(fontWeight: FontWeight.bold))),
            ]),
          ),
        ),
      ),
    );
  }
}