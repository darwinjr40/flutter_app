import 'package:flutter/material.dart';

class DropdownButtonFormFiel extends StatelessWidget {
  const DropdownButtonFormFiel({super.key});

  @override
  Widget build(BuildContext context) {
    final  categories = List<Category>.empty();
    categories.add(Category(catId: 2));
    categories.add(Category(catId: 3));
    return Container(
      height: 150,
      width: 200,
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: DropdownButtonFormField(
          items: categories.map((Category item) {
            return DropdownMenuItem(
                value: Null,
                child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: Text(
                      item.catId.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    )));
          }).toList(),
          onChanged: (value) {
            
          },
          borderRadius: BorderRadius.circular(10.0),
          isExpanded: true,
          // itemHeight: 1,
          isDense: false,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blue,),
          decoration: const InputDecoration(
            labelText: 'category',
            // border: UnderlineInputBorder()
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}


class Category {
    int catId;
    String? catNom;
    List<int>? catalogues;

    Category({
        required this.catId,
        this.catNom,
        this.catalogues,
    });
}
