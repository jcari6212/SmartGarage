class Message
{
  final String message;
  final String id;
  final String receiver;

  Message(this.message, this.id, this.receiver);

  factory Message.fromJson(jsonData ){
    return Message(jsonData['message'] , jsonData['id'], jsonData['receiver']);
  }
}