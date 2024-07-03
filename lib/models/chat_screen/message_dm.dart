class MessageDm {
  SenderType? senderType;
  String? message;
  String? messageTime;

  MessageDm(this.senderType, this.message, this.messageTime);

  factory MessageDm.fromJson(Map<String, dynamic> json) {
    return MessageDm(json['senderType'], json['message'], json['messageTime']);
  }

  toJson() {
    Map<String, dynamic> json = {};
    json['senderType'] = this.senderType;
    json['message'] = this.message;
    json['messageTime'] = this.messageTime;
    return json;
  }
}

enum SenderType { user, ai }

extension SenderTypeExtension on SenderType {
  String get value {
    switch (this) {
      case SenderType.user:
        return 'user';
      case SenderType.ai:
        return 'ai';
      default:
        return '';
    }
  }
}
