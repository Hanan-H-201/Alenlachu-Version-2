import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/services/common/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverID;
  final String receiverEmail;

  ChatPage({required this.receiverID, required this.receiverEmail});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatService _chatService;
  String? senderID;
  String? senderEmail;
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _chatService = ChatService();
    _initializeUser();
    _loadMessages();
    _chatService.registerOnMessageReceived((message) {
      setState(() {
        _messages.add(message);
      });
    });
  }

  @override
  void dispose() {
    _chatService.unregisterOnMessageReceived();
    super.dispose();
  }

  void _initializeUser() {
    final authenticationState = context.read<AuthenticationCubit>().state;

    if (authenticationState is AuthenticatedAsClient) {
      setState(() {
        senderID = authenticationState.client.id;
        senderEmail = authenticationState.client.email;
      });
      _chatService.joinRoom(senderID!, widget.receiverID);
    } else if (authenticationState is AuthenticatedAsProfessional) {
      setState(() {
        senderID = authenticationState.profession.id;
        senderEmail = authenticationState.profession.email;
      });
      _chatService.joinRoom(senderID!, widget.receiverID);
    }
  }

  void _loadMessages() async {
    if (senderID != null) {
      List<Map<String, dynamic>> messages =
          await _chatService.getMessages(senderID!, widget.receiverID);
      setState(() {
        _messages = messages;
      });
    }
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty && senderID != null) {
      _chatService.sendMessage(senderID!, widget.receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.receiverEmail),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        bool isSender = message['senderID'] == senderID;
        return Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: isSender ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message['message'],
              style: TextStyle(color: isSender ? Colors.white : Colors.black),
              overflow: TextOverflow.visible,
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: const InputDecoration(hintText: "Type your message..."),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: sendMessage,
        ),
      ],
    );
  }
}