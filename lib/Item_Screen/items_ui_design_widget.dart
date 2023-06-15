import 'package:flutter/material.dart';
import 'package:green_sellers/Item_Screen/item_screen.dart';
import 'package:green_sellers/Item_Screen/items_details_screen.dart';
import 'package:green_sellers/models/items.dart';

class ItemsUiDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ItemsUiDesignWidget({
    super.key,
    this.model,
    this.context,
  });

  @override
  State<ItemsUiDesignWidget> createState() => _ItemsUiDesignWidgetState();
}

class _ItemsUiDesignWidgetState extends State<ItemsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ItemsDetailsScreen(
                      model: widget.model,
                    )));
      },
      child: Card(
        margin: const EdgeInsets.only(top: 20.0, left: 12, right: 12),
        color: Color(0xFFFFA000),
        elevation: 10,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 240,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  widget.model!.itemTitle.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: SizedBox(
                    child: Image.network(
                      widget.model!.thumbnailUrl.toString(),
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  widget.model!.itemInfo.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
