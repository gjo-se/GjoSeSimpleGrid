//+------------------------------------------------------------------+
//|                                               OpenBuyActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void openBuyOrderAction() {

   double volume  = getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   double stopLoss = BuyStopLoss(Symbol(), InpStopLoss, Ask());
   if(stopLoss > 0) AdjustAboveStopLevel(Symbol(), stopLoss);

   double takeProfit = BuyTakeProfit(Symbol(), InpTakeProfit, Ask());
   if(takeProfit > 0) AdjustAboveStopLevel(Symbol(), takeProfit);

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Buy(Symbol(), volume, stopLoss, takeProfit, InpComment);

   cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);

   addTriggerTicketInPositionGroupsAction();
   addTriggerTicketInDealGroupsAndDealGroupProfitAction();
   initializeNextBuyLevelAction();

}

//void openReEntryTriggerBuyOrderAction(long pTriggerTicket) {
//
//   double volume  = getPositionVolumeByPositionTicket(pTriggerTicket);
//   double stopLoss = 0;
//   double takeProfit = 0;
//   string comment = InpTriggerCommentReEntryTriggertBy + IntegerToString(pTriggerTicket);
//
//   Trade.FillType(SYMBOL_FILLING_FOK);
//   Trade.Buy(Symbol(), volume, stopLoss, takeProfit, comment);
//
//   cleanPositionTicketsArrayAction(positionTickets);
//
//   addTriggerTicketReEnInPositionGroupsAction(pTriggerTicket);
//   addTicketInDealGroupsAction(pTriggerTicket, InpTriggerCommentReEntryTriggertBy);
//}

//void openHedgeBuyOrderAction(long pTriggerTicket) {
//
//   double volume  = NormalizeDouble(getPositionVolumeByPositionTicket(pTriggerTicket) * InpHedgeMulti, 2);
//   double stopLoss = 0;
//   double takeProfit = 0;
//   string comment = InpHedgeCommentTriggertBy + IntegerToString(pTriggerTicket);
//
//   Trade.FillType(SYMBOL_FILLING_FOK);
//   Trade.Buy(Symbol(), volume, stopLoss, takeProfit, comment);
//
//   cleanPositionTicketsArrayAction();
//
//   addHedgeTicketInPositionGroupsAction(pTriggerTicket);
//   addTicketInDealGroupsAction(pTriggerTicket, InpHedgeCommentTriggertBy);
//}
//
//void openReEntryHedgeBuyOrderAction(long pTriggerTicket) {
//
//   double volume  = NormalizeDouble(getPositionVolumeByPositionTicket(pTriggerTicket) * InpHedgeMulti, 2);
//   double stopLoss = 0;
//   double takeProfit = 0;
//   string comment = InpHedgeCommentReEntryTriggertBy + IntegerToString(pTriggerTicket);
//
//   Trade.FillType(SYMBOL_FILLING_FOK);
//   Trade.Buy(Symbol(), volume, stopLoss, takeProfit, comment);
//
//   cleanPositionTicketsArrayAction();
//
//   addHedgeTicketInPositionGroupsAction(pTriggerTicket);
//   addTicketInDealGroupsAction(pTriggerTicket, InpHedgeCommentReEntryTriggertBy);
//}
//
//
//void openHedgeHedgeBuyOrderAction(long pHedgeTicket) {
//
//   int positionGroupId = 0;
//   long triggerTicket = 0;
//   double volume = 0;
//
//   positionGroupId = getPositionGroupIdByPositionTicket(pHedgeTicket);
//
//   if(positionGroupId != NOT_FOUND) {
//
//      triggerTicket = positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET];
//
//      if(getPositionVolumeByPositionTicket(triggerTicket) > 0) {
//         volume  = NormalizeDouble(getPositionVolumeByPositionTicket(triggerTicket) * InpHedgeHedgeMulti, 2);
//      } else {
//         volume  = NormalizeDouble(getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume) * InpHedgeHedgeMulti, 2);
//      }
//
//      double stopLoss = 0;
//      double takeProfit = 0;
//      string comment = InpHedgeHedgeCommentTriggertBy + IntegerToString(triggerTicket);
//
//      Trade.FillType(SYMBOL_FILLING_FOK);
//      Trade.Buy(Symbol(), volume, stopLoss, takeProfit, comment);
//
//      cleanPositionTicketsArrayAction();
//
//      addHedgeHedgeTicketInPositionGroupsAction(triggerTicket);
//      addTicketInDealGroupsAction(triggerTicket, InpHedgeHedgeCommentTriggertBy);
//
//   }
//}
//
//
//void openReEntryHedgeHedgeBuyOrderAction(long pTriggerTicket) {
//
//   double volume  = NormalizeDouble(getPositionVolumeByPositionTicket(pTriggerTicket) * InpHedgeHedgeMulti, 2);
//   double stopLoss = 0;
//   double takeProfit = 0;
//   string comment = InpHedgeHedgeCommentReEntryTriggertBy + IntegerToString(pTriggerTicket);
//
//   Trade.FillType(SYMBOL_FILLING_FOK);
//   Trade.Buy(Symbol(), volume, stopLoss, takeProfit, comment);
//
//   cleanPositionTicketsArrayAction();
//
//   addHedgeHedgeTicketInPositionGroupsAction(pTriggerTicket);
//   addTicketInDealGroupsAction(pTriggerTicket, InpHedgeHedgeCommentReEntryTriggertBy);
//}
//
//void openH3BuyOrderAction(long pH2Ticket) {
//
//   int positionGroupId = 0;
//   long triggerTicket = 0;
//
//
//   positionGroupId = getPositionGroupIdByPositionTicket(pH2Ticket);
//
//   if(positionGroupId != NOT_FOUND) {
//
//      triggerTicket = positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET];
//
//      double volume = NormalizeDouble(getPositionVolumeByPositionTicket(triggerTicket) * InpH3Multi, 2);
//      double stopLoss = 0;
//      double takeProfit = 0;
//      string comment = InpH3CommentTriggertBy + IntegerToString(triggerTicket);
//
//      Trade.FillType(SYMBOL_FILLING_FOK);
//      Trade.Buy(Symbol(), volume, stopLoss, takeProfit, comment);
//
//      cleanPositionTicketsArrayAction();
//
//      addH3TicketInPositionGroupsAction(triggerTicket);
//      addTicketInDealGroupsAction(triggerTicket, InpH3CommentTriggertBy);
//
//   }
//}
//
//void openReEntryH3BuyOrderAction(long pTriggerTicket) {
//
//   double volume  = NormalizeDouble(getPositionVolumeByPositionTicket(pTriggerTicket) * InpH3Multi, 2);
//   double stopLoss = 0;
//   double takeProfit = 0;
//   string comment = InpH3CommentReEntryTriggertBy + IntegerToString(pTriggerTicket);
//
//   Trade.FillType(SYMBOL_FILLING_FOK);
//   Trade.Buy(Symbol(), volume, stopLoss, takeProfit, comment);
//
//   cleanPositionTicketsArrayAction();
//
//   addH3TicketInPositionGroupsAction(pTriggerTicket);
//   addTicketInDealGroupsAction(pTriggerTicket, InpH3CommentReEntryTriggertBy);
//}
////+------------------------------------------------------------------+
