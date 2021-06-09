//+------------------------------------------------------------------+
//|                                                 CloseAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

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

            if(PositionType(positionTicket) == ORDER_TYPE_BUY && sglTrendBuffer[barShift] < InpMinTrendStrength * -1) {
               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_POSITION_PROFIT + IntegerToString(triggerTicket));
            }
            if(PositionType(positionTicket) == ORDER_TYPE_SELL && sglTrendBuffer[barShift] > InpMinTrendStrength) {
               triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
               Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_POSITION_PROFIT + IntegerToString(triggerTicket));
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
void closeH1OnSameTrend() {

   long     positionTicket = 0;
   long     triggerTicket = 0;
   int      barShift = 0;

   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
      positionTicket = positionTickets[positionTicketId];

      if(positionTicket > 0) {
         if(positionIsOpenState(positionTicket) == true && PositionProfit(positionTicket) < 0) {
             if(PositionType(positionTicket) == ORDER_TYPE_BUY && sglTrendBuffer[barShift] < InpMinTrendStrength) {
                triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
                Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_H2_OPOSITE_TREND + IntegerToString(triggerTicket));
             }
             if(PositionType(positionTicket) == ORDER_TYPE_SELL && sglTrendBuffer[barShift] < InpMinTrendStrength *-1) {
                triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
                Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_H2_OPOSITE_TREND + IntegerToString(triggerTicket));
             }
         }
      }
   }
}
//+------------------------------------------------------------------+
void closeOnRotationArea() {

   long     positionTicket = 0;
   long     triggerTicket = 0;
   int      barShift = 0;

   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
      positionTicket = positionTickets[positionTicketId];

      if(positionTicket > 0) {
         if(positionIsOpenState(positionTicket) == true && PositionProfit(positionTicket) < 0) {
             if(sglTrendBuffer[barShift] == ROTATION_AREA) {
                triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
                Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_H2_OPOSITE_TREND + IntegerToString(triggerTicket));
             }
//             if(PositionType(positionTicket) == ORDER_TYPE_SELL && sglTrendBuffer[barShift] > InpMinTrendStrength) {
//
//                Trade.Close(positionTicket, PositionVolume(positionTicket), CLOSED_BY_H2_OPOSITE_TREND + IntegerToString(triggerTicket));
//             }
         }
      }
   }
}