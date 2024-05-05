import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

Future<DateTime?> showDatePickerCustom(
    BuildContext context,
    DateTime startDate,
    DateTime endDate,
    ) async {
    return await showDatePicker(
      context: context,
      firstDate: startDate,
      lastDate: endDate,

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                onSurfaceVariant: TColor.SECONDARY_BACKGROUND,
                primary: TColor.PRIMARY,
                onPrimary: TColor.PRIMARY_TEXT,
                onSurface: TColor.PRIMARY_TEXT,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: TColor.PRIMARY,
                ),
              ),
              textTheme: TextTheme(
                bodyMedium: TxtStyle.normalTextDesc
              ),
              datePickerTheme: DatePickerThemeData(
                  backgroundColor: TColor.SECONDARY_BACKGROUND,
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TxtStyle.normalTextDesc,
                    helperStyle: TxtStyle.normalTextDesc,
                    hintStyle: TxtStyle.normalTextDesc,
                  ),
                  headerHelpStyle: TxtStyle.headSection,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  weekdayStyle: TxtStyle.normalTextDesc,
                  dayStyle: TxtStyle.normalTextDesc,
                  yearStyle: TxtStyle.normalTextDesc,
              ),
          ),
          child: child!,
        );
      },
    );
}