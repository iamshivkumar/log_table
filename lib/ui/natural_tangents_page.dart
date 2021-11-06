import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/models/log_data.dart';
import 'package:log_table/natural_tangents.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'log_data_source.dart';
import 'providers/natural_tangents_view_model_provider.dart';

class NaturalTangentsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    final model = watch(naturalTangentsModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("NATURAL TANGENTS"),
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
              final number = index;
              return [
                    LogData(
                      label: "$number",
                      value: number.toDouble(),
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
                      final Log log = NaturalTangents.tanCell(number, rowIndex/10);
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
                    5,
                    (rowIndex) {
                      final Mean log = NaturalTangents.meanCell(number, rowIndex + 1);
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${rowIndex*6}'",
                            style: style.bodyText1,
                          ),
                          Text(
                            "${rowIndex/10}°",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ) +
            List.generate(
              5,
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
                        "${rowIndex + 1}'",
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