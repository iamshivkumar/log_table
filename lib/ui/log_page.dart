import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/calculate.dart';
import 'package:log_table/models/log_data.dart';
import 'package:log_table/ui/providers/log_view_model_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'log_data_source.dart';

class LogPage extends ConsumerWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    final model = ref.watch(logViewModelProvider);
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
                      ? scheme.primaryContainer
                      : scheme.surface,
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
                      ? scheme.tertiaryContainer
                      : scheme.surface,
                  child: InkWell(
                    onTap: () {
                      if (model.meanIndex == rowIndex + 1) {
                        model.meanIndex = null;
                      } else {
                        model.meanIndex = rowIndex + 1;
                      }
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
