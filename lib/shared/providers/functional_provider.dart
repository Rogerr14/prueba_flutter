




import 'package:flutter/material.dart';
import 'package:prueba_app/shared/widget/alert/alerts_template.dart';

class FunctionalProvider extends ChangeNotifier{
  
  List<Widget> alerts = [];
  List<Widget> alertLoading = [];

  List<GlobalKey> keysAlerts = [];
  List<bool> closeAlertBack = [];
  
  

  addPage({required GlobalKey key, required Widget content}) {
    alerts.add(content);
    notifyListeners();
  }


  dismissAlert({required GlobalKey key}) {
    alerts.removeWhere((alert) => key == alert.key);
    keysAlerts.removeWhere((keysAlerts) => key == keysAlerts);
    closeAlertBack.clear();
    notifyListeners();
  }

  clearAllAlert() {
    alerts = [];
    notifyListeners();
  }

   showAlert({required GlobalKey key, required Widget content, bool closeAlert = false, bool animation = true, double padding = 20, bool? backButtonCloseAlert = true}) {
    final newAlert = Container(
      key: key,
      color: Colors.transparent,
      child: AlertTemplate(content: content, keyToClose: key, dismissAlert: closeAlert, animation: animation, padding: padding));
    alerts.add(newAlert);
    keysAlerts.add(key);
    closeAlertBack.add(backButtonCloseAlert!);
    notifyListeners();
  }

  showAlertLoading({required GlobalKey key, required Widget content, bool closeAlert = false, bool animation = true}) {
    final newAlert = Container(
    key: key,
    color: Colors.transparent,
    child: AlertTemplate(content: content, keyToClose: key, dismissAlert: closeAlert, animation: animation));
    alertLoading.add(newAlert);
    alerts.add(newAlert);
    notifyListeners();
  }

  dismissAlertLoading({required GlobalKey key}) {
    alertLoading.removeWhere((alert) => key == alert.key);
    alerts.removeWhere((alert) => key == alert.key);
    notifyListeners();
  }
  

}