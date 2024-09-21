import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class StickyHeaderColumnDataTable extends StatefulWidget {
  const StickyHeaderColumnDataTable({super.key});

  @override
  State<StickyHeaderColumnDataTable> createState() =>
      _StickyHeaderColumnDataTableState();
}

class _StickyHeaderColumnDataTableState
    extends State<StickyHeaderColumnDataTable> {
  LinkedScrollControllerGroup linkedScrollControllerGroup =
      LinkedScrollControllerGroup();

  ScrollController? headerScrollController;
  ScrollController? dataScrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    headerScrollController = linkedScrollControllerGroup.addAndGet();
    dataScrollController = linkedScrollControllerGroup.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Sticky Header and Column in DataTable"),
      ),
      body: Stack(
        children: [
          /// data rows
          SingleChildScrollView(
            child: Row(children: [
              DataTable(
                columns:
                    TableColumnHelper.tableColumnsList.getRange(0, 1).map((e) {
                  return DataColumn(
                    label: SizedBox(
                      width: e.width,
                      child: Text(e.title ?? ""),
                    ),
                  );
                }).toList(),
                headingRowColor: WidgetStateProperty.all(Colors.green),
                dataRowColor: WidgetStateProperty.all(Colors.green.shade100),
                rows: List.generate(
                  100,
                  (index) {
                    return DataRow(cells: [
                      DataCell(Text('$index')),
                    ]);
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: dataScrollController,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: TableColumnHelper.tableColumnsList
                        .getRange(
                            1, TableColumnHelper.tableColumnsList.length - 1)
                        .map((e) {
                      return DataColumn(
                        label: SizedBox(
                          width: e.width,
                          child: Text(e.title ?? ""),
                        ),
                      );
                    }).toList(),
                    headingRowColor: const WidgetStatePropertyAll(Colors.teal),
                    dataRowColor: WidgetStatePropertyAll(Colors.teal.shade100),
                    showCheckboxColumn: true,
                    rows: List.generate(100, (index) {
                      return const DataRow(cells: [
                        DataCell(Text('Abdullah')),
                        DataCell(Text('Abu Abdullah')),
                        DataCell(Text('10th')),
                        DataCell(Text('1234567890')),
                      ]);
                    }),
                  ),
                ),
              ),
              DataTable(
                columns: TableColumnHelper.tableColumnsList
                    .getRange(
                  TableColumnHelper.tableColumnsList.length - 1,
                  TableColumnHelper.tableColumnsList.length,
                )
                    .map((e) {
                  return DataColumn(
                    label: SizedBox(
                      width: e.width,
                      child: Text(e.title ?? ""),
                    ),
                  );
                }).toList(),
                headingRowColor: WidgetStateProperty.all(Colors.greenAccent),
                dataRowColor:
                    WidgetStatePropertyAll(Colors.greenAccent.shade100),
                rows: List.generate(
                  100,
                  (index) {
                    return DataRow(cells: [
                      DataCell(Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      )),
                    ]);
                  },
                ),
              ),
            ]),
          ),

          /// data table sticky header
          _buildTableHeader(),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Row(children: [
      DataTable(
        columns: TableColumnHelper.tableColumnsList.getRange(0, 1).map((e) {
          return DataColumn(
              label: SizedBox(
            width: e.width,
            child: Text(e.title ?? ""),
          ));
        }).toList(),
        headingRowColor: WidgetStateProperty.all(Colors.green),
        rows: const [],
      ),
      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: headerScrollController,
          child: DataTable(
            columns: TableColumnHelper.tableColumnsList
                .getRange(1, TableColumnHelper.tableColumnsList.length - 1)
                .map((e) {
              return DataColumn(
                label: SizedBox(
                  width: e.width,
                  child: Text(e.title ?? ""),
                ),
              );
            }).toList(),
            headingRowColor: const WidgetStatePropertyAll(Colors.teal),
            rows: const [],
          ),
        ),
      ),
      DataTable(
        columns: TableColumnHelper.tableColumnsList
            .getRange(
          TableColumnHelper.tableColumnsList.length - 1,
          TableColumnHelper.tableColumnsList.length,
        )
            .map((e) {
          return DataColumn(
            label: SizedBox(
              width: e.width,
              child: Text(e.title ?? ""),
            ),
          );
        }).toList(),
        headingRowColor: WidgetStateProperty.all(Colors.greenAccent),
        rows: const [],
      ),
    ]);
  }
}

class TableColumn {
  String? title;
  double? width;

  TableColumn({this.title, this.width});
}

class TableColumnHelper {
  static List<TableColumn> tableColumnsList = [
    TableColumn(title: 'ID', width: 30),
    TableColumn(title: 'Name', width: 100),
    TableColumn(title: 'Father Name', width: 100),
    TableColumn(title: 'Class', width: 40),
    TableColumn(title: 'Mobile No', width: 100),
    TableColumn(title: 'Edit/Delete', width: 100),
  ];
}
