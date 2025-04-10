import 'package:flutte_scanner_empty/data/models/ticket_model.dart';
import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier{
  TicketModel _mTicket = TicketModel();
  TicketModel get mTicket => _mTicket;
  set mTicket (TicketModel mTicket){
    _mTicket = mTicket;
    notifyListeners();
  } 
}