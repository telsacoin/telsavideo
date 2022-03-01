import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

part 'ipfs_event.dart';

part 'ipfs_state.dart';

class IpfsBloc extends Bloc<IpfsEvent, IpfsState> {
  IpfsBloc() : super(InitialIpfsState());
  static const platform = const MethodChannel('telsa.dtok/ipfs');

  @override
  Stream<IpfsState> mapEventToState(IpfsEvent event) async* {
    if (event is AppLaunched) {
      yield* mapAppLaunchedToState();
    }
    if (event is StartPeer) {
      yield* mapPeerStartToState();
    }
    if (event is FetchData) {
      yield* mapFetchDataToState(event.networkCid);
    }
    if (event is RetrieveData) {
      yield* mapRetrieveDataToState();
    }
    if (event is FetchFromGateway) {
      yield* mapFetchFromGatewayToState(event.networkCid);
    }
  }

  Stream<IpfsState> mapPeerStartToState() async* {
    try {
      final isStarted = await platform.invokeMethod('startPeer');
      if (isStarted) {
        yield PeerStarted();
      } else {
        yield PeerNotStarted();
      }
    } catch (_, stacktrace) {
      print(stacktrace);
      yield PeerNotStarted();
    }
  }

  Stream<IpfsState> mapRetrieveDataToState() async* {
    String result;
    result = await platform.invokeMethod('getData');
    print(result);
    // ignore: unnecessary_null_comparison
    if (result != null) {
      yield Fetched(result);
    } else {
      yield FetchFailed();
    }
  }

  Future<String> getFromgateway(networkCid) async {
    Dio dio = new Dio();
    final response = await dio.get("https://ipfs.io/ipfs/" + networkCid);
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Stream<IpfsState> mapFetchFromGatewayToState(String networkCid) async* {
    String result;
    yield FetchInProgress();
    result = await getFromgateway(networkCid);
    print(result);
    // ignore: unnecessary_null_comparison
    if (result != null) {
      yield Fetched(result);
    } else {
      yield FetchFailed();
    }
  }

  Stream<IpfsState> mapFetchDataToState(String networkCid) async* {
    try {
      await platform.invokeMethod('startfetchData', {"cid": networkCid});
      yield FetchInProgress();
    } catch (_, stacktrace) {
      print(stacktrace);
      yield FetchFailed();
    }
  }

  Stream<IpfsState> mapAppLaunchedToState() async* {
    try {
      yield PeerNotStarted();
    } catch (_, stacktrace) {
      print(stacktrace);
      yield PeerNotStarted();
    }
  }
}
