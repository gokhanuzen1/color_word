import 'package:flutter/material.dart';

// --- BU SINIFLAR EN DIŞARIDA OLMALI ---
class DrawingPoint {
  Offset offset;
  Paint paint;
  DrawingPoint(this.offset, this.paint);
}

class PainterWidget extends CustomPainter {
  final List<DrawingPoint?> points;
  PainterWidget(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!.offset, points[i + 1]!.offset, points[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// --- EKRAN WIDGETI ---
class PaintScreen extends StatefulWidget {
  final String imagePath;
  const PaintScreen({super.key, required this.imagePath});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  Color selectedColor = Colors.black;
  double strokeWidth = 5.0;
  List<DrawingPoint?> points = [];

  // RENK LİSTESİ (Hata veren üç noktayı kaldırdık, gerçek renkleri yazdık)
  final List<Color> colors = [
    Colors.black, Colors.grey, Colors.brown, Colors.red, Colors.pink, Colors.orange, 
    Colors.yellow, Colors.lime, Colors.green, Colors.teal, Colors.cyan, Colors.blue, 
    Colors.indigo, Colors.purple, Colors.deepPurple, Colors.blueGrey, Colors.redAccent, 
    Colors.white, Colors.black87, Colors.amber
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BOYAMA DÜNYASI")),
      body: Stack(children: [
        Positioned.fill(child: Image.asset(widget.imagePath, fit: BoxFit.contain)),
        GestureDetector(
          onPanUpdate: (d) => setState(() {
            points.add(DrawingPoint(d.localPosition, Paint()
              ..color = selectedColor
              ..strokeWidth = strokeWidth
              ..strokeCap = StrokeCap.round));
          }),
          onPanEnd: (d) => setState(() => points.add(null)),
          child: CustomPaint(painter: PainterWidget(points), size: Size.infinite),
        ),
      ]),
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () => setState(() => strokeWidth = 5)),
          IconButton(icon: const Icon(Icons.brush), onPressed: () => setState(() => strokeWidth = 15)),
          IconButton(icon: const Icon(Icons.delete), onPressed: () => setState(() => selectedColor = Colors.white)),
          IconButton(icon: const Icon(Icons.delete_forever, color: Colors.red), onPressed: () => setState(() => points.clear())),
        ]),
        SizedBox(height: 50, child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder: (context, i) => GestureDetector(
            onTap: () => setState(() => selectedColor = colors[i]),
            child: Container(margin: const EdgeInsets.all(4), width: 40, decoration: BoxDecoration(color: colors[i], shape: BoxShape.circle, border: Border.all(color: Colors.black26))),
          ),
        )),
      ]),
    );
  }
}