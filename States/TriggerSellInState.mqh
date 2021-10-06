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

   int barShift = 0;


   if(getDownTrendSellState() == true) {
      signal = true;
      if(getOpenSellPositionsFilter() == true) signal = false;

      // TODO: das geht aber besser, eindeutiger: setNextLevl
      if(getAskBelowNextSellInLevel() == true) {
         signal = true;
      }
   }

   // SellInFilter anlegen



//   if(getGWLDownDynamicLowerMinSellInFilter() == true) signal = false;
//   //if(getGWLUpDynamicSellInFilter() == true) signal = false;
//   if(getBidAboveLastLowSellInFilter() == true) signal = false;
//   if(getDynamicFastSlowSignalLowestLowHighestHighMinDiffSellInFilter() == true) signal = false;
//   if(getBidAboveTrendlineSellInFilter() == true) signal = false;



// A
// if(getDynamicFastSlowAndMiddleSlowOnZeroSellInFilter() == true) signal = false;
// if(getDynamicMiddleSlowIsIncreasingSellInFilter() == true) signal = false;
// if(getDynamicMiddleSelfGreaterMaxSellInFilter() == true) signal = false;
// if(getDynamicFastSlowCrossedMiddleSlowFromAboveSellInFilter() == true) signal = false;
// if(getBidIsLowerBollingerLowSellInFilter() == true) signal = false;

// B
// if(getGWLTrendStrengthLowerSessionMaxGWLTrendStrengthSellInFilter() == true) signal = false;
// if(getSGLTrendStrengthLowerSessionMaxSGLTrendStrengthSellInFilter() == true) signal = false;
// if(getMaxTrendStrengthSellInFilter() == true) signal = false;
// if(getDynamicFastSlowLowerMinSellInFilter() == true) signal = false;
// if(getGreenCandleSellInFilter() == true) signal = false;
// if(getRSILowerMinRSISellInFilter() == true) signal = false;


// C
// if(getSellIsTradableSellInFilter() == true) signal = false;
// if(getIsTradableSellInFilter() == true) signal = false;
// if(getDynamicFastSlowIsGreaterMiddleSlowSellInFilter() == true) signal = false;
// if(getBuyHedgesAreOpenFilter() == true) signal = false;


// Sonstiges
// if(spreadGreaterThanMaxSpreadSellInFilter() == true) signal = false;
// if(getM1GreenCandleSellInFilter() == true) signal = false;
// if(getM5BigFuseSellInFilter() == true) signal = false;
// if(getM5GreenCandleSellInFilter() == true) signal = false;
// if(getM1TrendSellInFilter() == true) signal = false;
// if(getMonsterUPMoveSellInFilter() == true) signal = false;
// if(getMaxOpenSellPositionsFilter() == true) signal = false;
// if(getBuyHedgesAreOpenFilter() == true) signal = false;

   return(signal);

}

bool getDownTrendSellState() {

   bool state = false;
   int barShift = 0;
//   int lastBarShift = 1;
   //double offset = 15;

   if(ArraySize(trendBuffer) > 0) {
      if(trendBuffer[barShift] == DOWN_TREND) {
         state = true;
         //createVLine(__FUNCTION__ + TimeToString(TimeCurrent(), TIME_SECONDS), iTime(Symbol(), PERIOD_CURRENT, barShift), clrRed, 1, STYLE_DASH);
         if(InpPrintFilter == true) Print("Signal isTrue: " + __FUNCTION__ + " // " + TimeToString(TimeCurrent(), TIME_SECONDS));
      }
   }

   return(state);
}

bool getOpenSellPositionsFilter() {

   bool filter = false;
   long positionTicket = 0;

   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];

      if(
         getPositionTypeByPositionTicket(positionTicket) == ORDER_TYPE_SELL &&
         positionIsTriggerState(positionTicket) == true
         //triggerIsHedgedState(positionTicket) == false
      ) {
         filter = true;
      }
   }

   return (filter);
}

//#####################################################

//bool getGWLDownDynamicLowerMinSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//
//   if(ArraySize(gwlDynamicFastSlowSignalBuffer) > 0) {
//      if(gwlDynamicFastSlowSignalBuffer[barShift] > InpIND_GjoSeDynamic_GWL_MinDynamic * -1) {
//         filter = true;
//         if(InpPrintFilter == true) Print("Filter isTrue: " + __FUNCTION__ + " // " + TimeToString(TimeCurrent(), TIME_SECONDS));
//      }
//   }
//
//   return(filter);
//}
//
//bool getGWLUpDynamicSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//
//   if(ArraySize(gwlDynamicFastSlowSignalColorBuffer) > 0) {
//      if(
//         gwlDynamicFastSlowSignalColorBuffer[barShift] == DYNAMIC_UP_TREND
//         || gwlDynamicFastSlowSignalColorBuffer[barShift + 1] == DYNAMIC_UP_TREND
//      ) {
//         filter = true;
//         if(InpPrintFilter == true) Print("Filter isTrue: " + __FUNCTION__ + " // " + TimeToString(TimeCurrent(), TIME_SECONDS));
//      }
//   }
//
//   return(filter);
//}





//bool spreadGreaterThanMaxSpreadSellInFilter() {
//
//   bool filter = false;
//
//   if((Spread() * -1) > InpMaxSpread) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//+------------------------------------------------------------------+

//bool getBidAboveLastLowSellInFilter() {
//
//   bool filter = false;
//   int lastBarShift = 1;
//
//   if(Bid() > M5_Bar.Low(lastBarShift)) {
//      filter = true;
//      if(InpPrintFilter == true) Print("Filter isTrue: " + __FUNCTION__ + " // " + TimeToString(TimeCurrent(), TIME_SECONDS));
//   }
//
//   return(filter);
//
//}

//bool getSellIsTradableSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//
//   //if(sglDynamicFastSlowColorBuffer[barShift] == DYNAMIC_UP_TREND_LOW) {
//   //   sellIsTradeable = true;
//   //}
//
//   if(sellIsTradeable == false) {
//      filter = true;
//   }
//
//   return(filter);
//
//}

//bool getDynamicFastSlowSignalLowestLowHighestHighMinDiffSellInFilter() {
//
//   bool filter = false;
//   int fastSlowSignalLowestLowHighestHighMinDiff = 80;
//   int highestHighBarIndex = getHighestHighBufferIndex(sglDynamicFastSlowSignalBuffer, 12);
//   int lowestLowBarIndex = getLowestLowBufferIndex(sglDynamicFastSlowSignalBuffer, 24);
//
//   if(
//      lowestLowBarIndex < highestHighBarIndex
//      || sglDynamicFastSlowSignalBuffer[highestHighBarIndex] - sglDynamicFastSlowSignalBuffer[lowestLowBarIndex] < fastSlowSignalLowestLowHighestHighMinDiff
//   ) {
//      filter = true;
//      if(InpPrintFilter == true) Print("Filter isTrue: " + __FUNCTION__ + " // " + TimeToString(TimeCurrent(), TIME_SECONDS));
//   }
//
//   return(filter);
//}

