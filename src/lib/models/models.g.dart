// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenResponse _$AccessTokenResponseFromJson(Map<String, dynamic> json) {
  return AccessTokenResponse(
    accessToken: json['access_token'] as String,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AccessTokenResponseToJson(
        AccessTokenResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'user': instance.user.toJson(),
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    username: json['name'] as String,
    memoKey: json['memo_key'] as String,
    jsonMetadata: json['json_metadata'] as String,
    proxy: json['proxy'] as String,
    lastOwnerUpdate: DateTime.parse(json['last_owner_update'] as String),
    lastAccountUpdate: DateTime.parse(json['last_account_update'] as String),
    created: DateTime.parse(json['created'] as String),
    mined: json['mined'] as bool,
    ownerChallenged: json['owner_challenged'] as bool,
    activeChallenged: json['active_challenged'] as bool,
    lastOwnerProved: DateTime.parse(json['last_owner_proved'] as String),
    lastActiveProved: DateTime.parse(json['last_active_proved'] as String),
    recoveryAccount: json['recovery_account'] as String,
    lastAccountRecovery:
        DateTime.parse(json['last_account_recovery'] as String),
    resetAccount: json['reset_account'] as String,
    commentCount: json['comment_count'] as int,
    lifetimeVoteCount: json['lifetime_vote_count'] as int,
    postCount: json['post_count'] as int,
    canVote: json['can_vote'] as bool,
    votingPower: json['voting_power'] as int,
    lastVoteTime: DateTime.parse(json['last_vote_time'] as String),
    balance: json['balance'] as String,
    savingsBalance: json['savings_balance'] as String,
    sbdBalance: json['sbd_balance'] as String,
    sbdSeconds: json['sbd_seconds'] as String,
    sbdSecondsLastUpdate:
        DateTime.parse(json['sbd_seconds_last_update'] as String),
    sbdLastInterestPayment:
        DateTime.parse(json['sbd_last_interest_payment'] as String),
    savingsSbdBalance: json['savings_sbd_balance'] as String,
    savingsSbdSeconds: json['savings_sbd_seconds'] as String,
    savingsSbdSecondsLastUpdate:
        DateTime.parse(json['savings_sbd_seconds_last_update'] as String),
    savingsSbdLastInterestPayment:
        DateTime.parse(json['savings_sbd_last_interest_payment'] as String),
    savingsWithdrawRequests: json['savings_withdraw_requests'] as int,
    rewardSbdBalance: json['reward_sbd_balance'] as String,
    rewardSteemBalance: json['reward_steem_balance'] as String,
    rewardVestingBalance: json['reward_vesting_balance'] as String,
    rewardVestingSteem: json['reward_vesting_steem'] as String,
    vestingShares: json['vesting_shares'] as String,
    delegatedVestingShares: json['delegated_vesting_shares'] as String,
    receivedVestingShares: json['received_vesting_shares'] as String,
    vestingWithdrawRate: json['vesting_withdraw_rate'] as String,
    nextVestingWithdrawal:
        DateTime.parse(json['next_vesting_withdrawal'] as String),
    withdrawn: json['withdrawn'] as int,
    toWithdraw: json['to_withdraw'] as int,
    withdrawRoutes: json['withdraw_routes'] as int,
    curationRewards: json['curation_rewards'] as int,
    postingRewards: json['posting_rewards'] as int,
    proxiedVsfVotes: (json['proxied_vsf_votes'] as List<dynamic>)
        .map((e) => e as int)
        .toList(),
    witnessesVotedFor: json['witnesses_voted_for'] as int,
    averageBandwith: json['average_bandwith'] as int,
    lifetimeBandwith: json['lifetime_bandwith'] as String,
    lastBandwithUpdate: DateTime.parse(json['last_bandwith_update'] as String),
    averageMarketBandwith: json['average_market_bandwith'] as int,
    lifetimeMarketBandwith: json['lifetime_market_bandwith'] as int,
    lastMarketBandwithUpdate:
        DateTime.parse(json['last_market_bandwith_update'] as String),
    lastPost: DateTime.parse(json['last_post'] as String),
    lastRootPost: DateTime.parse(json['last_root_post'] as String),
    vestingBalance: json['vesting_balance'] as String,
    reputation: json['reputation'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'proxy': instance.proxy,
      'balance': instance.balance,
      'created': instance.created.toIso8601String(),
      'mined': instance.mined,
      'withdrawn': instance.withdrawn,
      'name': instance.username,
      'memo_key': instance.memoKey,
      'json_metadata': instance.jsonMetadata,
      'last_owner_update': instance.lastOwnerUpdate.toIso8601String(),
      'last_account_update': instance.lastAccountUpdate.toIso8601String(),
      'owner_challenged': instance.ownerChallenged,
      'active_challenged': instance.activeChallenged,
      'last_owner_proved': instance.lastOwnerProved.toIso8601String(),
      'last_active_proved': instance.lastActiveProved.toIso8601String(),
      'recovery_account': instance.recoveryAccount,
      'last_account_recovery': instance.lastAccountRecovery.toIso8601String(),
      'reset_account': instance.resetAccount,
      'comment_count': instance.commentCount,
      'lifetime_vote_count': instance.lifetimeVoteCount,
      'post_count': instance.postCount,
      'can_vote': instance.canVote,
      'voting_power': instance.votingPower,
      'last_vote_time': instance.lastVoteTime.toIso8601String(),
      'savings_balance': instance.savingsBalance,
      'sbd_balance': instance.sbdBalance,
      'sbd_seconds': instance.sbdSeconds,
      'sbd_seconds_last_update':
          instance.sbdSecondsLastUpdate.toIso8601String(),
      'sbd_last_interest_payment':
          instance.sbdLastInterestPayment.toIso8601String(),
      'savings_sbd_balance': instance.savingsSbdBalance,
      'savings_sbd_seconds': instance.savingsSbdSeconds,
      'savings_sbd_seconds_last_update':
          instance.savingsSbdSecondsLastUpdate.toIso8601String(),
      'savings_sbd_last_interest_payment':
          instance.savingsSbdLastInterestPayment.toIso8601String(),
      'savings_withdraw_requests': instance.savingsWithdrawRequests,
      'reward_sbd_balance': instance.rewardSbdBalance,
      'reward_steem_balance': instance.rewardSteemBalance,
      'reward_vesting_balance': instance.rewardVestingBalance,
      'reward_vesting_steem': instance.rewardVestingSteem,
      'vesting_shares': instance.vestingShares,
      'delegated_vesting_shares': instance.delegatedVestingShares,
      'received_vesting_shares': instance.receivedVestingShares,
      'vesting_withdraw_rate': instance.vestingWithdrawRate,
      'next_vesting_withdrawal':
          instance.nextVestingWithdrawal.toIso8601String(),
      'to_withdraw': instance.toWithdraw,
      'withdraw_routes': instance.withdrawRoutes,
      'curation_rewards': instance.curationRewards,
      'posting_rewards': instance.postingRewards,
      'proxied_vsf_votes': instance.proxiedVsfVotes,
      'witnesses_voted_for': instance.witnessesVotedFor,
      'average_bandwith': instance.averageBandwith,
      'lifetime_bandwith': instance.lifetimeBandwith,
      'last_bandwith_update': instance.lastBandwithUpdate.toIso8601String(),
      'average_market_bandwith': instance.averageMarketBandwith,
      'lifetime_market_bandwith': instance.lifetimeMarketBandwith,
      'last_market_bandwith_update':
          instance.lastMarketBandwithUpdate.toIso8601String(),
      'last_post': instance.lastPost.toIso8601String(),
      'last_root_post': instance.lastRootPost.toIso8601String(),
      'vesting_balance': instance.vestingBalance,
      'reputation': instance.reputation,
    };

Followers _$FollowersFromJson(Map<String, dynamic> json) {
  return Followers(
    follower: json['follower'] as String,
    following: json['following'] as String,
    what: json['what'] as String,
  );
}

Map<String, dynamic> _$FollowersToJson(Followers instance) => <String, dynamic>{
      'follower': instance.follower,
      'following': instance.following,
      'what': instance.what,
    };

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as String,
    author: json['author'] as String,
    permlink: json['permlink'] as String,
    category: json['category'] as String,
    parentAuthor: json['parent_author'] as String,
    parentPermlink: json['parent_permlink'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
    jsonMetadata: json['json_metadata'] as String,
    lastUpdate: DateTime.parse(json['last_update'] as String),
    created: DateTime.parse(json['created'] as String),
    active: DateTime.parse(json['active'] as String),
    lastPayout: DateTime.parse(json['last_payout'] as String),
    depth: json['depth'] as int,
    children: json['children'] as int,
    netRShares: json['net_rshares'] as String,
    absRShares: json['abs_rshares'] as String,
    voteRShares: json['vote_rshares'] as String,
    childrenAbsRShares: json['children_abs_rshares'] as String,
    cashoutTime: DateTime.parse(json['cashout_time'] as String),
    maxCashoutTime: DateTime.parse(json['max_cashout_time'] as String),
    totalVoteWeight: json['total_vote_weight'] as int,
    rewardWeight: json['reward_weight'] as int,
    totalPayoutValue: json['total_payout_value'] as String,
    curatorPayoutValue: json['curator_payout_value'] as String,
    authorRewards: json['author_rewards'] as int,
    netVotes: json['net_votes'] as int,
    rootComment: json['root_comment'] as int,
    maxAcceptedPayout: json['max_accepted_payout'] as String,
    percentSteemDollars: json['percent_steem_dollars'] as int,
    allowReplies: json['allow_replies'] as bool,
    allowVotes: json['allow_votes'] as bool,
    allowCurationRewards: json['allow_curation_rewards'] as bool,
    beneficiaries: (json['beneficiaries'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    blog: json['blog'] as String,
    reblogOn: DateTime.parse(json['reblog_on'] as String),
    reblogBy:
        (json['reblog_by'] as List<dynamic>).map((e) => e as String).toList(),
    entryId: json['entry_id'] as int,
  )
    ..vote = json['vote'] as bool
    ..flag = json['flag'] as bool
    ..isNSFW = json['isNSFW'] as bool
    ..tags = (json['tags'] as List<dynamic>).map((e) => e as String).toList();
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'permlink': instance.permlink,
      'category': instance.category,
      'title': instance.title,
      'body': instance.body,
      'blog': instance.blog,
      'created': instance.created!.toIso8601String(),
      'active': instance.active!.toIso8601String(),
      'depth': instance.depth,
      'children': instance.children,
      'vote': instance.vote,
      'flag': instance.flag,
      'isNSFW': instance.isNSFW,
      'tags': instance.tags,
      'parent_author': instance.parentAuthor,
      'parent_permlink': instance.parentPermlink,
      'json_metadata': instance.jsonMetadata,
      'last_update': instance.lastUpdate.toIso8601String(),
      'last_payout': instance.lastPayout.toIso8601String(),
      'net_rshares': instance.netRShares,
      'abs_rshares': instance.absRShares,
      'vote_rshares': instance.voteRShares,
      'children_abs_rshares': instance.childrenAbsRShares,
      'cashout_time': instance.cashoutTime.toIso8601String(),
      'max_cashout_time': instance.maxCashoutTime.toIso8601String(),
      'total_vote_weight': instance.totalVoteWeight,
      'reward_weight': instance.rewardWeight,
      'total_payout_value': instance.totalPayoutValue,
      'curator_payout_value': instance.curatorPayoutValue,
      'author_rewards': instance.authorRewards,
      'net_votes': instance.netVotes,
      'root_comment': instance.rootComment,
      'max_accepted_payout': instance.maxAcceptedPayout,
      'percent_steem_dollars': instance.percentSteemDollars,
      'allow_replies': instance.allowReplies,
      'allow_votes': instance.allowVotes,
      'allow_curation_rewards': instance.allowCurationRewards,
      'beneficiaries': instance.beneficiaries,
      'reblog_on': instance.reblogOn.toIso8601String(),
      'reblog_by': instance.reblogBy,
      'entry_id': instance.entryId,
    };

Reply _$ReplyFromJson(Map<String, dynamic> json) {
  return Reply(
    id: json['id'] as String,
    author: json['author'] as String,
    permlink: json['permlink'] as String,
    category: json['category'] as String,
    parentAuthor: json['parent_author'] as String,
    parentPermlink: json['parent_permlink'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
    jsonMetadata: json['json_metadata'] as String,
    lastUpdate: DateTime.parse(json['last_update'] as String),
    created: DateTime.parse(json['created'] as String),
    active: DateTime.parse(json['active'] as String),
    lastPayout: DateTime.parse(json['last_payout'] as String),
    depth: json['depth'] as int,
    children: json['children'] as int,
    netRShares: json['net_rshares'] as int,
    absRShares: json['abs_rshares'] as int,
    voteRShares: json['vote_rshares'] as int,
    childrenAbsRShares: json['children_abs_rshares'] as int,
    cashoutTime: DateTime.parse(json['cashout_time'] as String),
    maxCashoutTime: DateTime.parse(json['max_cashout_time'] as String),
    totalVoteWeight: json['total_vote_weight'] as int,
    rewardWeight: json['reward_weight'] as int,
    totalPayoutValue: json['total_payout_value'] as String,
    curatorPayoutValue: json['curator_payout_value'] as String,
    authorRewards: json['author_rewards'] as int,
    netVotes: json['net_votes'] as int,
    rootComment: json['root_comment'] as int,
    maxAcceptedPayout: json['max_accepted_payout'] as String,
    percentSteemDollars: json['percent_steem_dollars'] as int,
    allowReplies: json['allow_replies'] as bool,
    allowVotes: json['allow_votes'] as bool,
    allowCurationRewards: json['allow_curation_rewards'] as bool,
    beneficiaries: (json['beneficiaries'] as List<dynamic>)
        .map((e) => Beneficiary.fromJson(e as Map<String, dynamic>))
        .toList(),
    url: json['url'] as String,
    rootTitle: json['root_title'] as String,
    pendingPayoutValue: json['pending_payout_value'] as String,
    totalPendingPayoutValue: json['total_pending_payout_value'] as String,
    activeVotes: (json['active_votes'] as List<dynamic>)
        .map((e) => ActiveVote.fromJson(e as Map<String, dynamic>))
        .toList(),
    replies: (json['replies'] as List<dynamic>)
        .map((e) => Reply.fromJson(e as Map<String, dynamic>))
        .toList(),
    authorReputation: json['author_reputation'] as String,
    promoted: json['promoted'] as String,
    bodyLength: json['body_length'] as int,
    rebloggedBy: (json['reblogged_by'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'permlink': instance.permlink,
      'category': instance.category,
      'title': instance.title,
      'body': instance.body,
      'url': instance.url,
      'promoted': instance.promoted,
      'created': instance.created.toIso8601String(),
      'active': instance.active.toIso8601String(),
      'depth': instance.depth,
      'children': instance.children,
      'beneficiaries': instance.beneficiaries.map((e) => e.toJson()).toList(),
      'replies': instance.replies.map((e) => e.toJson()).toList(),
      'parent_author': instance.parentAuthor,
      'parent_permlink': instance.parentPermlink,
      'json_metadata': instance.jsonMetadata,
      'last_update': instance.lastUpdate.toIso8601String(),
      'last_payout': instance.lastPayout.toIso8601String(),
      'net_rshares': instance.netRShares,
      'abs_rshares': instance.absRShares,
      'vote_rshares': instance.voteRShares,
      'children_abs_rshares': instance.childrenAbsRShares,
      'cashout_time': instance.cashoutTime.toIso8601String(),
      'max_cashout_time': instance.maxCashoutTime.toIso8601String(),
      'total_vote_weight': instance.totalVoteWeight,
      'reward_weight': instance.rewardWeight,
      'total_payout_value': instance.totalPayoutValue,
      'curator_payout_value': instance.curatorPayoutValue,
      'author_rewards': instance.authorRewards,
      'net_votes': instance.netVotes,
      'root_comment': instance.rootComment,
      'max_accepted_payout': instance.maxAcceptedPayout,
      'percent_steem_dollars': instance.percentSteemDollars,
      'allow_replies': instance.allowReplies,
      'allow_votes': instance.allowVotes,
      'allow_curation_rewards': instance.allowCurationRewards,
      'root_title': instance.rootTitle,
      'pending_payout_value': instance.pendingPayoutValue,
      'total_pending_payout_value': instance.totalPendingPayoutValue,
      'active_votes': instance.activeVotes.map((e) => e.toJson()).toList(),
      'author_reputation': instance.authorReputation,
      'body_length': instance.bodyLength,
      'reblogged_by': instance.rebloggedBy,
    };

ActiveVote _$ActiveVoteFromJson(Map<String, dynamic> json) {
  return ActiveVote(
    voter: json['voter'] as String,
    weight: json['weight'] as int,
    rshares: json['rshares'] as String,
    percent: json['percent'] as int,
    reputation: json['reputation'] as String,
    time: DateTime.parse(json['time'] as String),
  );
}

Map<String, dynamic> _$ActiveVoteToJson(ActiveVote instance) =>
    <String, dynamic>{
      'voter': instance.voter,
      'rshares': instance.rshares,
      'reputation': instance.reputation,
      'weight': instance.weight,
      'percent': instance.percent,
      'time': instance.time.toIso8601String(),
    };

PostVote _$PostVoteFromJson(Map<String, dynamic> json) {
  return PostVote(
    authorperm: json['authorperm'] as String,
    weight: json['weight'] as int,
    rshares: json['rshares'] as int,
    percent: json['percent'] as int,
    time: DateTime.parse(json['time'] as String),
  );
}

Map<String, dynamic> _$PostVoteToJson(PostVote instance) => <String, dynamic>{
      'authorperm': instance.authorperm,
      'weight': instance.weight,
      'rshares': instance.rshares,
      'percent': instance.percent,
      'time': instance.time!.toIso8601String(),
    };

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
    name: json['name'] as String,
    totalPayouts: json['total_payouts'] as String,
    netVotes: json['net_votes'] as int,
    topPosts: json['top_posts'] as int,
    comments: json['comments'] as int,
    trending: json['trending'] as String,
  );
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'name': instance.name,
      'trending': instance.trending,
      'comments': instance.comments,
      'total_payouts': instance.totalPayouts,
      'net_votes': instance.netVotes,
      'top_posts': instance.topPosts,
    };

Relationship _$RelationshipFromJson(Map<String, dynamic> json) {
  return Relationship(
    follower: json['follower'] as String,
    following: json['following'] as String,
    what: (json['what'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$RelationshipToJson(Relationship instance) =>
    <String, dynamic>{
      'follower': instance.follower,
      'following': instance.following,
      'what': instance.what,
    };

Beneficiary _$BeneficiaryFromJson(Map<String, dynamic> json) {
  return Beneficiary(
    account: json['account'] as String,
    weight: json['weight'] as int,
  );
}

Map<String, dynamic> _$BeneficiaryToJson(Beneficiary instance) =>
    <String, dynamic>{
      'account': instance.account,
      'weight': instance.weight,
    };
