import 'dart:convert';
import 'package:app/core/api.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late IO.Socket socket;
ChatService() {
    // Initialize the socket connection
    socket = IO.io(
      ApiUrl.baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build(),
    );

    // Connect to the WebSocket server
    socket.connect();

    // Listen for connection events
    socket.onConnect((_) {
      print('Connected to WebSocket');
    });

    // Handle connection errors
    socket.onConnectError((data) {
      print('Connection Error: $data');
    });

    // Handle disconnection
    socket.onDisconnect((_) {
      print('Disconnected from WebSocket');
    });
    // Listen for incoming messages
    socket.on('receiveMessage', (data) {
      print('Received message: $data');
      if (onMessageReceived != null) {
        onMessageReceived!(data);
      }
    });
    socket.on('receiveVideoChatRequest', (data) {
      final senderID = data['senderID'];
      final channelName = data['channelName'];
      _showVideoChatNotification(senderID, channelName);
    });
  }
  
  void emitVideoChatRequest(String senderID, String receiverID, String channelName) {
    socket.emit('videoChatRequest', {
      'senderID': senderID,
      'receiverID': receiverID,
      'channelName': channelName,
    });
  }

  void _showVideoChatNotification(String senderID, String channelName) {
    // Handle notification logic here
  }

  void joinRoom(String senderID, String receiverID) {
    socket.emit('joinRoom', {
      'senderID': senderID,
      'receiverID': receiverID,
    });
  }

  void sendMessage(String senderID, String receiverID, String message) {
    socket.emit('sendMessage', {
      'senderID': senderID,
      'receiverID': receiverID,
      'message': message,
    });
  }

  // Method to fetch messages
  Future<List<Map<String, dynamic>>> getMessages(String senderID, String receiverID) async {
    final chatroomID = generateChatRoomID(senderID, receiverID);
    final response = await http.get(Uri.parse('${ApiUrl.getRealtimeMessageUrl}/$chatroomID'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((msg) => msg as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  // Utility to generate chatroomID
  String generateChatRoomID(String senderID, String receiverID) {
    final ids = [senderID, receiverID];
    ids.sort();
    return ids.join('_');
  }

  Stream<List<Map<String, dynamic>>> getProfessionalStream() async* {
    final response = await http.get(Uri.parse(ApiUrl.professionalList));
    if (response.statusCode == 200) {
      List<dynamic> professionals = jsonDecode(response.body);
      yield professionals.map((professional) => professional as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load professionals');
    }
  }
  Stream<List<Map<String, dynamic>>> getClientStream(String receiverID) async* {
    final response = await http.get(Uri.parse('${ApiUrl.clientDetailsUrl}/$receiverID'));
    if (response.statusCode == 200) {
      List<dynamic> clients = jsonDecode(response.body);
      yield clients.map((client) => client as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load professionals');
    }
  }
  // Callback function for received messages
  Function(Map<String, dynamic>)? onMessageReceived;

  // Register the callback
  void registerOnMessageReceived(Function(Map<String, dynamic>) callback) {
    onMessageReceived = callback;
  }

  // Unregister the callback
  void unregisterOnMessageReceived() {
    onMessageReceived = null;
  }
}