//datetime highestHighTime;
//
//bool getBidAboveTrendlineSellInFilter() {
//
//   bool filter = false;
//   int fastSlowSignalLowestLowHighestHighMinDiff = 80;
//   int highestHighBarIndex = getHighestHighBufferIndex(sglDynamicFastSlowSignalBuffer, 12);
//   int lowestLowBarIndex = getLowestLowBufferIndex(sglDynamicFastSlowSignalBuffer, 24);
//   double pointsPerBar = 10;
//
//   if(getSGLDownTrendSellInSignal() == true) {
//
//      int highestHighIndex = iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, 12, 0);
//      double highestHighValue = iHigh(Symbol(), PERIOD_CURRENT, highestHighIndex);
//      highestHighTime = iTime(Symbol(), PERIOD_CURRENT, highestHighIndex);
//
//      // was, wenn ich selber die HighestHigh bin?
//      datetime time2 = iTime(Symbol(), PERIOD_CURRENT, highestHighIndex - 1);
//      double   price2 = highestHighValue - (pointsPerBar * Point());
//      //double   price3 = highestHighValue - (pointsPerBar * 5 * Point());
//      //double   price4 = highestHighValue - (pointsPerBar * 10 * Point());
//      //double   price5 = highestHighValue - (pointsPerBar * 15 * Point());
//
//      //Print("------------------------------------");
//      //Print("highestHighIndex: " + highestHighIndex);
//      //Print("highestHighValue: " + highestHighValue);
//      //Print("highestHighTime: " + highestHighTime);
//      //Print("time2: " + time2);
//      //Print("price2: " + price2);
//      //Print("pointsPerBar / Point(): " + (pointsPerBar * Point()));
//
//      createTrendLine("TrendLine1" +  highestHighTime, highestHighTime, highestHighValue, time2, price2);
//      //createTrendLine("TrendLine1", highestHighTime, highestHighValue, time2, price3);
//      //createTrendLine("TrendLine2", highestHighTime, highestHighValue, time2, price4);
//      //createTrendLine("TrendLine3", highestHighTime, highestHighValue, time2, price5);
//
//      double trendLineValue = ObjectGetValueByTime(0, "TrendLine1" +  highestHighTime, iTime(Symbol(), PERIOD_CURRENT, 0), 0);
//
//      //Print("trendLineValue: " + trendLineValue);
//
//
//
//      if(Bid() > trendLineValue) {
//         filter = true;
//         if(InpPrintFilter == true) Print("Filter isTrue: " + __FUNCTION__ + " // " + TimeToString(TimeCurrent(), TIME_SECONDS));
//      }
//
//   }
//
//
//
//   return(filter);
//}
//
//void closeOnTrendline() {
//
//   long     positionTicket = 0;
//   long     triggerTicket = 0;
//   int      barShift = 0;
//   double trendLineValue = ObjectGetValueByTime(0, "TrendLine1" +  highestHighTime, iTime(Symbol(), PERIOD_CURRENT, 0), 0);
//
//   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//      positionTicket = positionTickets[positionTicketId];
//
//      if(positionTicket > 0) {
//         if(PositionType(positionTicket) == ORDER_TYPE_SELL) {
//             if(Bid() > trendLineValue) {
//                triggerTicket = getTriggerTicketByPositionTicket(positionTicket);
//                Trade.Close(positionTicket, PositionVolume(positionTicket), "ON_TRENDLINE" + IntegerToString(triggerTicket));
//             }
//         }
//      }
//   }
//}

//int getHighestHighBufferIndex(double &pBuffer[], int pMaxBarShift) {
//
//   double   highestHighValue = -10000;
//   int      highestHighIndex = 0;
//
//   for(int barShiftId = 0; barShiftId < pMaxBarShift; barShiftId++) {
//      if(pBuffer[barShiftId] > highestHighValue) {
//         highestHighValue = pBuffer[barShiftId];
//         highestHighIndex = barShiftId;
//      }
//   }
//
//   return(highestHighIndex);
//}
//
//int getLowestLowBufferIndex(double &pBuffer[], int pMaxBarShift) {
//
//   double   lowestLowValue = 10000;
//   int      lowestLowIndex = 0;
//
//   for(int barShiftId = 0; barShiftId < pMaxBarShift; barShiftId++) {
//      if(pBuffer[barShiftId] < lowestLowValue) {
//         lowestLowValue = pBuffer[barShiftId];
//         lowestLowIndex = barShiftId;
//      }
//   }
//
//   return(lowestLowIndex);
//}


//bool getDynamicFastSlowAndMiddleSlowOnZeroSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//
//   if(
//      sglDynamicFastSlowBuffer[barShift] > -2  && sglDynamicFastSlowBuffer[barShift] < 2
//      && sglDynamicMiddleSlowBuffer[barShift] > -1  && sglDynamicMiddleSlowBuffer[barShift] < 1
//   ) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//
//bool getDynamicFastSlowIsGreaterMiddleSlowSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//   double offset = 3.5;
//
//   if(sglDynamicFastSlowBuffer[barShift] + offset > sglDynamicMiddleSlowBuffer[barShift]) {
//      filter = true;
//   }
//
//
//
//   return(filter);
//
//}

