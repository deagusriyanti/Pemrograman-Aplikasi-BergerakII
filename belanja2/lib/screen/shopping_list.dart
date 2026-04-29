import 'package:belanja2/service/shopping_sservice.dart';
import 'package:flutter/material.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final ShoppingService _shoppingService = ShoppingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Belanja',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),),

        centerTitle: true,
      ),
      body: StreamBuilder<Map<String, Map<String, dynamic>>>(
        stream: _shoppingService.getShoppingList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final key = items.keys.elementAt(index);
                final item = items[key]!;

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(
                      item["name"] ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Harga: ${item["harga"] ?? "-"}"),
                        Text("Jumlah: ${item["jumlah"] ?? "-"}"),
                        Text("Kategori: ${item["kategori"] ?? "-"}"),
                        Text(
                          "Status: ${item["status"] ?? "-"}",
                          style: TextStyle(
                            color: item["status"] == "sudah dibeli"
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}