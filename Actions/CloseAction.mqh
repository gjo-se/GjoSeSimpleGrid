//+------------------------------------------------------------------+
//|                                                 CloseAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  closeActions() {
//   closePositionGroupInProfit();
   closeOnLine("closeOnLine");

   alertOnLine();

   //closePositionInLoss();
   //closePositionInProfit();
   //closeHedgeOnOpositeTrend();
   //closeH1OnSameTrend();
   //closeAgainMonsterMove();

   // TODO: neu bearbeiten
   //closeOnRotationArea();
   //closeOnLocalHighestHigh();
   //closeOnSGLMaxDynamic();
   //closeOnSGLOpositeTrend();
   // closeOnTrendline();
}

void closeOnLine(const string pComment) {

   // TODO:
   // - CloseFunktionalität auskommentiert
   // - auf RiskLine erweitern
   double hLineLevel = getHlineLevelByText(CLOSE_ON_TOUCH_LINE);
   double trendLineLevel = getTrendlineLevelByText(CLOSE_ON_TOUCH_LINE);

   long     positionTicket = 0;
   long     triggerTicket = 0;
   int      barShift = 0;

   if(
      hLineLevel != EMPTY_VALUE
      && hLineLevel != 0
      && trendLineLevel != EMPTY_VALUE
      && trendLineLevel != 0
   ) {

      for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
         positionTicket = positionTickets[positionTicketId];

         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
         ) {
            if(
               positionIsOpenState(positionTicket) == true
            ) {

               //if(PositionType(positionTicket) == ORDER_TYPE_BUY && trend == DOWN_TREND) {
               //   triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
               //   Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_POSITION_PROFIT + IntegerToString(triggerTicket));
               //}
               //if(PositionType(positionTicket) == ORDER_TYPE_SELL && Bid() > MathMin(hLineLevel, trendLineLevel)) {
               //   triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
               //   Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_HLINE + IntegerToString(triggerTicket));
               //}
            }
         }
      }
   }
}

void alertOnLine() {

   double hLineLevel = getHlineLevelByText(ALERT_ON_TOUCH_LINE);
   double trendLineLevel = getTrendlineLevelByText(ALERT_ON_TOUCH_LINE);
   string alertMessage;

   // HLINE from Below
   if(lastPrice > 0 && lastPrice < hLineLevel && Bid() > hLineLevel) {
      alertMessage = Symbol() + ": Bid > HLINE " + DoubleToString(Bid());
      if(alert == true) {
         Alert(alertMessage);
         SendNotification(alertMessage);
         alert = false;
      }
   }
   // HLINE from Above
   if(lastPrice > 0 && lastPrice > hLineLevel && Bid() < hLineLevel) {
      alertMessage = Symbol() + ": Bid < HLINE " + DoubleToString(Bid());
      if(alert == true) {
         Alert(alertMessage);
         SendNotification(alertMessage);
         alert = false;
      }
   }

   // TRENDLINE from Below
   if(lastPrice > 0 && lastPrice < trendLineLevel && Bid() > trendLineLevel) {
      alertMessage = Symbol() + ": Bid > TRENDLINE " + DoubleToString(Bid());
      if(alert == true) {
         Alert(alertMessage);
         alert = false;
      }
   }
   // TRENDLINE from Above
   if(lastPrice > 0 && lastPrice > trendLineLevel && Bid() < trendLineLevel) {
      alertMessage = Symbol() + ": Bid < TRENDLINE " + DoubleToString(Bid());
      if(alert == true) {
         Alert(alertMessage);
         alert = false;
      }
   }

   lastPrice = Bid();

}

double getHlineLevelByText(const string pLineText) {

   double hLineLevel = EMPTY_VALUE;

   string objname;
   for(int i = ObjectsTotal(0, 0, -1) - 1; i >= 0; i--) {
      objname = ObjectName(0, i);
      if(ObjectGetInteger(ChartID(), objname, OBJPROP_TYPE) == OBJ_HLINE && ObjectGetString(ChartID(), objname, OBJPROP_TEXT) == pLineText) {
         hLineLevel = ObjectGetDouble(ChartID(), objname, OBJPROP_PRICE);
      }
   }
   if(hLineLevel != EMPTY_VALUE) {
      alert = true;
   } else {
      if(alert == true) Alert("Hline setzen - " + Symbol() + ": " + pLineText);
      alert = false;
   }

   return hLineLevel;

}

