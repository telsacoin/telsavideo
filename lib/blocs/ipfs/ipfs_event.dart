part of 'ipfs_bloc.dart';

@immutable
abstract class IpfsEvent extends Equatable {
  List<Object> get props => [];
}

class AppLaunched extends IpfsEvent {
  @override
  String toString() => 'AppLaunched';
}

class StartPeer extends IpfsEvent {
  StartPeer();
}

class StopPeer extends IpfsEvent {
  StopPeer();
}

class FetchData extends IpfsEvent {
  final String networkCid;

  FetchData(this.networkCid);
}

class FetchFromGateway extends IpfsEvent {
  final String networkCid;

  FetchFromGateway(this.networkCid);
}

class RetrieveData extends IpfsEvent {

  RetrieveData();
}