//bool getDynamicFastSlowCrossedMiddleSlowFromAboveSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//   int maxBarsShift = 20;
//   bool fastCrossedSlowFromAboveIndexFound = false;
//
//   if(ArraySize(sglDynamicFastSlowBuffer) > maxBarsShift) {
//      for(int i = 0; i < maxBarsShift; i++) {
//         if(fastLineCrossedSlowLineFromAbove(sglDynamicFastSlowBuffer[i + 1], sglDynamicFastSlowBuffer[i], sglDynamicMiddleSlowBuffer[i + 1], sglDynamicMiddleSlowBuffer[i]) == true) {
//            fastCrossedSlowFromAboveIndexFound = true; // iBarShift(Symbol(), PERIOD_CURRENT, iTime(Symbol(), PERIOD_CURRENT, 0), true);
//         }
//      }
//   }
//
//   //Print("Time: " + iTime(Symbol(), PERIOD_CURRENT, 0) + " // " + fastCrossedSlowFromAboveIndexFound);
//
//
//
//
//   if(fastCrossedSlowFromAboveIndexFound == false) {
//      filter = true;
//   }
//
//   return(filter);
//
//}

//bool getDynamicMiddleSlowIsIncreasingSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//   int  barOffset = 2;
//
//   if(sglDynamicMiddleSlowBuffer[barShift + barOffset] < sglDynamicMiddleSlowBuffer[barShift]) {
//      filter = true;
//   }
//
//   return(filter);
//
//}

