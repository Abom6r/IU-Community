import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/conversation.dart';
import '../models/chat.message.dart';

class ChatService {
  final SupabaseClient _supabase = Supabase.instance.client;

  String get currentUserId => _supabase.auth.currentUser!.id;

  /// إنشاء أو جلب محادثة موجودة مسبقاً بين المستخدم الحالي ومستخدم آخر
  Future<Conversation> startOrGetConversation({
  required String otherUserId,
  required String currentUserName,
  required String otherUserName,
}) async {
  // نبحث إذا فيه محادثة سابقة بين نفس الشخصين
  final existing = await _supabase
      .from('conversations')
      .select()
      .or(
        'and(user1_id.eq.$currentUserId,user2_id.eq.$otherUserId),'
        'and(user1_id.eq.$otherUserId,user2_id.eq.$currentUserId)',
      )
      .maybeSingle();

  if (existing != null) {
    return Conversation.fromMap(existing);
  }

  // ما فيه محادثة سابقة → ننشئ محادثة جديدة
  final inserted = await _supabase
      .from('conversations')
      .insert({
        'user1_id': currentUserId,
        'user2_id': otherUserId,
        'user1_name': currentUserName,
        'user2_name': otherUserName,

        // 👈 هذا هو المهم عشان ما يكون NULL
        'member_ids': [currentUserId, otherUserId],
      })
      .select()
      .single();

  return Conversation.fromMap(inserted);
}


  /// stream لكل المحادثات اللي المستخدم الحالي طرف فيها
  Stream<List<Conversation>> watchConversations() {
    return _supabase
        .from('conversations')
        .stream(primaryKey: ['id'])
        .order('updated_at', ascending: false)
        .map(
          (rows) => rows
              .where(
                (row) =>
                    row['user1_id'] == currentUserId ||
                    row['user2_id'] == currentUserId,
              )
              .map((row) => Conversation.fromMap(row))
              .toList(),
        );
  }

  /// stream رسائل محادثة معيّنة
  Stream<List<ChatMessage>> watchMessages(String conversationId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: false)
        .map(
          (rows) =>
              rows.map((row) => ChatMessage.fromMap(row)).toList(),
        );
  }

  /// إرسال رسالة
  Future<void> sendMessage({
    required String conversationId,
    required String text,
  }) async {
    await _supabase.from('messages').insert({
      'conversation_id': conversationId,
      'sender_id': currentUserId,
      'text': text,
    });

    await _supabase.from('conversations').update({
      'last_message': text,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', conversationId);
  }
}