double getTrendlineLevelByText(const string pLineText) {

   double trendLineLevel = EMPTY_VALUE;

   string objname;
   for(int i = ObjectsTotal(0, 0, -1) - 1; i >= 0; i--) {
      objname = ObjectName(0, i);

      if(
         ObjectGetInteger(ChartID(), objname, OBJPROP_TYPE) == OBJ_TREND
         && ObjectGetString(ChartID(), objname, OBJPROP_TEXT) == pLineText
      ) {
         trendLineLevel = ObjectGetValueByTime(ChartID(), objname, iTime(Symbol(), PERIOD_CURRENT, 0), 0);
      }
   }
   if(trendLineLevel != EMPTY_VALUE) {
      alert = true;
   } else {
      if(alert == true) Alert("Trendline setzen - " + Symbol() + ": " + pLineText);
      alert = false;
   }

   return trendLineLevel;

}

void closeAllPositions(string pComment = "") {

   long positionTicket = 0;

   for(int positionTicketIndex = 0; positionTicketIndex < ArraySize(positionTickets); positionTicketIndex++) {
      positionTicket = positionTickets[positionTicketIndex];
      string comment = pComment + "_" + IntegerToString(positionTicket);
      if(Trade.Close(positionTicket, PositionVolume(positionTicket), comment) == false) Print(IntegerToString(positionTicket) + " not Closed" );
   }
}

void setDealGroupHistoryProfit() {

   long     closeTicket = 0;
   long     openTicket = 0;
   long     triggerTicket = 0;
   int   currentDealGroupProfit = 0;

   if (HistorySelect(lastHistoryCall, TimeCurrent())) {
      for (int historyDealId = 0; historyDealId < HistoryDealsTotal(); historyDealId++) {
         closeTicket = StringToInteger(IntegerToString(HistoryDealGetTicket(historyDealId)));
         openTicket = HistoryDealGetInteger(closeTicket, DEAL_POSITION_ID);
         triggerTicket = getTriggerTicketByPositionTicket(openTicket);

         if(triggerTicket != 0) {
            Deal.Ticket(closeTicket);
            if (Deal.Entry() == DEAL_ENTRY_OUT) {
               currentDealGroupProfit = getCurrentDealGroupProfitByTriggerTicket(triggerTicket);
               currentDealGroupProfit += (int)Deal.Profit() + (int)Deal.Commission();
               setCurrentDealGroupProfit(triggerTicket, currentDealGroupProfit);
            }
         }
      }
   }

}

int getDealGroupCurrentProfit(int pDealGroupId, bool nettoProfit = true) {

   long  ticket = 0;
   int   currentPositionProfitBrutto = 0;
   int   currentPositionProfitNetto = 0;
   int   groupCurrentProfit = 0;

   for(int ticketId = 0; ticketId < ArrayRange(dealGroups, 1); ticketId++) {
      ticket = dealGroups[pDealGroupId][ticketId];

      if(ticket != 0) {
         if(positionIsOpenState(ticket) == true) {
            currentPositionProfitBrutto += (int)PositionProfit(ticket);
            // der ist so noch falsch!
            currentPositionProfitNetto += (int)PositionProfit(ticket);
         }
      }
   }

   if(nettoProfit == true) {
      groupCurrentProfit = currentPositionProfitNetto;
   } else {
      groupCurrentProfit = currentPositionProfitBrutto;
   }

   return (groupCurrentProfit);
}

