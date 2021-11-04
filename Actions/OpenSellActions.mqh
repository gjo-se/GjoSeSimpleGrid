//+------------------------------------------------------------------+
//|                                              OpenSellActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+

void openSellOrderAction() {

   double volume  = getVolumeByPositionRisk();

   if(volume > 0) {
      double stopLoss = SellStopLoss(Symbol(), InpStopLoss, Ask());
      if(stopLoss > 0) AdjustBelowStopLevel(Symbol(), stopLoss);

      //double takeProfit = 0;
      double takeProfit = SellTakeProfit(Symbol(), InpTakeProfit, Ask());
      if(takeProfit > 0) AdjustBelowStopLevel(Symbol(), takeProfit);

      Trade.FillType(SYMBOL_FILLING_FOK);
      Trade.Sell(Symbol(), volume, stopLoss, takeProfit, InpComment);

      cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);

      addTriggerTicketInPositionGroupsAction();
      addTriggerTicketInDealGroupsAndDealGroupProfitAction();
      initializeNextSellLevelAction();
   }
}

double getVolumeByPositionRisk() {

   double pipRisk = EMPTY_VALUE;
   double positionRisk = 0;
   double maxPositionRiskValue = 0;
   double volume = 0;
   double hLineLevel = 0;
   double trendLineLevel = 0;

   if(hLineLevel > 0 && trendLineLevel > 0) {
      hLineLevel = getHlineLevelByText(CLOSE_ON_TOUCH_LINE);
      trendLineLevel = getTrendlineLevelByText(CLOSE_ON_TOUCH_LINE);
      pipRisk = (MathMin(hLineLevel, trendLineLevel) - Bid()) / Point() / 10 ;
   }

    // Objects not exists in StrategyTester
   if(MQLInfoInteger(MQL_TESTER) == 1) {
      trendLineLevel = InpTrendLineStartValue - (InpTrendLineValueDiff / InpTrendLineH1Bars * iBarShift(Symbol(), PERIOD_H1, InpTrendLineStartDate) * Point());
      pipRisk = (trendLineLevel - Bid()) / Point() / 10 ;
   }

   if(pipRisk != EMPTY_VALUE) {
      maxPositionRiskValue = AccountInfoDouble(ACCOUNT_BALANCE) * InpMaxPositionRiskPercent / 100;
      positionRisk = pipRisk * getPipValueBySymbol(Symbol());
      volume = NormalizeDouble(maxPositionRiskValue / positionRisk, 2);
   }

   return volume;
}

double getPipValueBySymbol(string pPositionSymbol) {

   if(pPositionSymbol == "CHFJPY") return InpPipValueCHFJPY;
   if(pPositionSymbol == "EURJPY") return InpPipValueEURJPY;
   if(pPositionSymbol == "EURUSD") return InpPipValueEURUSD;
   if(pPositionSymbol == "GBPJPY") return InpPipValueGBPJPY;
   if(pPositionSymbol == "GBPUSD") return InpPipValueGBPUSD;
   if(pPositionSymbol == "XAUUSD") return InpPipValueXAUUSD;

   return 0;

}

//void openReEntryTriggerSellOrderAction(long pTriggerTicket) {
//
//   double volume  = getPositionVolumeByPositionTicket(pTriggerTicket);
//   double stopLoss = 0;
//   double takeProfit = 0;
//   string comment = InpTriggerCommentReEntryTriggertBy + IntegerToString(pTriggerTicket);
//
//   Trade.FillType(SYMBOL_FILLING_FOK);
//   Trade.Sell(Symbol(), volume, stopLoss, takeProfit, comment);
//
//   cleanPositionTicketsArrayAction(positionTickets);
//
//   addTriggerTicketReEnInPositionGroupsAction(pTriggerTicket);
//   addTicketInDealGroupsAction(pTriggerTicket, InpTriggerCommentReEntryTriggertBy);
//}

