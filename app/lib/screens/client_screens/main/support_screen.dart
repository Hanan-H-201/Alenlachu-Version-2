import 'package:app/screens/client_screens/main/professionalList_page.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [const Text('Support'),
        MainButton(
                  child: const Text("Professional List"), 
                  onPressed: () {
                   Navigator.push(
                      context, MaterialPageRoute(
                          builder: (context)=> ProfessionallistPage(),
                          )
                        );
                       }
                    ),
      ]),
      
    );
  }
}
