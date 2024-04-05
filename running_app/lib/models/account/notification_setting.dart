class NotificationSetting {
  final String? id;
  final bool? finishedWorkout;
  final bool? comment;
  final bool? like;
  final bool? mentionsOnActivities;
  final bool? respondToComments;
  final bool? newFollower;
  final bool? followingActivity;
  final bool? requestToFollow;
  final bool? approvedFollowRequest;
  final bool? pendingJoinRequests;
  final bool? invitedToClub;

  NotificationSetting({
    this.id,
    required this.finishedWorkout,
    required this.comment,
    required this.like,
    required this.mentionsOnActivities,
    required this.respondToComments,
    required this.newFollower,
    required this.followingActivity,
    required this.requestToFollow,
    required this.approvedFollowRequest,
    required this.pendingJoinRequests,
    required this.invitedToClub,
  });

  NotificationSetting.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        finishedWorkout = json['finished_workout'],
        comment = json['comment'],
        like = json['like'],
        mentionsOnActivities = json['mentions_on_activities'],
        respondToComments = json['respond_to_comments'],
        newFollower = json['new_follower'],
        followingActivity = json['following_activity'],
        requestToFollow = json['request_to_follow'],
        approvedFollowRequest = json['approved_follow_request'],
        pendingJoinRequests = json['pending_join_requests'],
        invitedToClub = json['invited_to_club'];


  Map<String, dynamic> toJson() {
    return {
      'finished_workout': finishedWorkout,
      'comment': comment,
      'like': like,
      'mentions_on_activities': mentionsOnActivities,
      'respond_to_comments': respondToComments,
      'new_follower': newFollower,
      'following_activity': followingActivity,
      'request_to_follow': requestToFollow,
      'approved_follow_request': approvedFollowRequest,
      'pending_join_requests': pendingJoinRequests,
      'invited_to_club': invitedToClub,
    };
  }

  @override
  String toString() {
    return '${toJson()}';
  }
}