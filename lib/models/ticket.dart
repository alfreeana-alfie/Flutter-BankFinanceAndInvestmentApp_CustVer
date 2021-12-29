import 'package:flutter_banking_app/utils/string.dart';

class Ticket {
  int? id,
      supportTicketId,
      senderId,
      status,
      operatorId,
      priority,
      closedUserId;

  String? subject, message,  createdAt;

   Ticket(
      {this.id,
      this.supportTicketId,
      this.subject,
      this.message,
      this.senderId, 
      this.status,
      this.priority, 
      this.operatorId, 
      this.closedUserId, 
      this.createdAt});

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map[Field.id] as int?,
      supportTicketId: map[Field.supportTicketId] as int?,
      subject: map[Field.subject] as String?,
      message: map[Field.message] as String?,
      senderId: map[Field.senderId] as int?,
      status: map[Field.status] as int?,
      priority: map[Field.priority] as int?,
      operatorId: map[Field.operatorId] as int?,
      closedUserId: map[Field.closedUserId] as int?,
      createdAt: map[Field.createdAt] as String?,
    );
  }
}
