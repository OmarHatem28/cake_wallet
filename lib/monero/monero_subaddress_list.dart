import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:cw_monero/subaddress_list.dart' as subaddress_list;
import 'package:cake_wallet/monero/subaddress.dart';

part 'monero_subaddress_list.g.dart';

class MoneroSubaddressList = MoneroSubaddressListBase
    with _$MoneroSubaddressList;

abstract class MoneroSubaddressListBase with Store {
  MoneroSubaddressListBase() {
    _isRefreshing = false;
    _isUpdating = false;
    subaddresses = ObservableList<Subaddress>();
  }

  @observable
  ObservableList<Subaddress> subaddresses;

  bool _isRefreshing;
  bool _isUpdating;

  void update({int accountIndex}) {
    if (_isUpdating) {
      return;
    }

    try {
      _isUpdating = true;
      refresh(accountIndex: accountIndex);
      subaddresses.clear();
      subaddresses.addAll(getAll());
      _isUpdating = false;
    } catch (e) {
      _isUpdating = false;
      rethrow;
    }
  }

  List<Subaddress> getAll() {
    final subaddresses = subaddress_list.getAllSubaddresses();
    if (subaddresses.length > 1) {
      // final primary = subaddresses.first;
      // final last = subaddresses.last;
      // subaddresses[subaddresses.length - 1] = primary;
      // subaddresses[0] = last;

      // for (var i = subaddresses.length - 1; i >= 0; i--) {
      //   final pre = subaddresses[i];
      //   final post = subaddresses[subaddresses.length - i];
      //   subaddresses[subaddresses.length - i] = pre;
      //   subaddresses[i] = post;
      // }
    }

    return subaddresses
        .map((subaddressRow) => Subaddress.fromRow(subaddressRow))
        .toList();
  }

  Future addSubaddress({int accountIndex, String label}) async {
    await subaddress_list.addSubaddress(
        accountIndex: accountIndex, label: label);
    update(accountIndex: accountIndex);
  }

  Future setLabelSubaddress(
      {int accountIndex, int addressIndex, String label}) async {
    await subaddress_list.setLabelForSubaddress(
        accountIndex: accountIndex, addressIndex: addressIndex, label: label);
    update(accountIndex: accountIndex);
  }

  void refresh({int accountIndex}) {
    if (_isRefreshing) {
      return;
    }

    try {
      _isRefreshing = true;
      subaddress_list.refreshSubaddresses(accountIndex: accountIndex);
      _isRefreshing = false;
    } on PlatformException catch (e) {
      _isRefreshing = false;
      print(e);
      rethrow;
    }
  }
}
