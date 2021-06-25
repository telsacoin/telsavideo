import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(explicitToJson: true)
class AccessTokenResponse {
  @JsonKey(name: 'access_token')
  String accessToken;

  User user;

  AccessTokenResponse({required this.accessToken, required this.user});

  factory AccessTokenResponse.fromJson(Map<String, dynamic> map) =>
      _$AccessTokenResponseFromJson(map);

  Map<String, dynamic> toJson() => _$AccessTokenResponseToJson(this);
}

/* TODO: Again, Owl codegen doesn't support Map<String,int>. Feel free to PR
@JsonSerializable()
class Authority {
  @JsonKey(name: 'weight_treshold')
  int weightTreshold;
  @JsonKey(name: 'account_auths')
  String accountAuths;
  @JsonKey(name: 'key_auths')
  Set<String, int> keyAuths;

  Authority({this.weightTreshold, this.accountAuths, this.keyAuths});
  factory Authority.fromJson(Map map) => AuthorityMapper.parse(map);
  Map<String, dynamic> toJson() => AuthorityMapper.map(this);
}
*/

@JsonSerializable(explicitToJson: true)
class User {
  String id, proxy, balance;
  DateTime created;
  bool mined;
  int withdrawn;

  //Authority owner, active, posting;

  @JsonKey(name: 'name')
  String username;
  @JsonKey(name: 'memo_key')
  String memoKey;
  @JsonKey(name: 'json_metadata')
  String jsonMetadata;
  @JsonKey(name: 'last_owner_update')
  DateTime lastOwnerUpdate;
  @JsonKey(name: 'last_account_update')
  DateTime lastAccountUpdate;
  @JsonKey(name: 'owner_challenged')
  bool ownerChallenged;
  @JsonKey(name: 'active_challenged')
  bool activeChallenged;
  @JsonKey(name: 'last_owner_proved')
  DateTime lastOwnerProved;
  @JsonKey(name: 'last_active_proved')
  DateTime lastActiveProved;
  @JsonKey(name: 'recovery_account')
  String recoveryAccount;
  @JsonKey(name: 'last_account_recovery')
  DateTime lastAccountRecovery;
  @JsonKey(name: 'reset_account')
  String resetAccount;
  @JsonKey(name: 'comment_count')
  int commentCount;
  @JsonKey(name: 'lifetime_vote_count')
  int lifetimeVoteCount;
  @JsonKey(name: 'post_count')
  int postCount;
  @JsonKey(name: 'can_vote')
  bool canVote;
  @JsonKey(name: 'voting_power')
  int votingPower;
  @JsonKey(name: 'last_vote_time')
  DateTime lastVoteTime;
  @JsonKey(name: 'savings_balance')
  String savingsBalance;
  @JsonKey(name: 'sbd_balance')
  String sbdBalance;
  @JsonKey(name: 'sbd_seconds')
  String sbdSeconds;
  @JsonKey(name: 'sbd_seconds_last_update')
  DateTime sbdSecondsLastUpdate;
  @JsonKey(name: 'sbd_last_interest_payment')
  DateTime sbdLastInterestPayment;
  @JsonKey(name: 'savings_sbd_balance')
  String savingsSbdBalance;
  @JsonKey(name: 'savings_sbd_seconds')
  String savingsSbdSeconds;
  @JsonKey(name: 'savings_sbd_seconds_last_update')
  DateTime savingsSbdSecondsLastUpdate;
  @JsonKey(name: 'savings_sbd_last_interest_payment')
  DateTime savingsSbdLastInterestPayment;
  @JsonKey(name: 'savings_withdraw_requests')
  int savingsWithdrawRequests;
  @JsonKey(name: 'reward_sbd_balance')
  String rewardSbdBalance;
  @JsonKey(name: 'reward_steem_balance')
  String rewardSteemBalance;
  @JsonKey(name: 'reward_vesting_balance')
  String rewardVestingBalance;
  @JsonKey(name: 'reward_vesting_steem')
  String rewardVestingSteem;
  @JsonKey(name: 'vesting_shares')
  String vestingShares;
  @JsonKey(name: 'delegated_vesting_shares')
  String delegatedVestingShares;
  @JsonKey(name: 'received_vesting_shares')
  String receivedVestingShares;
  @JsonKey(name: 'vesting_withdraw_rate')
  String vestingWithdrawRate;
  @JsonKey(name: 'next_vesting_withdrawal')
  DateTime nextVestingWithdrawal;
  @JsonKey(name: 'to_withdraw')
  int toWithdraw;
  @JsonKey(name: 'withdraw_routes')
  int withdrawRoutes;
  @JsonKey(name: 'curation_rewards')
  int curationRewards;
  @JsonKey(name: 'posting_rewards')
  int postingRewards;
  @JsonKey(name: 'proxied_vsf_votes')
  List<int> proxiedVsfVotes;
  @JsonKey(name: 'witnesses_voted_for')
  int witnessesVotedFor;
  @JsonKey(name: 'average_bandwith')
  int averageBandwith;
  @JsonKey(name: 'lifetime_bandwith')
  String lifetimeBandwith;
  @JsonKey(name: 'last_bandwith_update')
  DateTime lastBandwithUpdate;
  @JsonKey(name: 'average_market_bandwith')
  int averageMarketBandwith;
  @JsonKey(name: 'lifetime_market_bandwith')
  int lifetimeMarketBandwith;
  @JsonKey(name: 'last_market_bandwith_update')
  DateTime lastMarketBandwithUpdate;
  @JsonKey(name: 'last_post')
  DateTime lastPost;
  @JsonKey(name: 'last_root_post')
  DateTime lastRootPost;
  @JsonKey(name: 'vesting_balance')
  String vestingBalance;
  @JsonKey(name: 'reputation')
  int reputation;

