// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

// ignore: non_constant_identifier_names
HiveData HiveDataFromJson(String str) => HiveData.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String HiveDataToJson(HiveData data) => json.encode(data.toJson());

class HiveData {
  HiveData({
    required this.user,
    required this.id,
    required this.name,
    required this.account,
    required this.scope,
    required this.userMetadata,
  });

  String user;
  String id;
  String name;
  Account account;
  List<String> scope;
  UserMetadata userMetadata;

  factory HiveData.fromJson(Map<String, dynamic> json) => HiveData(
        user: json["user"],
        id: json["_id"],
        name: json["name"],
        account: Account.fromJson(json["account"]),
        scope: List<String>.from(json["scope"].map((x) => x)),
        userMetadata: UserMetadata.fromJson(json["user_metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "_id": id,
        "name": name,
        "account": account.toJson(),
        "scope": List<dynamic>.from(scope.map((x) => x)),
        "user_metadata": userMetadata.toJson(),
      };
}

class Account {
  Account({
    required this.id,
    required this.name,
    required this.owner,
    required this.active,
    required this.posting,
    required this.memoKey,
    required this.jsonMetadata,
    required this.postingJsonMetadata,
    required this.proxy,
    required this.lastOwnerUpdate,
    required this.lastAccountUpdate,
    required this.created,
    required this.mined,
    required this.recoveryAccount,
    required this.lastAccountRecovery,
    required this.resetAccount,
    required this.commentCount,
    required this.lifetimeVoteCount,
    required this.postCount,
    required this.canVote,
    required this.votingManabar,
    required this.downvoteManabar,
    required this.votingPower,
    required this.balance,
    required this.savingsBalance,
    required this.hbdBalance,
    required this.hbdSeconds,
    required this.hbdSecondsLastUpdate,
    required this.hbdLastInterestPayment,
    required this.savingsHbdBalance,
    required this.savingsHbdSeconds,
    required this.savingsHbdSecondsLastUpdate,
    required this.savingsHbdLastInterestPayment,
    required this.savingsWithdrawRequests,
    required this.rewardHbdBalance,
    required this.rewardHiveBalance,
    required this.rewardVestingBalance,
    required this.rewardVestingHive,
    required this.vestingShares,
    required this.delegatedVestingShares,
    required this.receivedVestingShares,
    required this.vestingWithdrawRate,
    required this.postVotingPower,
    required this.nextVestingWithdrawal,
    required this.withdrawn,
    required this.toWithdraw,
    required this.withdrawRoutes,
    required this.pendingTransfers,
    required this.curationRewards,
    required this.postingRewards,
    required this.proxiedVsfVotes,
    required this.witnessesVotedFor,
    required this.lastPost,
    required this.lastRootPost,
    required this.lastVoteTime,
    required this.postBandwidth,
    required this.pendingClaimedAccounts,
    required this.governanceVoteExpirationTs,
    required this.delayedVotes,
    required this.openRecurrentTransfers,
    required this.vestingBalance,
    required this.reputation,
    required this.transferHistory,
    required this.marketHistory,
    required this.postHistory,
    required this.voteHistory,
    required this.otherHistory,
    required this.witnessVotes,
    required this.tagsUsage,
    required this.guestBloggers,
  });

  int id;
  String name;
  Active owner;
  Active active;
  Active posting;
  String memoKey;
  String jsonMetadata;
  String postingJsonMetadata;
  String proxy;
  DateTime lastOwnerUpdate;
  DateTime lastAccountUpdate;
  DateTime created;
  bool mined;
  String recoveryAccount;
  DateTime lastAccountRecovery;
  String resetAccount;
  int commentCount;
  int lifetimeVoteCount;
  int postCount;
  bool canVote;
  Manabar votingManabar;
  Manabar downvoteManabar;
  int votingPower;
  String balance;
  String savingsBalance;
  String hbdBalance;
  String hbdSeconds;
  DateTime hbdSecondsLastUpdate;
  DateTime hbdLastInterestPayment;
  String savingsHbdBalance;
  String savingsHbdSeconds;
  DateTime savingsHbdSecondsLastUpdate;
  DateTime savingsHbdLastInterestPayment;
  int savingsWithdrawRequests;
  String rewardHbdBalance;
  String rewardHiveBalance;
  String rewardVestingBalance;
  String rewardVestingHive;
  String vestingShares;
  String delegatedVestingShares;
  String receivedVestingShares;
  String vestingWithdrawRate;
  String postVotingPower;
  DateTime nextVestingWithdrawal;
  int withdrawn;
  int toWithdraw;
  int withdrawRoutes;
  int pendingTransfers;
  int curationRewards;
  int postingRewards;
  List<int> proxiedVsfVotes;
  int witnessesVotedFor;
  DateTime lastPost;
  DateTime lastRootPost;
  DateTime lastVoteTime;
  int postBandwidth;
  int pendingClaimedAccounts;
  DateTime governanceVoteExpirationTs;
  List<dynamic> delayedVotes;
  int openRecurrentTransfers;
  String vestingBalance;
  int reputation;
  List<dynamic> transferHistory;
  List<dynamic> marketHistory;
  List<dynamic> postHistory;
  List<dynamic> voteHistory;
  List<dynamic> otherHistory;
  List<dynamic> witnessVotes;
  List<dynamic> tagsUsage;
  List<dynamic> guestBloggers;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        owner: Active.fromJson(json["owner"]),
        active: Active.fromJson(json["active"]),
        posting: Active.fromJson(json["posting"]),
        memoKey: json["memo_key"],
        jsonMetadata: json["json_metadata"],
        postingJsonMetadata: json["posting_json_metadata"],
        proxy: json["proxy"],
        lastOwnerUpdate: DateTime.parse(json["last_owner_update"]),
        lastAccountUpdate: DateTime.parse(json["last_account_update"]),
        created: DateTime.parse(json["created"]),
        mined: json["mined"],
        recoveryAccount: json["recovery_account"],
        lastAccountRecovery: DateTime.parse(json["last_account_recovery"]),
        resetAccount: json["reset_account"],
        commentCount: json["comment_count"],
        lifetimeVoteCount: json["lifetime_vote_count"],
        postCount: json["post_count"],
        canVote: json["can_vote"],
        votingManabar: Manabar.fromJson(json["voting_manabar"]),
        downvoteManabar: Manabar.fromJson(json["downvote_manabar"]),
        votingPower: json["voting_power"],
        balance: json["balance"],
        savingsBalance: json["savings_balance"],
        hbdBalance: json["hbd_balance"],
        hbdSeconds: json["hbd_seconds"],
        hbdSecondsLastUpdate: DateTime.parse(json["hbd_seconds_last_update"]),
        hbdLastInterestPayment:
            DateTime.parse(json["hbd_last_interest_payment"]),
        savingsHbdBalance: json["savings_hbd_balance"],
        savingsHbdSeconds: json["savings_hbd_seconds"],
        savingsHbdSecondsLastUpdate:
            DateTime.parse(json["savings_hbd_seconds_last_update"]),
        savingsHbdLastInterestPayment:
            DateTime.parse(json["savings_hbd_last_interest_payment"]),
        savingsWithdrawRequests: json["savings_withdraw_requests"],
        rewardHbdBalance: json["reward_hbd_balance"],
        rewardHiveBalance: json["reward_hive_balance"],
        rewardVestingBalance: json["reward_vesting_balance"],
        rewardVestingHive: json["reward_vesting_hive"],
        vestingShares: json["vesting_shares"],
        delegatedVestingShares: json["delegated_vesting_shares"],
        receivedVestingShares: json["received_vesting_shares"],
        vestingWithdrawRate: json["vesting_withdraw_rate"],
        postVotingPower: json["post_voting_power"],
        nextVestingWithdrawal: DateTime.parse(json["next_vesting_withdrawal"]),
        withdrawn: json["withdrawn"],
        toWithdraw: json["to_withdraw"],
        withdrawRoutes: json["withdraw_routes"],
        pendingTransfers: json["pending_transfers"],
        curationRewards: json["curation_rewards"],
        postingRewards: json["posting_rewards"],
        proxiedVsfVotes:
            List<int>.from(json["proxied_vsf_votes"].map((x) => x)),
        witnessesVotedFor: json["witnesses_voted_for"],
        lastPost: DateTime.parse(json["last_post"]),
        lastRootPost: DateTime.parse(json["last_root_post"]),
        lastVoteTime: DateTime.parse(json["last_vote_time"]),
        postBandwidth: json["post_bandwidth"],
        pendingClaimedAccounts: json["pending_claimed_accounts"],
        governanceVoteExpirationTs:
            DateTime.parse(json["governance_vote_expiration_ts"]),
        delayedVotes: List<dynamic>.from(json["delayed_votes"].map((x) => x)),
        openRecurrentTransfers: json["open_recurrent_transfers"],
        vestingBalance: json["vesting_balance"],
        reputation: json["reputation"],
        transferHistory:
            List<dynamic>.from(json["transfer_history"].map((x) => x)),
        marketHistory: List<dynamic>.from(json["market_history"].map((x) => x)),
        postHistory: List<dynamic>.from(json["post_history"].map((x) => x)),
        voteHistory: List<dynamic>.from(json["vote_history"].map((x) => x)),
        otherHistory: List<dynamic>.from(json["other_history"].map((x) => x)),
        witnessVotes: List<dynamic>.from(json["witness_votes"].map((x) => x)),
        tagsUsage: List<dynamic>.from(json["tags_usage"].map((x) => x)),
        guestBloggers: List<dynamic>.from(json["guest_bloggers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "owner": owner.toJson(),
        "active": active.toJson(),
        "posting": posting.toJson(),
        "memo_key": memoKey,
        "json_metadata": jsonMetadata,
        "posting_json_metadata": postingJsonMetadata,
        "proxy": proxy,
        "last_owner_update": lastOwnerUpdate.toIso8601String(),
        "last_account_update": lastAccountUpdate.toIso8601String(),
        "created": created.toIso8601String(),
        "mined": mined,
        "recovery_account": recoveryAccount,
        "last_account_recovery": lastAccountRecovery.toIso8601String(),
        "reset_account": resetAccount,
        "comment_count": commentCount,
        "lifetime_vote_count": lifetimeVoteCount,
        "post_count": postCount,
        "can_vote": canVote,
        "voting_manabar": votingManabar.toJson(),
        "downvote_manabar": downvoteManabar.toJson(),
        "voting_power": votingPower,
        "balance": balance,
        "savings_balance": savingsBalance,
        "hbd_balance": hbdBalance,
        "hbd_seconds": hbdSeconds,
        "hbd_seconds_last_update": hbdSecondsLastUpdate.toIso8601String(),
        "hbd_last_interest_payment": hbdLastInterestPayment.toIso8601String(),
        "savings_hbd_balance": savingsHbdBalance,
        "savings_hbd_seconds": savingsHbdSeconds,
        "savings_hbd_seconds_last_update":
            savingsHbdSecondsLastUpdate.toIso8601String(),
        "savings_hbd_last_interest_payment":
            savingsHbdLastInterestPayment.toIso8601String(),
        "savings_withdraw_requests": savingsWithdrawRequests,
        "reward_hbd_balance": rewardHbdBalance,
        "reward_hive_balance": rewardHiveBalance,
        "reward_vesting_balance": rewardVestingBalance,
        "reward_vesting_hive": rewardVestingHive,
        "vesting_shares": vestingShares,
        "delegated_vesting_shares": delegatedVestingShares,
        "received_vesting_shares": receivedVestingShares,
        "vesting_withdraw_rate": vestingWithdrawRate,
        "post_voting_power": postVotingPower,
        "next_vesting_withdrawal": nextVestingWithdrawal.toIso8601String(),
        "withdrawn": withdrawn,
        "to_withdraw": toWithdraw,
        "withdraw_routes": withdrawRoutes,
        "pending_transfers": pendingTransfers,
        "curation_rewards": curationRewards,
        "posting_rewards": postingRewards,
        "proxied_vsf_votes": List<dynamic>.from(proxiedVsfVotes.map((x) => x)),
        "witnesses_voted_for": witnessesVotedFor,
        "last_post": lastPost.toIso8601String(),
        "last_root_post": lastRootPost.toIso8601String(),
        "last_vote_time": lastVoteTime.toIso8601String(),
        "post_bandwidth": postBandwidth,
        "pending_claimed_accounts": pendingClaimedAccounts,
        "governance_vote_expiration_ts":
            governanceVoteExpirationTs.toIso8601String(),
        "delayed_votes": List<dynamic>.from(delayedVotes.map((x) => x)),
        "open_recurrent_transfers": openRecurrentTransfers,
        "vesting_balance": vestingBalance,
        "reputation": reputation,
        "transfer_history": List<dynamic>.from(transferHistory.map((x) => x)),
        "market_history": List<dynamic>.from(marketHistory.map((x) => x)),
        "post_history": List<dynamic>.from(postHistory.map((x) => x)),
        "vote_history": List<dynamic>.from(voteHistory.map((x) => x)),
        "other_history": List<dynamic>.from(otherHistory.map((x) => x)),
        "witness_votes": List<dynamic>.from(witnessVotes.map((x) => x)),
        "tags_usage": List<dynamic>.from(tagsUsage.map((x) => x)),
        "guest_bloggers": List<dynamic>.from(guestBloggers.map((x) => x)),
      };
}

class Active {
  Active({
    required this.weightThreshold,
    required this.accountAuths,
    required this.keyAuths,
  });

  int weightThreshold;
  List<List<dynamic>> accountAuths;
  List<List<dynamic>> keyAuths;

  factory Active.fromJson(Map<String, dynamic> json) => Active(
        weightThreshold: json["weight_threshold"],
        accountAuths: List<List<dynamic>>.from(json["account_auths"]
            .map((x) => List<dynamic>.from(x.map((x) => x)))),
        keyAuths: List<List<dynamic>>.from(
            json["key_auths"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "weight_threshold": weightThreshold,
        "account_auths": List<dynamic>.from(
            accountAuths.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "key_auths": List<dynamic>.from(
            keyAuths.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class Manabar {
  Manabar({
    required this.currentMana,
    required this.lastUpdateTime,
  });

  int currentMana;
  int lastUpdateTime;

  factory Manabar.fromJson(Map<String, dynamic> json) => Manabar(
        currentMana: json["current_mana"],
        lastUpdateTime: json["last_update_time"],
      );

  Map<String, dynamic> toJson() => {
        "current_mana": currentMana,
        "last_update_time": lastUpdateTime,
      };
}

class UserMetadata {
  UserMetadata({
    required this.beneficiaries,
    required this.profile,
  });

  List<Beneficiary> beneficiaries;
  Profile profile;

  factory UserMetadata.fromJson(Map<String, dynamic> json) => UserMetadata(
        beneficiaries: List<Beneficiary>.from(
            json["beneficiaries"].map((x) => Beneficiary.fromJson(x))),
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "beneficiaries":
            List<dynamic>.from(beneficiaries.map((x) => x.toJson())),
        "profile": profile.toJson(),
      };
}

class Beneficiary {
  Beneficiary({
    required this.name,
    required this.weight,
    required this.label,
  });

  String name;
  int weight;
  String label;

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
        name: json["name"],
        weight: json["weight"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "weight": weight,
        "label": label,
      };
}

class Profile {
  Profile({
    required this.isPublic,
    required this.redirectUris,
    required this.type,
    required this.name,
    required this.profileImage,
    required this.coverImage,
    required this.website,
    required this.version,
    required this.about,
    required this.creator,
  });

  bool isPublic;
  List<String> redirectUris;
  String type;
  String name;
  String profileImage;
  String coverImage;
  String website;
  int version;
  String about;
  String creator;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        isPublic: json["is_public"],
        redirectUris: List<String>.from(json["redirect_uris"].map((x) => x)),
        type: json["type"],
        name: json["name"],
        profileImage: json["profile_image"],
        coverImage: json["cover_image"],
        website: json["website"],
        version: json["version"],
        about: json["about"],
        creator: json["creator"],
      );

  Map<String, dynamic> toJson() => {
        "is_public": isPublic,
        "redirect_uris": List<dynamic>.from(redirectUris.map((x) => x)),
        "type": type,
        "name": name,
        "profile_image": profileImage,
        "cover_image": coverImage,
        "website": website,
        "version": version,
        "about": about,
        "creator": creator,
      };
}
