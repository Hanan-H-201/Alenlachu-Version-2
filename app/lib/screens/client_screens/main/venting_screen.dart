import 'package:app/core/app.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/controllers/client/venting/venting_cubit.dart';
import 'package:app/services/client/venting_service.dart';
import 'package:get/get.dart';

class VentingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VentingCubit(VentingService())..fetchMessages(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Venting Space".tr,
            style: GoogleFonts.dmSans(
              textStyle: appTheme.textTheme.titleLarge,
            ),
          ),
          backgroundColor: appTheme.primaryColor,
        ),
        body: VentingBody(),
      ),
    );
  }
}

class VentingBody extends StatefulWidget {
  @override
  _VentingBodyState createState() => _VentingBodyState();
}

class _VentingBodyState extends State<VentingBody> {
  final TextEditingController _controller = TextEditingController();
  String? _editingId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VentingCubit, VentingState>(
      listener: (context, state) {
        if (state is VentingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        Widget content;

        if (state is VentingLoading) {
          content = Center(child: CircularProgressIndicator());
        } else if (state is VentingLoaded) {
          content = state.messages.isNotEmpty
              ? ListView.builder(
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[state.messages.length - 1 - index];
              return Align(
                alignment: Alignment.centerRight, // Align the entire row to the right
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Shrink the row to fit its content
                    crossAxisAlignment: CrossAxisAlignment.start, // Align items vertically
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: appTheme.primaryColor),
                        onPressed: () {
                          setState(() {
                            _editingId = message['id'];
                            _controller.text = message['text'];
                          });
                        },
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                message['text'.tr]!,
                                style: GoogleFonts.dmSans(
                                    textStyle: appTheme.textTheme.bodyMedium),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                              SizedBox(height: 5),
                              Text(
                                _formatTimestamp(message['timestamp']!),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )

            : Center(child: Text("No messages yet. Start venting.".tr));
        } else {
          content = Center(child: Text("No messages yet. Start venting.".tr));
        }

        return Column(
          children: [
            Expanded(child: content),
            Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: _editingId == null
                            ? "Type your feelings...".tr
                            : "Edit your message...".tr,
                        hintStyle: GoogleFonts.dmSans(
                            textStyle: appTheme.textTheme.bodyMedium),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: appTheme.primaryColor,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.send, color: appTheme.primaryColor),
                    onPressed: () {
                      if (_editingId != null) {
                        context
                            .read<VentingCubit>()
                            .editMessage(_editingId!, _controller.text);
                        setState(() {
                          _editingId = null;
                        });
                      } else {
                        context.read<VentingCubit>().sendMessage(
                          _controller.text,
                        );
                      }
                      _controller.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatTimestamp(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    final now = DateTime.now();
    if (now.difference(dateTime).inDays == 0) {
      return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
    } else {
      return "${dateTime.year}/${dateTime.month}/${dateTime.day}";
    }
  }
}