  /* TODO: Owl codegen doesn't support Map (?) - Feel free to implement and PR
  @JsonField(key: 'transfer_history')
  Map<int, Object> transferHistory;
  @JsonField(key: 'market_history')
  Map<int, Object> marketHistory;
  @JsonField(key: 'post_history')
  Map<int, Object> postHistory;
  @JsonField(key: 'vote_history')
  Map<int, Object> voteHistory;
  @JsonField(key: 'other_history')
  Map<int, Object> otherHistory;
  @JsonField(key: 'witness_votes')
  List<String> witnessVotes;
  @JsonField(key: 'tags_usage')
  Map<String, int> tagsUsage;
  @JsonField(key: 'guest_bloggers')
  Map<String, int> guestBloggers;
  */

  User({
    required this.id,
    required this.username,
    /*this.owner,
    this.active,
    this.posting,*/
    required this.memoKey,
    required this.jsonMetadata,
    required this.proxy,
    required this.lastOwnerUpdate,
    required this.lastAccountUpdate,
    required this.created,
    required this.mined,
    required this.ownerChallenged,
    required this.activeChallenged,
    required this.lastOwnerProved,
    required this.lastActiveProved,
    required this.recoveryAccount,
    required this.lastAccountRecovery,
    required this.resetAccount,
    required this.commentCount,
    required this.lifetimeVoteCount,
    required this.postCount,
    required this.canVote,
    required this.votingPower,
    required this.lastVoteTime,
    required this.balance,
    required this.savingsBalance,
    required this.sbdBalance,
    required this.sbdSeconds,
    required this.sbdSecondsLastUpdate,
    required this.sbdLastInterestPayment,
    required this.savingsSbdBalance,
    required this.savingsSbdSeconds,
    required this.savingsSbdSecondsLastUpdate,
    required this.savingsSbdLastInterestPayment,
    required this.savingsWithdrawRequests,
    required this.rewardSbdBalance,
    required this.rewardSteemBalance,
    required this.rewardVestingBalance,
    required this.rewardVestingSteem,
    required this.vestingShares,
    required this.delegatedVestingShares,
    required this.receivedVestingShares,
    required this.vestingWithdrawRate,
    required this.nextVestingWithdrawal,
    required this.withdrawn,
    required this.toWithdraw,
    required this.withdrawRoutes,
    required this.curationRewards,
    required this.postingRewards,
    required this.proxiedVsfVotes,
    required this.witnessesVotedFor,
    required this.averageBandwith,
    required this.lifetimeBandwith,
    required this.lastBandwithUpdate,
    required this.averageMarketBandwith,
    required this.lifetimeMarketBandwith,
    required this.lastMarketBandwithUpdate,
    required this.lastPost,
    required this.lastRootPost,
    required this.vestingBalance,
    required this.reputation,
  });