void closePositionGroupInProfit() {

   int   dealGroupCurrentProfit = 0;
   int   dealGroupHistoryProfit = 0;
   long    ticket = 0;
   long    triggerTicket = 0;

   setDealGroupHistoryProfit();

   for(int dealGroupId = 0; dealGroupId < ArrayRange(dealGroups, 0); dealGroupId++) {
      triggerTicket = dealGroups[dealGroupId][DEALGROUP_ID_TRIGGER_TICKET];

      dealGroupCurrentProfit = getDealGroupCurrentProfit(dealGroupId);
      dealGroupHistoryProfit = getCurrentDealGroupProfitByTriggerTicket(triggerTicket);

      if((dealGroupCurrentProfit + dealGroupHistoryProfit) >= getDestinationProfit()) {
         for(int ticketId = 0; ticketId < ArrayRange(dealGroups, 1); ticketId++) {
            ticket = dealGroups[dealGroupId][ticketId];

            if(ticket > 0) {
               Trade.Close(ticket, PositionVolume(ticket), CLOSED_BY_GROUP_PROFIT + IntegerToString(triggerTicket));
            }
         }
      }
   }

   lastHistoryCall = TimeCurrent();
}

double getDestinationProfit() {

   double volume  = getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);
   double destinationProfit = InpTakeProfit * volume;

   return (destinationProfit);

}
//+------------------------------------------------------------------+

void closePositionInProfit() {

   long     positionTicket = 0;
   long     triggerTicket = 0;
   int      barShift = 0;

   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
      positionTicket = positionTickets[positionTicketId];

      if(positionTicket > 0) {
         if(positionIsOpenState(positionTicket) == true && PositionProfit(positionTicket) > 0) {

            if(PositionType(positionTicket) == ORDER_TYPE_BUY && trend == DOWN_TREND) {
               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_POSITION_PROFIT + IntegerToString(triggerTicket));
            }
            if(PositionType(positionTicket) == ORDER_TYPE_SELL && trend == UP_TREND) {
               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_POSITION_PROFIT + IntegerToString(triggerTicket));
            }
         }
      }
   }
}

//void closePositionInLoss() {
//
//   long     positionTicket = 0;
//   long     triggerTicket = 0;
//   int      barShift = 0;
//
//   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//      positionTicket = positionTickets[positionTicketId];
//
//      if(positionTicket > 0) {
//         if(positionIsOpenState(positionTicket) == true && PositionProfit(positionTicket) < 0) {
//
//            if(PositionType(positionTicket) == ORDER_TYPE_BUY && trend == ROTATION_AREA) {
//               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
//               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_POSITION_LOSS + IntegerToString(triggerTicket));
//            }
//            if(PositionType(positionTicket) == ORDER_TYPE_SELL && sglTrendBuffer[barShift] == InpExitValue) {
//               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
//               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_POSITION_LOSS + IntegerToString(triggerTicket));
//            }
//         }
//      }
//   }
//}
//+------------------------------------------------------------------+
void closeHedgeOnSameTrend() {

   long     positionTicket = 0;
   long     triggerTicket = 0;
   int      barShift = 0;

   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
      positionTicket = positionTickets[positionTicketId];

      if(positionTicket > 0) {
         if(positionIsOpenState(positionTicket) == true && PositionProfit(positionTicket) < 0) {
            if(PositionType(positionTicket) == ORDER_TYPE_BUY && trend == UP_TREND) {
               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_H2_OPOSITE_TREND + IntegerToString(triggerTicket));
            }
            if(PositionType(positionTicket) == ORDER_TYPE_SELL && trend == DOWN_TREND) {
               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_H2_OPOSITE_TREND + IntegerToString(triggerTicket));
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
//void closeOnRotationArea() {
//
//   long     positionTicket = 0;
//   long     triggerTicket = 0;
//   int      barShift = 0;
//
//   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//      positionTicket = positionTickets[positionTicketId];
//
//      if(positionTicket > 0) {
//         if(PositionType(positionTicket) == ORDER_TYPE_SELL) {
//             if(sglDynamicFastSlowBuffer[barShift] > sglDynamicFastSlowSignalBuffer[barShift]) {
//                triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
//                Trade.Close(positionTicket, PositionVolume(positionTicket), "ON_ROTATION" + IntegerToString(triggerTicket));
//             }
////             if(PositionType(positionTicket) == ORDER_TYPE_SELL && sglTrendBuffer[barShift] > InpMinTrendStrength) {
////
////                Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_H2_OPOSITE_TREND + IntegerToString(triggerTicket));
////             }
//         }
//      }
//   }
//}

void closeOnLocalHighestHigh() {

   long     positionTicket = 0;
   long     triggerTicket = 0;
   int      positionBarIndex = 0;
   int      candleHistory = 3;
   int      highestBarIndex = 0;
   double   highestHighValue = 0;

   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
      positionTicket = positionTickets[positionTicketId];

      if(positionTicket > 0) {
         if(positionIsOpenState(positionTicket) == true) {
            if(PositionType(positionTicket) == ORDER_TYPE_SELL) {
               positionBarIndex = iBarShift(Symbol(), PERIOD_CURRENT, PositionOpenTime(positionTicket), true);
               highestBarIndex = iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, candleHistory, positionBarIndex);

               if(highestBarIndex != -1) highestHighValue = iHigh(Symbol(), Period(), highestBarIndex);

               if(highestHighValue > 0 && Bid() > highestHighValue) {
                  triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
                  Trade.Close(positionTicket, PositionVolume(positionTicket), "HIGHEST_HIGH_" +  IntegerToString(triggerTicket));
               }
            }
         }
      }
   }
}
//void closeOnSGLMaxDynamic() {
//
//   long     positionTicket = 0;
//   long     triggerTicket = 0;
//   int      barShift = 0;
//
//   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//      positionTicket = positionTickets[positionTicketId];
//
//      if(positionTicket > 0) {
//         if(positionIsOpenState(positionTicket) == true) {
//            if(PositionType(positionTicket) == ORDER_TYPE_SELL && sglDynamicFastSlowBuffer[barShift] < InpIND_GjoSeDynamic_SGL_MaxDynamic * -1) {
//               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
//               Trade.Close(positionTicket, PositionVolume(positionTicket), "MAX_TREND_" +  IntegerToString(triggerTicket));
//            }
//         }
//      }
//   }
//}