//void openHedgeSellOrderAction(long pTriggerTicket) {
//
//   double volume  = NormalizeDouble(getPositionVolumeByPositionTicket(pTriggerTicket) * InpHedgeMulti, 2);
//   double stopLoss = 0;
//   double takeProfit = 0;
//   string comment = InpHedgeCommentTriggertBy + IntegerToString(pTriggerTicket);
//
//   Trade.FillType(SYMBOL_FILLING_FOK);
//   Trade.Sell(Symbol(), volume, stopLoss, takeProfit, comment);
//
//   cleanPositionTicketsArrayAction();
//
//   addHedgeTicketInPositionGroupsAction(pTriggerTicket);
//   addTicketInDealGroupsAction(pTriggerTicket, InpHedgeCommentTriggertBy);
//}
//
//void openHedgeHedgeSellOrderAction(long pHedgeTicket) {
//
//   int positionGroupId = 0;
//   long triggerTicket = 0;
//   double volume = 0;
//
//   positionGroupId = getPositionGroupIdByPositionTicket(pHedgeTicket);
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
//      Trade.Sell(Symbol(), volume, stopLoss, takeProfit, comment);
//
//      cleanPositionTicketsArrayAction();
//
//      addHedgeHedgeTicketInPositionGroupsAction(triggerTicket);
//      addTicketInDealGroupsAction(triggerTicket, InpHedgeHedgeCommentTriggertBy);
//
//   }
//}
//
//void openReEntryHedgeSellOrderAction(long pTriggerTicket) {
//
//   double volume  = NormalizeDouble(getPositionVolumeByPositionTicket(pTriggerTicket) * InpHedgeMulti, 2);
//   double stopLoss = 0;
//   double takeProfit = 0;
//   string comment = InpHedgeCommentReEntryTriggertBy + IntegerToString(pTriggerTicket);
//
//   Trade.FillType(SYMBOL_FILLING_FOK);
//   Trade.Sell(Symbol(), volume, stopLoss, takeProfit, comment);
//
//   cleanPositionTicketsArrayAction();
//
//   addHedgeTicketInPositionGroupsAction(pTriggerTicket);
//   addTicketInDealGroupsAction(pTriggerTicket, InpHedgeCommentReEntryTriggertBy);
//}
//
////+------------------------------------------------------------------+
//
//
//void openReEntryHedgeHedgeSellOrderAction(long pTriggerTicket) {
//
//   double volume  = NormalizeDouble(getPositionVolumeByPositionTicket(pTriggerTicket) * InpHedgeHedgeMulti, 2);
//   double stopLoss = 0;
//   double takeProfit = 0;
//   string comment = InpHedgeHedgeCommentReEntryTriggertBy + IntegerToString(pTriggerTicket);
//
//   Trade.FillType(SYMBOL_FILLING_FOK);
//   Trade.Sell(Symbol(), volume, stopLoss, takeProfit, comment);
//
//   cleanPositionTicketsArrayAction();
//
//   addHedgeHedgeTicketInPositionGroupsAction(pTriggerTicket);
//   addTicketInDealGroupsAction(pTriggerTicket, InpHedgeHedgeCommentReEntryTriggertBy);
//}
//
//void openH3SellOrderAction(long pH2Ticket) {
//
//   int positionGroupId = 0;
//   long triggerTicket = 0;
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
//      Trade.Sell(Symbol(), volume, stopLoss, takeProfit, comment);
//
//      cleanPositionTicketsArrayAction();
//
//      addH3TicketInPositionGroupsAction(triggerTicket);
//      addTicketInDealGroupsAction(triggerTicket, InpH3CommentTriggertBy);
//   }
//}
//
//void openReEntryH3SellOrderAction(long pTriggerTicket) {
//
//   double volume  = NormalizeDouble(getPositionVolumeByPositionTicket(pTriggerTicket) * InpH3Multi, 2);
//   double stopLoss = 0;
//   double takeProfit = 0;
//   string comment = InpH3CommentReEntryTriggertBy + IntegerToString(pTriggerTicket);
//
//   Trade.FillType(SYMBOL_FILLING_FOK);
//   Trade.Sell(Symbol(), volume, stopLoss, takeProfit, comment);
//
//   cleanPositionTicketsArrayAction();
//
//   addH3TicketInPositionGroupsAction(pTriggerTicket);
//   addTicketInDealGroupsAction(pTriggerTicket, InpH3CommentReEntryTriggertBy);
//}


//+------------------------------------------------------------------+