  factory User.fromJson(Map<String, dynamic> map) => _$UserFromJson(map);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Followers {
  String follower, following, what;

  Followers(
      {required this.follower, required this.following, required this.what});

  factory Followers.fromJson(Map<String, dynamic> map) =>
      _$FollowersFromJson(map);

  Map<String, dynamic> toJson() => _$FollowersToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Post {
  String? id;
  String? author;
  String? permlink;
  String? category;
  String? title;
  String? body;
  String? blog;
  DateTime? created;
  DateTime? active;
  int? depth;
  int? children;
  bool? vote;
  bool? flag;
  bool? isNSFW;
  List<String>? tags;

  @JsonKey(name: 'parent_author')
  String parentAuthor;
  @JsonKey(name: 'parent_permlink')
  String parentPermlink;
  @JsonKey(name: 'json_metadata')
  String jsonMetadata;
  @JsonKey(name: 'last_update')
  DateTime lastUpdate;
  @JsonKey(name: 'last_payout')
  DateTime lastPayout;
  @JsonKey(name: 'net_rshares')
  String netRShares;
  @JsonKey(name: 'abs_rshares')
  String absRShares;
  @JsonKey(name: 'vote_rshares')
  String voteRShares;
  @JsonKey(name: 'children_abs_rshares')
  String childrenAbsRShares;
  @JsonKey(name: 'cashout_time')
  DateTime cashoutTime;
  @JsonKey(name: 'max_cashout_time')
  DateTime maxCashoutTime;
  @JsonKey(name: 'total_vote_weight')
  int totalVoteWeight;
  @JsonKey(name: 'reward_weight')
  int rewardWeight;
  @JsonKey(name: 'total_payout_value')
  String totalPayoutValue;
  @JsonKey(name: 'curator_payout_value')
  String curatorPayoutValue;
  @JsonKey(name: 'author_rewards')
  int authorRewards;
  @JsonKey(name: 'net_votes')
  int netVotes;
  @JsonKey(name: 'root_comment')
  int rootComment;
  @JsonKey(name: 'max_accepted_payout')
  String maxAcceptedPayout;
  @JsonKey(name: 'percent_steem_dollars')
  int percentSteemDollars;
  @JsonKey(name: 'allow_replies')
  bool allowReplies;
  @JsonKey(name: 'allow_votes')
  bool allowVotes;
  @JsonKey(name: 'allow_curation_rewards')
  bool allowCurationRewards;
  @JsonKey(name: 'beneficiaries')
  List<String> beneficiaries;
  @JsonKey(name: 'reblog_on')
  DateTime reblogOn;
  @JsonKey(name: 'reblog_by')
  List<String> reblogBy;
  @JsonKey(name: 'entry_id')
  int entryId;

  Post(
      {required this.id,
      required this.author,
      required this.permlink,
      required this.category,
      required this.parentAuthor,
      required this.parentPermlink,
      required this.title,
      required this.body,
      required this.jsonMetadata,
      required this.lastUpdate,
      required this.created,
      required this.active,
      required this.lastPayout,
      required this.depth,
      required this.children,
      required this.netRShares,
      required this.absRShares,
      required this.voteRShares,
      required this.childrenAbsRShares,
      required this.cashoutTime,
      required this.maxCashoutTime,
      required this.totalVoteWeight,
      required this.rewardWeight,
      required this.totalPayoutValue,
      required this.curatorPayoutValue,
      required this.authorRewards,
      required this.netVotes,
      required this.rootComment,
      required this.maxAcceptedPayout,
      required this.percentSteemDollars,
      required this.allowReplies,
      required this.allowVotes,
      required this.allowCurationRewards,
      required this.beneficiaries,
      required this.blog,
      required this.reblogOn,
      required this.reblogBy,
      required this.entryId});

  factory Post.fromJson(Map<String, dynamic> map) => _$PostFromJson(map);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Reply {
  String id, author, permlink, category, title, body, url, promoted;
  DateTime created, active;
  int depth, children;
  List<Beneficiary> beneficiaries;
  List<Reply> replies;

  @JsonKey(name: 'parent_author')
  String parentAuthor;
  @JsonKey(name: 'parent_permlink')
  String parentPermlink;
  @JsonKey(name: 'json_metadata')
  String jsonMetadata;
  @JsonKey(name: 'last_update')
  DateTime lastUpdate;
  @JsonKey(name: 'last_payout')
  DateTime lastPayout;
  @JsonKey(name: 'net_rshares')
  int netRShares;
  @JsonKey(name: 'abs_rshares')
  int absRShares;
  @JsonKey(name: 'vote_rshares')
  int voteRShares;
  @JsonKey(name: 'children_abs_rshares')
  int childrenAbsRShares;
  @JsonKey(name: 'cashout_time')
  DateTime cashoutTime;
  @JsonKey(name: 'max_cashout_time')
  DateTime maxCashoutTime;
  @JsonKey(name: 'total_vote_weight')
  int totalVoteWeight;
  @JsonKey(name: 'reward_weight')
  int rewardWeight;
  @JsonKey(name: 'total_payout_value')
  String totalPayoutValue;
  @JsonKey(name: 'curator_payout_value')
  String curatorPayoutValue;
  @JsonKey(name: 'author_rewards')
  int authorRewards;
  @JsonKey(name: 'net_votes')
  int netVotes;
  @JsonKey(name: 'root_comment')
  int rootComment;
  @JsonKey(name: 'max_accepted_payout')
  String maxAcceptedPayout;
  @JsonKey(name: 'percent_steem_dollars')
  int percentSteemDollars;
  @JsonKey(name: 'allow_replies')
  bool allowReplies;
  @JsonKey(name: 'allow_votes')
  bool allowVotes;
  @JsonKey(name: 'allow_curation_rewards')
  bool allowCurationRewards;
  @JsonKey(name: 'root_title')
  String rootTitle;
  @JsonKey(name: 'pending_payout_value')
  String pendingPayoutValue;
  @JsonKey(name: 'total_pending_payout_value')
  String totalPendingPayoutValue;
  @JsonKey(name: 'active_votes')
  List<ActiveVote> activeVotes;
  @JsonKey(name: 'author_reputation')
  String authorReputation;
  @JsonKey(name: 'body_length')
  int bodyLength;
  @JsonKey(name: 'reblogged_by')
  List<String> rebloggedBy;

  Reply(
      {required this.id,
      required this.author,
      required this.permlink,
      required this.category,
      required this.parentAuthor,
      required this.parentPermlink,
      required this.title,
      required this.body,
      required this.jsonMetadata,
      required this.lastUpdate,
      required this.created,
      required this.active,
      required this.lastPayout,
      required this.depth,
      required this.children,
      required this.netRShares,
      required this.absRShares,
      required this.voteRShares,
      required this.childrenAbsRShares,
      required this.cashoutTime,
      required this.maxCashoutTime,
      required this.totalVoteWeight,
      required this.rewardWeight,
      required this.totalPayoutValue,
      required this.curatorPayoutValue,
      required this.authorRewards,
      required this.netVotes,
      required this.rootComment,
      required this.maxAcceptedPayout,
      required this.percentSteemDollars,
      required this.allowReplies,
      required this.allowVotes,
      required this.allowCurationRewards,
      required this.beneficiaries,
      required this.url,
      required this.rootTitle,
      required this.pendingPayoutValue,
      required this.totalPendingPayoutValue,
      required this.activeVotes,
      required this.replies,
      required this.authorReputation,
      required this.promoted,
      required this.bodyLength,
      required this.rebloggedBy});

  factory Reply.fromJson(Map<String, dynamic> map) => _$ReplyFromJson(map);

  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ActiveVote {
  String voter, rshares, reputation;
  int weight, percent;
  DateTime time;

  ActiveVote(
      {required this.voter,
      required this.weight,
      required this.rshares,
      required this.percent,
      required this.reputation,
      required this.time});

  factory ActiveVote.fromJson(Map<String, dynamic> map) =>
      _$ActiveVoteFromJson(map);

  Map<String, dynamic> toJson() => _$ActiveVoteToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PostVote {
  String? authorperm;
  int? weight;
  int? rshares;
  int? percent;
  DateTime? time;

  PostVote(
      {required this.authorperm,
      required this.weight,
      required this.rshares,
      required this.percent,
      required this.time});

  factory PostVote.fromJson(Map<String, dynamic> map) =>
      _$PostVoteFromJson(map);

  Map<String, dynamic> toJson() => _$PostVoteToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Tag {
  String? name;
  String? trending;
  int? comments;

  @JsonKey(name: 'total_payouts')
  String totalPayouts;
  @JsonKey(name: 'net_votes')
  int netVotes;
  @JsonKey(name: 'top_posts')
  int topPosts;

  Tag(
      {required this.name,
      required this.totalPayouts,
      required this.netVotes,
      required this.topPosts,
      required this.comments,
      required this.trending});

  factory Tag.fromJson(Map<String, dynamic> map) => _$TagFromJson(map);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}

/// Relationship between users (follows, followed by)
@JsonSerializable(explicitToJson: true)
class Relationship {
  String? follower, following;
  List<String>? what;

  Relationship({this.follower, this.following, this.what});

  factory Relationship.fromJson(Map<String, dynamic> map) =>
      _$RelationshipFromJson(map);

  Map<String, dynamic> toJson() => _$RelationshipToJson(this);
}

/// The various actions that can be performed on a relationship on Steem
abstract class RelationshipAction {
  /// Follow a user
  static const String follow = 'follow';

  /// Unfollow a user
  static const String unfollow = 'unfollow';
}

@JsonSerializable(explicitToJson: true)
class Beneficiary {
  String account;
  int weight;

  Beneficiary({required this.account, required this.weight});

  factory Beneficiary.fromJson(Map<String, dynamic> map) =>
      _$BeneficiaryFromJson(map);

  Map<String, dynamic> toJson() => _$BeneficiaryToJson(this);
}
