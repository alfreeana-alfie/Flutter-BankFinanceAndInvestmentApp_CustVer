import 'package:flutter_banking_app/utils/string.dart';

class Ticket {
  int? id;

  String? supportTicketId, subject, message,  createdAt,
      senderId,
      status,
      operatorId,
      priority,
      closedUserId;

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
      supportTicketId: map[Field.supportTicketId] as String?,
      subject: map[Field.subject] as String?,
      message: map[Field.message] as String?,
      senderId: map[Field.senderId] as String?,
      status: map[Field.status] as String?,
      priority: map[Field.priority] as String?,
      operatorId: map[Field.operatorId] as String?,
      closedUserId: map[Field.closedUserId] as String?,
      createdAt: map[Field.createdAt] as String?,
    );
  }
}
