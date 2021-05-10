import 'package:flutter/cupertino.dart';
import 'package:taxi2/Models/address.dart';

class AppData extends ChangeNotifier{
    Address pickUpLocation;


    void updatePickUpLocationAddress(Address pickUpAddress)
    {
      pickUpLocation=pickUpAddress;
      notifyListeners();

    }
}