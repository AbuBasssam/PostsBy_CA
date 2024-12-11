import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/INetworkInfo.dart';



class NetworkInfo implements INetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfo({required this.connectionChecker});
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
 
}