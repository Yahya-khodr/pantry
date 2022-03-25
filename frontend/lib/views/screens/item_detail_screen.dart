import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/views/widgets/card_detail_widget.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Item Name'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
              child: Center(
                child: Container(
                  width: size.width / 2,
                  height: size.height / 4.5 - 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: const Image(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            CardDetail(title: 'Item type')
          ],
        ),
      ),
    );
  }
}
