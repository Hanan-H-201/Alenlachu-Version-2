import 'package:app/screens/common_screens/chat_page.dart';
import 'package:app/services/common/chat_service.dart';
import 'package:app/widgets/common/user_tile.dart';
import 'package:flutter/material.dart';

class ProfessionallistPage extends StatelessWidget{
  ProfessionallistPage({super.key});

  // chat service and authentication service
  final ChatService _chatService = ChatService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Professional List"),
      ),
      body: _buildProfessionalList(),
    );
}
Widget _buildProfessionalList(){
  return StreamBuilder(
    stream: _chatService.getProfessionalStream(), 
    builder: (context, snapshot){
      // error
      if(snapshot.hasError){
        return const Text("Error");
      }

      //loading
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text("Loading...");
      }

      return ListView(
        children: snapshot.data!.map<Widget>((userData)=> _buildProfessionalListItem(userData,context )).toList(),
      );
    },
    );
}

  // build individual list tile

  Widget _buildProfessionalListItem(
    Map<String, dynamic> userData,BuildContext context){
      // display all users except current user  
      return UserTile(
        text: userData['email'],
        onTap: () =>{
           // tapped on a user -> go to chat page
           Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context)=> ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["_id"],
                ),
              ),
            ),
        },
      );
    }
}