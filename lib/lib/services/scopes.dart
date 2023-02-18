/// Represents a SteemConnect API scope
class SteemApiScope {
  /// The desired access scope.
  final String scope;

  /// A scope allowing an application to verify a Steem identity
  static const SteemApiScope login = const SteemApiScope('login');

  /// A scope allowing an application to retrieve a long-lived token
  static const SteemApiScope offline = const SteemApiScope('offline');

  /// A scope allowing an application to upvote, downvote or unvote a post or comment
  static const SteemApiScope vote = const SteemApiScope('vote');

  /// A scope allowing an application to publish or edit a post or a comment
  static const SteemApiScope comment = const SteemApiScope('comment');

  /// A scope allowing an application to delete a post or a comment
  static const SteemApiScope commentDelete = const SteemApiScope(
      'comment_delete');

  /// A scope allowing an application to add options for a post or comment
  static const SteemApiScope commentOptions = const SteemApiScope(
      'comment_options');

  /// A scope allowing an application to Follow, unfollow, ignore, reblog (any custom_json operation)
  static const SteemApiScope customJson = const SteemApiScope('custom_json');

  /// A scope allowing an application to claim reward for user
  static const SteemApiScope claimRewardBalance = const SteemApiScope(
      'claim_reward_balance');

  /// A union of all scopes; use this for a client that needs full access
  static const List<SteemApiScope> all = const [
    login,
    offline,
    vote,
    comment,
    commentDelete,
    commentOptions,
    customJson,
    claimRewardBalance
  ];

  /// A scope optimized for social applications using Steem
  static const List<SteemApiScope> defaultScope = const [
    login,
    offline,
    vote,
    comment,
    commentDelete,
    commentOptions,
    customJson
  ];

  const SteemApiScope(this.scope);
}