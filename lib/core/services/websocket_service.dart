import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// lib/services/websocket_service.dart
class WebSocketService {
  WebSocketChannel? _channel;
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();

  // الاتصال بالخادم
  void connect(String url) {
    _channel = IOWebSocketChannel.connect(Uri.parse(url));

    // الاستماع للرسائل الواردة
    _channel?.stream.listen(
      (data) {
        final message = json.decode(data);
        _messageController.add(message);
      },
      onDone: () {
        print('Connection closed');
      },
      onError: (error) {
        print('Error: $error');
      },
    );
  }

  // إرسال رسالة
  void sendMessage(Map<String, dynamic> data) {
    if (_channel?.sink != null) {
      _channel?.sink.add(json.encode(data));
    }
  }

  // الانضمام لدردشة
  void joinChat(String chatId) {
    sendMessage({'action': 'join_chat', 'chat_id': chatId});
  }

  // إرسال رسالة نصية
  void sendTextMessage(
    String chatId,
    String text,
    String senderId,
    String type,
    String receiverId,
  ) {
    sendMessage({
      'action': 'send_message',
      'chat_id': chatId,
      'message': text,
      'type': type,
      'sender_id': senderId,
      'receiver_id': receiverId,
    });
  }

  // مغادرة دردشة
  void leaveChat(String chatId) {
    sendMessage({'action': 'leave_chat', 'chat_id': chatId});
  }

  // دفق الرسائل الواردة
  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;

  // إغلاق الاتصال
  void disconnect() {
    _channel?.sink.close();
    _messageController.close();
  }
}

// class WebSocketService {
//   late WebSocketChannel _channel;
//   bool _isConnected = false;
//   final String _serverUrl;
//   String _currentChatId = '';

//   // دوال الاستماع
//   Function(List<Message>, String)? onMessageHistory;
//   Function(Message)? onNewMessage;
//   Function()? onConnected;
//   Function()? onDisconnected;

//   WebSocketService({String? serverUrl})
//     : _serverUrl = 'ws://192.168.1.5:8080/duraykish_market/server_chat.php';

//   void connect() {
//     try {
//       _channel = IOWebSocketChannel.connect(_serverUrl);
//       _isConnected = true;

//       _channel.stream.listen(
//         (data) {
//           _handleMessage(data);
//         },
//         onDone: () {
//           _isConnected = false;
//           onDisconnected?.call();
//           print('تم إغلاق اتصال WebSocket');
//         },
//         onError: (error) {
//           print('خطأ في WebSocket: $error');
//         },
//       );

//       onConnected?.call();
//       print('تم الاتصال بخادم WebSocket بنجاح');
//     } catch (e) {
//       print('فشل في الاتصال: $e');
//     }
//   }

//   void _handleMessage(dynamic data) {
//     try {
//       final message = jsonDecode(data);
//       final action = message['action'];
//       final chatId = message['chat_id'];

//       switch (action) {
//         case 'message_history':
//           final List<dynamic> messagesJson = message['messages'];
//           final List<Message> messages = messagesJson
//               .map((json) => Message.fromJson({...json, 'chat_id': chatId}))
//               .toList();
//           onMessageHistory?.call(messages, chatId);
//           break;

//         case 'new_message':
//           final Message newMessage = Message.fromJson({
//             ...message,
//             'chat_id': chatId,
//           });
//           onNewMessage?.call(newMessage);
//           break;
//       }
//     } catch (e) {
//       print('خطأ في معالجة الرسالة: $e');
//     }
//   }

//   // الانضمام إلى دردشة محددة
//   void joinChat(String chatId) {
//     if (!_isConnected) {
//       print('ليس متصلاً بالخادم');
//       return;
//     }

//     try {
//       final joinData = {'action': 'join_chat', 'chat_id': chatId};

//       _channel.sink.add(json.encode(joinData));
//       _currentChatId = chatId;
//       print('انضم إلى الدردشة: $chatId');
//     } catch (e) {
//       print('خطأ في الانضمام للدردشة: $e');
//     }
//   }

//   // مغادرة دردشة
//   void leaveChat(String chatId) {
//     if (!_isConnected) {
//       return;
//     }

//     try {
//       final leaveData = {'action': 'leave_chat', 'chat_id': chatId};

//       _channel.sink.add(json.encode(leaveData));
//       if (_currentChatId == chatId) {
//         _currentChatId = '';
//       }
//       print('غادر الدردشة: $chatId');
//     } catch (e) {
//       print('خطأ في مغادرة الدردشة: $e');
//     }
//   }

//   // إرسال رسالة إلى دردشة محددة
//   void sendMessage(Message message) {
//     if (!_isConnected) {
//       print('ليس متصلاً بالخادم');
//       return;
//     }

//     try {
//       final messageData = {
//         'action': 'send_message',
//         'chat_id': message.chatId,
//         ...message.toJson(),
//       };

//       _channel.sink.add(json.encode(messageData));
//     } catch (e) {
//       print('خطأ في إرسال الرسالة: $e');
//     }
//   }

//   void disconnect() {
//     if (_currentChatId.isNotEmpty) {
//       leaveChat(_currentChatId);
//     }
//     _channel.sink.close();
//     _isConnected = false;
//     onDisconnected?.call();
//   }

//   bool get isConnected => _isConnected;
//   String get currentChatId => _currentChatId;
// }
