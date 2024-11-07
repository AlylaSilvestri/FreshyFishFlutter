import 'package:flutter/material.dart';

class FishDetailPage extends StatefulWidget {
  final String fishName;
  final String fishPrice;
  final String imageUrl;

  const FishDetailPage({
    required this.fishName,
    required this.fishPrice,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  _FishDetailPageState createState() => _FishDetailPageState();
}

class _FishDetailPageState extends State<FishDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fishName),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [ 
            Image.network(widget.imageUrl),
            const SizedBox(height: 20),
            Text(
              widget.fishName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.fishPrice,
              style: TextStyle(fontSize: 20, color: Colors.cyan),
            ),
          ],
        ),
      ),
    );
  }
}
