import 'dart:io';

Future<String> getWiFiIPAddress() async {
  List<NetworkInterface> interfaces = await NetworkInterface.list();
  for (var interface in interfaces) {
    if (interface.name.toLowerCase().contains('wifi') ||
        interface.name.toLowerCase().contains('wlan')) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4) {
          print('IPv4 Address: ${addr.address}');
          return addr.address;
        }
      }
    }
  }
  return "";
}
