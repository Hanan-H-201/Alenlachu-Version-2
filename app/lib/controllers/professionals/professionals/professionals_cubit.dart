import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app/controllers/professionals/professionals/professionals_state.dart';
import 'package:app/core/api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class ProfessionalsCubit extends Cubit<ProfessionalsState> {
  ProfessionalsCubit() : super(ProfessionalsInitial());

  void uploadFile() async {
    // File? _file;
    // String? _fileName;
    // bool _isUploading = false;
    // String? _fileUrl;

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        emit(LicenseUploaded(
            file: File(result.files.single.path!),
            filename: path.basename(result.files.single.path!)));
      } else {
        emit(ProfessionalsInitial());
      }
    } catch (e) {
      emit(LicenseUploadFailed(error: e.toString()));
    }
  }

  void saveFile(File? file, String? filename, String profId) async {
    emit(UploadindLicense());
    if (file == null || filename == null) {
      emit(LicenseUploadFailed(error: 'File or filename is null'));
      return;
    }

    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('uploads/$filename');
      final uploadTask = storageRef.putFile(file);

      await uploadTask.whenComplete(() async {
        String fileUrl = await storageRef.getDownloadURL();
        final response = await http.put(
            Uri.parse('${ApiUrl.updateProfessionalUrl}?id=$profId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                {'licenseUrl': fileUrl, 'verificationStatus': 'pending'}));
        if (response.statusCode == 200) {
          emit(ProcessingData());
        } else {
          final jsonResponse = jsonDecode(response.body);
          emit(LicenseUploadFailed(
              error: 'Failed to upload file: ${jsonResponse['error']}'));
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
// import 'package:path/path.dart' as path;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FilePickerScreen(),
//     );
//   }
// }

// class FilePickerScreen extends StatefulWidget {
//   @override
//   _FilePickerScreenState createState() => _FilePickerScreenState();
// }

// class _FilePickerScreenState extends State<FilePickerScreen> {
//   File? _file;
//   String? _fileName;
//   bool _isUploading = false;
//   String? _fileUrl;

//   Future<void> _pickFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
//     );

//     if (result != null && result.files.isNotEmpty) {
//       setState(() {
//         _file = File(result.files.single.path!);
//         _fileName = path.basename(result.files.single.path!);
//       });
//     }
//   }

//   Future<void> _uploadFile() async {
//     if (_file == null) return;

//     setState(() {
//       _isUploading = true;
//     });

//     try {
      // final storageRef = FirebaseStorage.instance.ref().child('uploads/$_fileName');
      // final uploadTask = storageRef.putFile(_file!);

      // await uploadTask.whenComplete(() async {
      //   _fileUrl = await storageRef.getDownloadURL();
      //   setState(() {
      //     _isUploading = false;
      //   });
      // });

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('File uploaded successfully: $_fileUrl')),
      // );
//     } catch (e) {
//       setState(() {
//         _isUploading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to upload file: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pick and Upload File'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _file != null
//                 ? _fileName!.endsWith('.pdf')
//                     ? Icon(Icons.picture_as_pdf, size: 100)
//                     : Image.file(_file!, height: 150)
//                 : Text('No file selected'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickFile,
//               child: Text('Pick File'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isUploading ? null : _uploadFile,
//               child: _isUploading ? CircularProgressIndicator() : Text('Save'),
//             ),
//             SizedBox(height: 20),
//             _fileUrl != null ? Text('Uploaded file URL: $_fileUrl') : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }

