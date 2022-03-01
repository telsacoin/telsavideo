part of 'ipfs_bloc.dart';

@immutable
abstract class IpfsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialIpfsState extends IpfsState {
  @override
  String toString() => 'InitialIpfsState';
}

class PeerStarted extends IpfsState {
  @override
  String toString() => 'PeerStartedIpfsState';
}

class PeerNotStarted extends IpfsState {
  @override
  String toString() => 'PeerNotStartedIpfsState';
}

class FetchInProgress extends IpfsState {
  @override
  String toString() => 'FetchInProgressState';
}

class RetrievingData extends IpfsState {
  @override
  String toString() => 'RetrievingDataState';
}

class FetchFailed extends IpfsState {
  @override
  String toString() => 'FetchFailedState';
}

class Fetched extends IpfsState {
  final String data;
  Fetched(this.data);

  @override
  String toString() => 'FetchedState';
}

class FirstLaunch extends IpfsState {
  @override
  String toString() => 'FirstLaunchState';
}