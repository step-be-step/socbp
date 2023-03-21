import 'package:flutter/foundation.dart';

import 'package:socbp/core/enums/post_type_enum.dart';

@immutable
class Post {
  final String text;
  final List<String> hashtags;
  final String link;
  final List<String> imageLinks;
  final String uid;
  final PostType postType;
  final DateTime postAt;
  final List<String> likes;
  final List<String> commentId;
  final String id;
  final int reshareCount;
  final String repostedBy;
  const Post({
    required this.text,
    required this.hashtags,
    required this.link,
    required this.imageLinks,
    required this.uid,
    required this.postType,
    required this.postAt,
    required this.likes,
    required this.commentId,
    required this.id,
    required this.reshareCount,
    required this.repostedBy,
  });

  Post copyWith({
    String? text,
    List<String>? hashtags,
    String? link,
    List<String>? imageLinks,
    String? uid,
    PostType? postType,
    DateTime? postAt,
    List<String>? likes,
    List<String>? commentId,
    String? id,
    int? reshareCount,
    String? repostedBy,
  }) {
    return Post(
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      link: link ?? this.link,
      imageLinks: imageLinks ?? this.imageLinks,
      uid: uid ?? this.uid,
      postType: postType ?? this.postType,
      postAt: postAt ?? this.postAt,
      likes: likes ?? this.likes,
      commentId: commentId ?? this.commentId,
      id: id ?? this.id,
      reshareCount: reshareCount ?? this.reshareCount,
      repostedBy: repostedBy ?? this.repostedBy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});
    result.addAll({'hashtags': hashtags});
    result.addAll({'link': link});
    result.addAll({'imageLinks': imageLinks});
    result.addAll({'uid': uid});
    result.addAll({'postType': postType.type});
    result.addAll({'postAt': postAt.millisecondsSinceEpoch});
    result.addAll({'likes': likes});
    result.addAll({'commentId': commentId});
    result.addAll({'reshareCount': reshareCount});
    result.addAll({'repostedBy': repostedBy});

    return result;
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      text: map['text'] ?? '',
      hashtags: List<String>.from(map['hashtags']),
      link: map['link'] ?? '',
      imageLinks: List<String>.from(map['imageLinks']),
      uid: map['uid'] ?? '',
      postType: (map['postType'] as String).toPostTypeEnum(),
      postAt: DateTime.fromMillisecondsSinceEpoch(map['postAt']),
      likes: List<String>.from(map['likes']),
      commentId: List<String>.from(map['commentId']),
      id: map['\$id'] ?? '',
      reshareCount: map['reshareCount']?.toInt() ?? 0,
      repostedBy: map['repostedBy'],
    );
  }

  @override
  String toString() {
    return 'Post(text: $text, hashtags: $hashtags, link: $link, imageLinks: $imageLinks, uid: $uid, postType: $postType, postAt: $postAt, likes: $likes, commentId: $commentId, id: $id, reshareCount: $reshareCount, repostedBy: $repostedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.text == text &&
        listEquals(other.hashtags, hashtags) &&
        other.link == link &&
        listEquals(other.imageLinks, imageLinks) &&
        other.uid == uid &&
        other.postType == postType &&
        other.postAt == postAt &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentId, commentId) &&
        other.id == id &&
        other.reshareCount == reshareCount &&
        other.repostedBy == repostedBy;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        hashtags.hashCode ^
        link.hashCode ^
        imageLinks.hashCode ^
        uid.hashCode ^
        postType.hashCode ^
        postAt.hashCode ^
        likes.hashCode ^
        commentId.hashCode ^
        id.hashCode ^
        reshareCount.hashCode & repostedBy.hashCode;
  }
}
