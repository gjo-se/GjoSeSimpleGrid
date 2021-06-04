/*

   TriggerSellInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

   - openSellOrder
      - wie Buy
*/

bool getTriggerSellInSignalState() {

   bool signal = false;

   if(getDefaultSellInSignal() == true) {
      signal = true;
      if(getOpenSellPositionsFilter() == true) signal = false;
   }

   if(getAskBelowNextSellInLevel() == true) {
      signal = true;
   }

   if(spreadGreaterThanMaxSpreadSellInFilter() == true) signal = false;
   if(getTrendSellInFilter() == true) signal = false;

   return(signal);

}
//+------------------------------------------------------------------+

bool getDefaultSellInSignal() {

   bool signal = true;

   return(signal);

}

bool spreadGreaterThanMaxSpreadSellInFilter() {

   bool filter = false;

   if((Spread() *-1) > InpMaxSpread) {
      filter = true;
   }

   return(filter);

}
//+------------------------------------------------------------------+

bool getTrendSellInFilter() {

   bool filter = false;
   int barShift = 0;

   if(sglTrendBuffer[barShift] != DOWN_TREND) {
      filter = true;
   }

   return(filter);

}

bool getOpenSellPositionsFilter() {

   bool filter = false;
   long positionTicket = 0;

   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];

      if(
         getPositionTypeByPositionTicket(positionTicket) == ORDER_TYPE_SELL &&
         positionIsTriggerState(positionTicket) == true &&
         triggerIsHedgedState(positionTicket) == false
      ) {
         filter = true;
      }
   }

   return (filter);
}
//+------------------------------------------------------------------+

bool getAskBelowNextSellInLevel() {

   bool signal = false;

   if(nextSellLevel == NEXT_SELL_LEVEL_DEFAULT_VALUE) setNextSellLevel();
   trailNextSellLevel();

   if(Ask() < nextSellLevel && nextSellLevel != NEXT_SELL_LEVEL_DEFAULT_VALUE)
      signal = true;

   return (signal);

}

void setNextSellLevel() {

   bool filter = false;
   double nextSellLevelTmp = 0;
   int barShift = 0;

   for(int i = 0; i < ArraySize(positionTickets); i++) {
      long positionTicket = positionTickets[i];
      nextSellLevelTmp = Ask() - (InpLevelOffset * Point()) - (InpTakeProfit * Point());
      if(
         (getPositionTypeByPositionTicket(positionTicket) == ORDER_TYPE_SELL &&
          positionIsTriggerState(positionTicket) == true &&
          triggerIsHedgedState(positionTicket) == false &&
          PositionOpenPrice(positionTicket) > nextSellLevelTmp)
      ) {
         filter = true;
      }
   }

   if(filter == false) {
      nextSellLevel = nextSellLevelTmp;
      if(showObj(InpShowObjOnVisualMode) == true) {
         createHLine(NEXT_SELL_LEVEL, nextSellLevel, NEXT_SELL_LEVEL, clrRed);
      }
   }
}

void trailNextSellLevel() {

   double levelOffset = InpLevelOffset * Point();
   double levelTrailingStop = InpLevelTrailingStop * Point();
   double levelStep = InpLevelStep * Point();
   int chartId = 0;
   int barShift = 0;

   if((Ask() - levelStep) > (nextSellLevel + levelOffset)) {
      nextSellLevel = Ask() - levelOffset;

      if(ObjectFind(chartId, NEXT_SELL_LEVEL) >= 0) {
         ObjectSetDouble(chartId, NEXT_SELL_LEVEL, OBJPROP_PRICE, nextSellLevel);
         ObjectSetString(chartId, NEXT_SELL_LEVEL, OBJPROP_TEXT, NEXT_SELL_LEVEL + DoubleToString(nextSellLevel, 5));
      }
   }
}
//+------------------------------------------------------------------+