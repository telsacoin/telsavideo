// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Video> videoFromJson(String str) =>
    List<Video>.from(json.decode(str).map((x) => Video.fromJson(x)));

String videoToJson(List<Video> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Video {
  Video({
    required this.author,
    required this.permlink,
    required this.category,
    required this.title,
    required this.body,
    required this.jsonMetadata,
    required this.created,
    required this.lastUpdate,
    required this.depth,
    required this.children,
    required this.lastPayout,
    required this.cashoutTime,
    required this.totalPayoutValue,
    required this.curatorPayoutValue,
    required this.pendingPayoutValue,
    required this.promoted,
    required this.replies,
    required this.bodyLength,
    required this.authorReputation,
    required this.parentAuthor,
    required this.parentPermlink,
    required this.url,
    required this.rootTitle,
    required this.beneficiaries,
    required this.maxAcceptedPayout,
    required this.percentHbd,
    required this.postId,
    required this.netRshares,
    required this.activeVotes,
  });

  String author;
  String permlink;
  String category;
  String title;
  String body;
  String jsonMetadata;
  DateTime created;
  DateTime lastUpdate;
  int depth;
  int children;
  DateTime lastPayout;
  DateTime cashoutTime;
  String totalPayoutValue;
  String curatorPayoutValue;
  String pendingPayoutValue;
  String promoted;
  List<dynamic> replies;
  int bodyLength;
  int authorReputation;
  String parentAuthor;
  String parentPermlink;
  String url;
  String rootTitle;
  List<dynamic> beneficiaries;
  String maxAcceptedPayout;
  int percentHbd;
  int postId;
  int netRshares;
  List<ActiveVote> activeVotes;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        author: json["author"],
        permlink: json["permlink"],
        category: json["category"],
        title: json["title"],
        body: json["body"],
        jsonMetadata: json["json_metadata"],
        created: DateTime.parse(json["created"]),
        lastUpdate: DateTime.parse(json["last_update"]),
        depth: json["depth"],
        children: json["children"],
        lastPayout: DateTime.parse(json["last_payout"]),
        cashoutTime: DateTime.parse(json["cashout_time"]),
        totalPayoutValue: json["total_payout_value"],
        curatorPayoutValue: json["curator_payout_value"],
        pendingPayoutValue: json["pending_payout_value"],
        promoted: json["promoted"],
        replies: List<dynamic>.from(json["replies"].map((x) => x)),
        bodyLength: json["body_length"],
        authorReputation: json["author_reputation"],
        parentAuthor: json["parent_author"],
        parentPermlink: json["parent_permlink"],
        url: json["url"],
        rootTitle: json["root_title"],
        beneficiaries: List<dynamic>.from(json["beneficiaries"].map((x) => x)),
        maxAcceptedPayout: json["max_accepted_payout"],
        percentHbd: json["percent_hbd"],
        postId: json["post_id"],
        netRshares: json["net_rshares"],
        activeVotes: List<ActiveVote>.from(
            json["active_votes"].map((x) => ActiveVote.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "permlink": permlink,
        "category": category,
        "title": title,
        "body": body,
        "json_metadata": jsonMetadata,
        "created": created.toIso8601String(),
        "last_update": lastUpdate.toIso8601String(),
        "depth": depth,
        "children": children,
        "last_payout": lastPayout.toIso8601String(),
        "cashout_time": cashoutTime.toIso8601String(),
        "total_payout_value": totalPayoutValue,
        "curator_payout_value": curatorPayoutValue,
        "pending_payout_value": pendingPayoutValue,
        "promoted": promoted,
        "replies": List<dynamic>.from(replies.map((x) => x)),
        "body_length": bodyLength,
        "author_reputation": authorReputation,
        "parent_author": parentAuthor,
        "parent_permlink": parentPermlink,
        "url": url,
        "root_title": rootTitle,
        "beneficiaries": List<dynamic>.from(beneficiaries.map((x) => x)),
        "max_accepted_payout": maxAcceptedPayout,
        "percent_hbd": percentHbd,
        "post_id": postId,
        "net_rshares": netRshares,
        "active_votes": List<dynamic>.from(activeVotes.map((x) => x.toJson())),
      };
}

class ActiveVote {
  ActiveVote({
    required this.percent,
    required this.reputation,
    required this.rshares,
    required this.voter,
  });

  String percent;
  int reputation;
  int rshares;
  String voter;

  factory ActiveVote.fromJson(Map<String, dynamic> json) => ActiveVote(
        percent: json["percent"],
        reputation: json["reputation"],
        rshares: json["rshares"],
        voter: json["voter"],
      );

  Map<String, dynamic> toJson() => {
        "percent": percent,
        "reputation": reputation,
        "rshares": rshares,
        "voter": voter,
      };
}
