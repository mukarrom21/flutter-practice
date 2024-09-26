import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DataTable2Demo extends StatelessWidget {
  const DataTable2Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DataTable2 Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable2(
          columnSpacing: 5,
          horizontalMargin: 12,
          minWidth: 500,
          columns: const [
            DataColumn2(label: Text('Column A'), size: ColumnSize.L),
            DataColumn(label: Text('Column B')),
            DataColumn(label: Text('Column C')),
            DataColumn(label: Text('Column D')),
            DataColumn(label: Text('Numeric Column'), numeric: true),
          ],
          rows: List<DataRow>.generate(
            100,
                (index) => DataRow(cells: [
              DataCell(Text('A' * (10 - index % 10))),
              DataCell(Text('B' * (10 - (index + 5) % 10))),
              DataCell(Text('C' * (15 - (index + 5) % 10))),
              DataCell(Text('D' * (15 - (index + 10) % 10))),
              DataCell(Text(((index + 0.1) * 25.4).toString())),
            ]),
          ),
        ),
      ),
    );
  }
}