import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/calculate.dart';
import 'package:log_table/models/log_data.dart';
import 'package:log_table/ui/providers/log_view_model_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LogPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    final model = watch(logViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGARITHMS"),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.value,
                  style: style.subtitle2!.copyWith(
                    color: scheme.onPrimary
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: SfDataGrid(
        rowHeight: 32,
        frozenColumnsCount: 1,
        headerRowHeight: 40,
        source: LogDataSource(
          data: List.generate(
            90,
            (index) {
              final number = (index + 10);
              return [
                    LogData(
                      label: "$number",
                      value: number / 10,
                      rowSelected: model.rowIndex == number,
                      columnSelected: false,
                      columnName: '',
                      onTap: () {
                        model.rowIndex = number;
                      },
                      isMean: false,
                    ),
                  ] +
                  List.generate(
                    10,
                    (rowIndex) {
                      final Log log = Calculate.logCell(number, rowIndex);
                      return LogData(
                          label: log.label,
                          value: log.value,
                          rowSelected: model.rowIndex == number,
                          columnSelected: model.logIndex == rowIndex,
                          columnName: "$rowIndex",
                          onTap: () {
                            model.logIndex = rowIndex;
                            model.rowIndex = number;
                          },
                          isMean: false);
                    },
                  ) +
                  List.generate(
                    9,
                    (rowIndex) {
                      final Mean log = Calculate.meanCell(number, rowIndex + 1);
                      return LogData(
                        label: log.label,
                        value: log.value,
                        rowSelected: model.rowIndex == number,
                        columnSelected: model.meanIndex == rowIndex + 1,
                        columnName: "$rowIndex",
                        onTap: () {
                          if (model.meanIndex == rowIndex + 1 &&
                              model.rowIndex == number) {
                            model.meanIndex = null;
                          } else {
                            model.meanIndex = rowIndex + 1;
                            model.rowIndex = number;
                          }
                        },
                        isMean: true,
                      );
                    },
                  );
            },
          ),
        ),
        columns: [
              GridColumn(
                minimumWidth: 48,
                maximumWidth: 48,
                columnName: '',
                label: const SizedBox(),
              ),
            ] +
            List.generate(
              10,
              (rowIndex) => GridColumn(
                columnName: rowIndex.toString(),
                label: Material(
                  color: model.logIndex == rowIndex
                      ? theme.primaryColor
                      : theme.cardColor,
                  child: InkWell(
                    onTap: () {
                      model.logIndex = rowIndex;
                    },
                    child: Center(
                      child: Text(
                        "$rowIndex",
                      ),
                    ),
                  ),
                ),
              ),
            ) +
            List.generate(
              9,
              (rowIndex) => GridColumn(
                columnName: "${rowIndex + 1}",
                label: Material(
                  color: model.meanIndex == rowIndex + 1
                      ? scheme.secondary
                      : theme.cardColor,
                  child: InkWell(
                    onTap: () {
                      model.meanIndex = rowIndex + 1;
                    },
                    child: Center(
                      child: Text(
                        "${rowIndex + 1}",
                      ),
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}

class LogDataSource extends DataGridSource {
  LogDataSource({required List<List<LogData>> data}) {
    _data = data
        .map<DataGridRow>((e) => DataGridRow(
            cells: e
                .map((d) => DataGridCell(value: d, columnName: d.columnName))
                .toList()))
        .toList();
  }

  List<DataGridRow> _data = [];

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      final LogData logData = dataGridCell.value as LogData;
      return Builder(builder: (context) {
        final theme = Theme.of(context);
        final scheme = theme.colorScheme;
        return Material(
          color: logData.isMean
              ? (logData.columnSelected && logData.rowSelected
                  ? theme.highlightColor
                  : (logData.columnSelected
                      ? scheme.secondary: logData.rowSelected?theme.shadowColor
                      : scheme.background))
              : (logData.columnSelected && logData.rowSelected
                  ? theme.primaryColorDark
                  : (logData.columnSelected || logData.rowSelected
                      ? theme.primaryColor
                      : theme.cardColor)),
          child: InkWell(
            onTap: logData.onTap,
            child: Center(child: Text(logData.label)),
          ),
        );
      });
    }).toList());
  }
}