//bool getDynamicMiddleSelfGreaterMaxSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//
//   //Print("dynamicMiddleSelfBuffer[barShift]: " + dynamicMiddleSelfBuffer[barShift]);
//
//   if(sglDynamicMiddleSelfBuffer[barShift] > 0) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//
//bool getDynamicSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//
//   if(sglDynamicFastSlowBuffer[barShift] < -5) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//
//
//
//bool getBuyHedgesAreOpenFilter() {
//
//   bool filter = false;
//   bool  hedgeIsOpen = false;
//   long positionTicket = 0;
//
//   int positionTicketsId = 0;
//   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
//      positionTicket = positionTickets[positionTicketsId];
//
////      Print("getPositionTypeByPositionTicket(positionTicket): " + getPositionTypeByPositionTicket(positionTicket));
////      Print("positionIsHedgeState(positionTicket): " + positionIsHedgeState(positionTicket));
//
//      if(
//         getPositionTypeByPositionTicket(positionTicket) == ORDER_TYPE_BUY &&
//         positionIsHedgeState(positionTicket) == true
//      ) {
//         hedgeIsOpen = false;
//      }
//   }
//
//   if(hedgeIsOpen == true) filter = true;
//
//   return (filter);
//}
//
//bool getMaxOpenSellPositionsFilter() {
//
//   bool filter = false;
//   long positionTicket = 0;
//   int  positionsCount = 0;
//
//   int positionTicketsId = 0;
//   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
//      positionTicket = positionTickets[positionTicketsId];
//
//      if(
//         getPositionTypeByPositionTicket(positionTicket) == ORDER_TYPE_SELL //&&
//         //       positionIsTriggerState(positionTicket) == true &&
////         triggerIsHedgedState(positionTicket) == false
//      ) {
//         positionsCount++;
//
//      }
//   }
//
//   if(positionsCount > 1) {
//      filter = true;
//      //Print("is Sell filter is true" + positionsCount);
//   }
//
//   return (filter);
//}
//
//bool getMaxTrendStrengthSellInFilter() {
//
//   bool filter = false;
//   int  barShift = 0;
//
//   //if(sglTrendBuffer[barShift] * -1 > InpMax_SGL_TrendStrength + InpTakeProfit) {
//   //   filter = true;
//   //}
//
//   return (filter);
//}
//
//bool getSGLTrendStrengthLowerSessionMaxSGLTrendStrengthSellInFilter() {
//
//   bool filter = false;
//   int  barShift = 0;
//
//   //Print("sglTrendBuffer[barShift]: " + sglTrendBuffer[barShift]);
//
//   //if(sglTrendBuffer[barShift] * -1 > sglSessionMaxTrendStrength){
//   //     sglSessionMaxTrendStrength = sglTrendBuffer[barShift] * -1;
//   //}else{
//   // filter = true;
//   //}
//
//   return (filter);
//}
//
//bool getGWLTrendStrengthLowerSessionMaxGWLTrendStrengthSellInFilter() {
//
//   bool filter = false;
//   int  barShift = 0;
//
//   //Print("sglTrendBuffer[barShift]: " + sglTrendBuffer[barShift]);
//
//   //if(gwlTrendBuffer[barShift] * -1 > gwlSessionMaxTrendStrength){
//   //     gwlSessionMaxTrendStrength = gwlTrendBuffer[barShift] * -1;
//   //}else{
//   // filter = true;
//   //}
//
//   return (filter);
//}
//
//bool getGreenCandleSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//   double bid = Bid() + 20 * Point();
//
//   if(SGL_Bar.Open(barShift) < bid || SGL_Bar.Low(barShift + 1) < bid) {
//      filter = true;
//   }
//
//   if(GWL_Bar.Open(barShift) < bid) {
//      filter = true;
//   }
//   if(H2_Bar.Open(barShift) < bid) {
//      filter = true;
//   }
//   if(H4_Bar.Open(barShift) < bid) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//
//bool getM1GreenCandleSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//   double fuse = 0;
//   int historyCandles = 14;
//   double barOpen = M1_Bar.Open(barShift) / Point();
//   double bid = Bid() / Point();
//
//   for(int candleId = 0; candleId < historyCandles; candleId++) {
//      fuse += MathMin(M1_Bar.Open(candleId), M1_Bar.Close(candleId)) - M1_Bar.Low(candleId);
//   }
//
//   fuse = fuse / historyCandles / Point();
//
//   if(bid > (barOpen - (fuse * 2))) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//
//bool getM1TrendSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//
//   if(Bid() > M1_MA_MIDDLE.Main(barShift) - (30 * Point())) {
//      filter = true;
//   }
//
//   if(Bid() > M1_MA_SLOW.Main(barShift)) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//
//bool getM5BigFuseSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//   double averagefuse = 0;
//   double currentFuse = 0;
//   int historyCandles = 14;
//   int   bigFuseMulti = 3;
//   double barOpen = M5_Bar.Open(barShift) / Point();
//
//   for(int candleId = 0; candleId < historyCandles; candleId++) {
//      averagefuse += MathMin(M5_Bar.Open(candleId), M5_Bar.Close(candleId)) - M5_Bar.Low(candleId);
//   }
//
//   averagefuse = averagefuse / historyCandles / Point();
//   currentFuse = (MathMin(M5_Bar.Open(barShift), M5_Bar.Close(barShift)) - M5_Bar.Low(barShift)) / Point();
//
//   if(currentFuse > averagefuse * bigFuseMulti) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//
//bool getM5GreenCandleSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//   double averageFuse = 0;
//   int historyCandles = 14;
//   double barOpen = M5_Bar.Open(barShift) / Point();
//   double bid = Bid() / Point();
//
//   for(int candleId = 0; candleId < historyCandles; candleId++) {
//      averageFuse += MathMin(M5_Bar.Open(candleId), M5_Bar.Close(candleId)) - M5_Bar.Low(candleId);
//   }
//
//   averageFuse = averageFuse / historyCandles / Point();
//
//   if(bid > (barOpen - (averageFuse * 2))) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//
//bool getBidIsLowerBollingerLowSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//   int bollingOffset = 50;
//
//   if((Bid() + InpSGL_Bollinger_MaxOffset * Point()) < SGL_Bollinger.Lower(barShift)) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//
//bool getRSILowerMinRSISellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//
//   if(SGL_RSI.Main(barShift) < InpMinRSI) {
//      filter = true;
//   }
//   if(M1_RSI.Main(barShift) < InpMinRSI) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//+------------------------------------------------------------------+

// TODO: die Logik überdenken
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

//bool getMonsterUPMoveSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//
//   if(buyDynamicBuffer[barShift] > 60) {
//      filter = true;
//   }
//
//   return(filter);
//
//}
//+------------------------------------------------------------------+
