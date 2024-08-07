import 'package:app/controllers/client/journal/journal_cubit.dart';
import 'package:app/controllers/client/journal/journal_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/services/common/utils.dart';
import 'package:app/widgets/common/custome_form_components.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddJournalModal extends StatefulWidget {
  const AddJournalModal({super.key});

  @override
  State<AddJournalModal> createState() => _AddJournalModalState();
}

class _AddJournalModalState extends State<AddJournalModal> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _contentController = TextEditingController();
  Color _currentColor = appTheme.primaryColor;

  @override
  void dispose() {
    _dateController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _currentColor,
            onColorChanged: (color) {
              setState(() {
                _currentColor = color;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JournalCubit, JournalState>(
      listener: (context, state) {
        if (state is JournalOperationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is JournalOperationSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormComponents.buildDatePickerField(
                    context,
                    _dateController,
                    Text('Date', style: appTheme.textTheme.bodyMedium),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormComponents.buildWideTextField(
                      _contentController,
                      Text('write here. . .',
                          style: appTheme.textTheme.bodyMedium),
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your note';
                    }
                    return null;
                  }, minLines: 10, maxLines: 100),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _pickColor,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 3),
                              color: _currentColor,
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Color',
                        style: appTheme.textTheme.labelLarge,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: MainButton(
                        child: state is JournalLoading
                            ? CircularProgressIndicator(
                                color: appTheme.scaffoldBackgroundColor,
                              )
                            : Text(
                                'Save',
                                style: appTheme.textTheme.titleMedium,
                              ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            context.read<JournalCubit>().addJournal(
                                date:
                                    DateTime.parse(_dateController.text.trim()),
                                content: _contentController.text.trim(),
                                color: Utils.getColorInHex(_currentColor));
                          }
                        }),
                  )
                  // ElevatedButton(
                  //   onPressed: () {
                  // if (_formKey.currentState?.validate() ?? false) {
                  //   _formKey.currentState?.save();
                  //   // Handle journal creation logic here
                  //   // For example, call a function from your cubit or BLoC
                  //   Navigator.pop(context);
                  // }
                  //   },
                  //   child: const Text('Create'),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
