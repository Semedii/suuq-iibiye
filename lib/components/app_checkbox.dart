import 'package:flutter/material.dart';

class AppCheckBox extends FormField<bool> {
  AppCheckBox({
    super.key,
    Widget? title,
    required bool value,
    Function(bool?)? onChanged,
    super.validator,
    bool super.initialValue = false,
  }) : super(builder: (FormFieldState<bool> state) {
          return ListTileTheme(
            horizontalTitleGap: 0,
            child: CheckboxListTile(
              title: title,
              value: value,
              onChanged: onChanged,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText ?? "",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          );
        });
}
