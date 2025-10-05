class MessageTest {
  final int? id; // auto increment من قاعدة البيانات
  final String message;
  final String type;
  final String senderId;
  final String receiverId;
  final String chatId; // معرف الدردشة
  final DateTime timestamp;

  MessageTest({
    this.id,
    required this.message,
    required this.type,
    required this.senderId,
    required this.receiverId,
    required this.chatId,
    required this.timestamp,
  });

  // تحويل من JSON إلى كائن Message
  factory MessageTest.fromJson(Map<String, dynamic> json) {
    return MessageTest(
      id: json['id'],
      message: json['message'] ?? '',
      type: json['type'] ?? 'text',
      senderId: json['sender_id'] ?? '',
      receiverId: json['receiver_id'] ?? '',
      chatId: json['chat_id'] ?? '',
      timestamp: DateTime.parse(
        json['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  // تحويل الكائن إلى JSON للإرسال للخادم
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'type': type,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'chat_id': chatId,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // تحويل الكائن إلى JSON لحفظه محلياً
  Map<String, dynamic> toLocalJson() {
    return {
      'message': message,
      'type': type,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'chat_id': chatId,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