//void closeOnSGLOpositeTrend() {
//
//   long     positionTicket = 0;
//   long     triggerTicket = 0;
//   int      barShift = 0;
//
//   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//      positionTicket = positionTickets[positionTicketId];
//
//      if(positionTicket > 0) {
//         if(positionIsOpenState(positionTicket) == true) {
//            if(PositionType(positionTicket) == ORDER_TYPE_SELL && sglDynamicFastSlowColorBuffer[barShift] == DYNAMIC_UP_TREND_LOW) {
//               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
//               Trade.Close(positionTicket, PositionVolume(positionTicket), "OP_TREND_" +  IntegerToString(triggerTicket));
//            }
//         }
//      }
//   }
//}




//void closeAgainMonsterMove() {
//
//   long     positionTicket = 0;
//   long     triggerTicket = 0;
//   int      barShift = 0;
//
//   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//      positionTicket = positionTickets[positionTicketId];
//
//      if(positionTicket > 0) {
////         if(positionIsHedgeState(positionTicket) == true && positionIsOpenState(positionTicket) == true) {
//
////            if(PositionType(positionTicket) == ORDER_TYPE_BUY && dynamicBuffer[barShift] >) {
////               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
////               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_H1_OPTREND + IntegerToString(triggerTicket));
////            }
//            if(PositionType(positionTicket) == ORDER_TYPE_SELL && buyDynamicBuffer[barShift] > 100) {
//               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
//               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_H1_OPTREND + IntegerToString(triggerTicket));
//            }
////         }
//      }
//   }
//}

void closeHedgeOnOpositeTrend() {

   long     positionTicket = 0;
   long     triggerTicket = 0;
   int      barShift = 0;

   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
      positionTicket = positionTickets[positionTicketId];

      if(positionTicket > 0) {
         if(positionIsHedgeState(positionTicket) == true && positionIsOpenState(positionTicket) == true) {

            if(PositionType(positionTicket) == ORDER_TYPE_BUY && trend == DOWN_TREND) {
               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_H1_OPTREND + IntegerToString(triggerTicket));
            }
            if(PositionType(positionTicket) == ORDER_TYPE_SELL && trend == UP_TREND) {
               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_H1_OPTREND + IntegerToString(triggerTicket));
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
