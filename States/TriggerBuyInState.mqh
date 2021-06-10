/*

   TriggerBuyInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

   - openBuyOrder
      - wenn keine Buy Open, die nicht gehedged ist
      - oder wenn Bid > nextBuySignal ist (Trailing)
*/
bool getTriggerBuyInSignalState() {

   bool signal = false;

   if(getDefaultBuyInSignal() == true) {
      signal = true;
      if(getOpenBuyPositionsFilter() == true) signal = false;
   }

   if(getBidAboveNextBuyInLevel() == true) {
      signal = true;
   }

   if(spreadGreaterThanMaxSpreadBuyInFilter() == true) signal = false;
   if(getGWLTrendBuyInFilter() == true) signal = false;

   return(signal);

}
//+------------------------------------------------------------------+

bool getDefaultBuyInSignal() {

   bool signal = true;

   return(signal);

}

bool getOpenBuyPositionsFilter() {

   bool filter = false;
   long positionTicket = 0;

   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];

      if(
         getPositionTypeByPositionTicket(positionTicket) == ORDER_TYPE_BUY &&
         positionIsTriggerState(positionTicket) == true &&
         triggerIsHedgedState(positionTicket) == false
      ) {
         filter = true;
      }
   }

   return (filter);
}

bool spreadGreaterThanMaxSpreadBuyInFilter() {

   bool filter = false;

   if((Spread() * -1) > InpMaxSpread) {
      filter = true;
   }
   
   return(filter);

}
//+------------------------------------------------------------------+

bool getGWLTrendBuyInFilter() {

   bool filter = false;
   int barShift = 0;

   if(trend != UP_TREND) {
      filter = true;
   }

   return(filter);

}


//+------------------------------------------------------------------+

bool getBidAboveNextBuyInLevel() {

   bool signal = false;

   if(nextBuyLevel == NEXT_BUY_LEVEL_DEFAULT_VALUE) setNextBuyLevel();
   trailNextBuyLevel();

   if(Bid() > nextBuyLevel && nextBuyLevel != NEXT_BUY_LEVEL_DEFAULT_VALUE)
      signal = true;

   return (signal);

}

void setNextBuyLevel() {

   bool filter = false;
   double nextBuyLevelTmp = 0;
   int barShift = 0;

   for(int i = 0; i < ArraySize(positionTickets); i++) {
      long positionTicket = positionTickets[i];
      
      nextBuyLevelTmp = Bid() + (InpLevelOffset * Point()) + (InpTakeProfit * Point());
      if(
         (getPositionTypeByPositionTicket(positionTicket) == ORDER_TYPE_BUY &&
          positionIsTriggerState(positionTicket) == true &&
          triggerIsHedgedState(positionTicket) == false &&
          PositionOpenPrice(positionTicket) < nextBuyLevelTmp)
      ) {
         filter = true;
      }
   }

   if(filter == false) {
      nextBuyLevel = nextBuyLevelTmp;
      if(showObj(InpShowObjOnVisualMode) == true) {
         createHLine(NEXT_BUY_LEVEL, nextBuyLevel, NEXT_BUY_LEVEL, clrGreen);
      }
   }
}

void trailNextBuyLevel() {

   double levelOffset = InpLevelOffset * Point();
   double levelTrailingStop = InpLevelTrailingStop * Point();
   double levelStep = InpLevelStep * Point();
   int chartId = 0;
   int barShift = 0;

   if((Bid() + levelStep) < (nextBuyLevel - levelOffset)) {
      nextBuyLevel = Bid() + levelOffset;
      if(ObjectFind(chartId, NEXT_BUY_LEVEL) >= 0) {
         ObjectSetDouble(chartId, NEXT_BUY_LEVEL, OBJPROP_PRICE, nextBuyLevel);
         ObjectSetString(chartId, NEXT_BUY_LEVEL, OBJPROP_TEXT, NEXT_BUY_LEVEL + DoubleToString(nextBuyLevel, 5));
      }
   }
}
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
