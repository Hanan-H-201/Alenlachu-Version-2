import 'package:app/services/common/chatbot_service.dart';
import 'package:flutter/material.dart';
import 'package:app/models/common/chat_model.dart';
import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatService _chatService;
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    final authenticationCubit = context.read<AuthenticationCubit>();
    _chatService = ChatService(authenticationCubit: authenticationCubit);
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    try {
      final chatHistory = await _chatService.getChatHistory();
      setState(() {
        _messages = chatHistory;
      });
      _scrollToBottom();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load chat history: $e')),
      );
    }
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    final messageText = _controller.text;
    setState(() {
      _messages.add(ChatMessage(
        userId: '', // This will be ignored for local display purposes
        time: DateTime.now(),
        message: messageText,
        isSender: true,
      ));
      _controller.clear();
    });
    _scrollToBottom();

    try {
      final reply = await _chatService.sendMessage(messageText);
      setState(() {
        _messages.add(ChatMessage(
          userId: '', // This will be ignored for local display purposes
          time: DateTime.now(),
          message: reply,
          isSender: false,
        ));
      });
      _scrollToBottom();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: $e')),
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI ChatBot',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final alignment = message.isSender
                    ? Alignment.centerRight
                    : Alignment.centerLeft;
                final color = message.isSender
                    ? Colors.blueAccent
                    : Colors.grey[300];
                final textColor = message.isSender
                    ? Colors.white
                    : Colors.black87;

                return Align(
                  alignment: alignment,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    child: Text(
                      message.message,
                      maxLines: 100,
                      style: TextStyle(color: textColor),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask me anything...',
                    ),
                    onTap: _scrollToBottom,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

