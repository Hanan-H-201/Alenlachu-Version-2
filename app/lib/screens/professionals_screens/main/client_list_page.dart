import 'package:app/screens/common_screens/chat_page.dart';
import 'package:app/services/common/chat_service.dart';
import 'package:app/widgets/common/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientlistPage extends StatelessWidget{
  
  ClientlistPage({super.key});

  // chat service and authentication service
  final ChatService _chatService = ChatService();
        

  @override
  Widget build(BuildContext context) {
    final authenticationState = context.read<AuthenticationCubit>().state;
    String? receiverID;
    if (authenticationState is AuthenticatedAsProfessional) {
      receiverID = authenticationState.profession.id;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Client List"),
      ),
      body: receiverID!=null ? StreamBuilder(
    stream: _chatService.getClientStream(receiverID), 
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
        children: snapshot.data!.map<Widget>((userData)=> _buildClientListItem(userData,context )).toList(),
      );
    },
    ): Center(child: Text("Error: Professional ID not found")),
    );
}

  // build individual list tile

  Widget _buildClientListItem(
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