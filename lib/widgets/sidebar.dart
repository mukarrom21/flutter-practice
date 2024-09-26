import 'package:flutter/material.dart';
import 'package:practice_with_ostad/screens/data_table_2.dart';
import 'package:practice_with_ostad/screens/sticky_header_column_data_table.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Text("Drawer Header"),
          ),
          ListTile(
            title: const Text("Sticky Header and Column in DataTable"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StickyHeaderColumnDataTable(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Data Table 2"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DataTable2Demo(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}