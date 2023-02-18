import 'dart:ffi';

import 'package:ffi/ffi.dart';

typedef get_bycid_func = Pointer<Utf8> Function(Pointer<Utf8> cidParam);
typedef GetByCid = Pointer<Utf8> Function(Pointer<Utf8> cidParam);
final dylib = DynamicLibrary.open('ipfslite.so');

final GetByCid getByCid =
    dylib.lookup<NativeFunction<get_bycid_func>>('GetByCid').asFunction();

String getIPFSData(cidParam) {
  final cid = StringUtf8Pointer(cidParam).toNativeUtf8();
  final data = Utf8Pointer(getByCid(cid)).toDartString();
  return data;
}
