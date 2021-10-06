/*

   HedgeBuyInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/
//
//void getHedgeBuyInSignalState() {
//
//   long  positionTicket = 0;
//   int   barShift = 0;
//   bool  hedgeIsOpen = false;
//
//   for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
//      positionTicket = positionTickets[positionTicketsId];
//      if(positionIsHedgeState(positionTicket) == true) {
//         hedgeIsOpen = true;
//      }
//   }
//
//   if(hedgeIsOpen == false) {
//      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
//         positionTicket = positionTickets[positionTicketsId];
//         if(
//            getPositionTypeByPositionTicket(positionTicket) == ORDER_TYPE_SELL &&
//            positionIsTriggerState(positionTicket) == true &&
//            triggerIsHedgedState(positionTicket) == false &&
//            PositionProfit(positionTicket) < 0 &&
//            //getDynamicIsHigherMINDynamicBuyInSignal() == false &&
//            //Bid() > SGL_MA_SLOW.Main(barShift) &&
//            equityDDBuffer[barShift] > nextEquityDD &&
//            equityDDDynamicBuffer[barShift] > 12
//         ) {
//            openHedgeBuyOrderAction(positionTicket);
//            //newHedgeIsSet = true;
//         }
//      }
//   }
//
////   if(newHedgeIsSet == true) {
////      Print("trend: ----------------------------------------------------------------------------" + trend);
////      //Print("SGL_MA_SLOW.Main(0): " + );
////
////      //setMaxEquityDD();
////   }
//
//}
//
////void setMaxEquityDD() {
////
////   int barShift = 0;
////
////   if(equityDDBuffer[barShift] > nextEquityDD) {
////      nextEquityDD = nextEquityDD + InpEquityDDStep;
////   }
////}
//
////bool getDynamicIsHigherMINDynamicBuyInSignal() {
////
////   bool     signal = false;
////   int   barShift = 0;
////
//////   int      candlesForRangeAvg = 30;
//////   double   candlesForRangeAvgSum = 0;
////   double   m5candleDynamicAvg = 25;
//////   double   barHigh = 0;
//////   double   barLow = 0;
////   double   currentBuyDynamic = 0;
////   double   currentBuyDynamicPerMilliSeconde = 0;
////   double   destinationBuyDynamicPerMilliSeconde = 0;
////   int      candleOpenSinceSeconds = (int)TimeCurrent() - (int)M5_Bar.Time();
////   string lineText = "";
////
//////   for(int candleId = 1; candleId <= candlesForRangeAvg; candleId++) {
//////      barHigh = Bar.High(candleId) / Point();
//////      barLow = Bar.Low(candleId) / Point();
//////      candlesForRangeAvgSum += MathMax(barHigh, barLow) - MathMin(barHigh, barLow);
//////   }
////
//////candleRangeAvg = candlesForRangeAvgSum / candlesForRangeAvg;
////   destinationBuyDynamicPerMilliSeconde = m5candleDynamicAvg * InpDynamicAVGSpeedMulti / 5 / 60 / 1000;
////
////   currentBuyDynamic = buyDynamicBuffer[barShift];
////   
////   if(candleOpenSinceSeconds > 0) currentBuyDynamicPerMilliSeconde = currentBuyDynamic / candleOpenSinceSeconds / 1000;
////
////   //Print("---------------------------------------------");
////   //Print("buyDynamicBuffer[barShift]: " + buyDynamicBuffer[barShift]);
////   //Print("m5candleDynamicAvg: " + m5candleDynamicAvg);
////   //Print("destinationBuyDynamicPerMilliSeconde: " + destinationBuyDynamicPerMilliSeconde);
////   //Print("currentBuyDynamicPerMilliSeconde: " + currentBuyDynamicPerMilliSeconde);
////   //Print("candleOpenSinceSeconds: " + candleOpenSinceSeconds);
////
////
////
////   if(currentBuyDynamic > m5candleDynamicAvg && currentBuyDynamicPerMilliSeconde > destinationBuyDynamicPerMilliSeconde) {
////      signal = true;
////
//////      if(dynamicIsHigherMINDynamicBuyInSignalIsTriggert == false) {
//////         lineText = TimeToString(TimeCurrent(), TIME_SECONDS) + " // " + DoubleToString(currentBuyDynamic, 2);
//////         createVLine(__FUNCTION__ + TimeToString(TimeCurrent()), M5_Bar.Time(barShift), clrGreen, 1, STYLE_SOLID, lineText);
//////         dynamicIsHigherMINDynamicBuyInSignalIsTriggert = true;
//////         
//////         Print("----------------dynamicIsHigherMINDynamicBuyInSignalIsTriggert--------------------------------------------------------------------------------------");
//////      }
////
////      //Print("MomentumFilter isFalse, also Sleep");
////   } 
////   
////   if(currentBuyDynamic == 0) {
////      dynamicIsHigherMINDynamicBuyInSignalIsTriggert = false;
////   }
////
////   return (signal);
////}
//
//void setMaxEquityDD() {
//
//   bool  hedgeIsOpen = false;
//   int   barShift = 0;
//   long  positionTicket = 0;
//
//   for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
//      positionTicket = positionTickets[positionTicketsId];
//      if(positionIsHedgeState(positionTicket) == true) {
//         hedgeIsOpen = true;
//      }
//   }
//
//   if(hedgeIsOpen == false) {
//      if(equityDDBuffer[barShift] < (nextEquityDD - (InpEquityDDStep * 2))) {
//         nextEquityDD = nextEquityDD - InpEquityDDStep;
//         if(nextEquityDD < InpMaxEquityDD) nextEquityDD = InpMaxEquityDD;
//      }
//   } else {
//      if(equityDDBuffer[barShift] > nextEquityDD) {
//         nextEquityDD = nextEquityDD + InpEquityDDStep;
//      }
//   }
//}
////+------------------------------------------------------------------+
//
//long getHedgeHedgeBuyInSignalState() {
//
//   long positionTicket = 0;
//   int barShift = 0;
//   long returnValue = 0;
//
//   for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
//      positionTicket = positionTickets[positionTicketsId];
//
//      if(
//         PositionType(positionTicket) == ORDER_TYPE_SELL &&
//         //positionIsTriggerState(positionTicket) == false &&
//         positionIsHedgeState(positionTicket) == true &&
//         hedgeIsHedgedState(positionTicket) == false &&
//         positionIsHedgeHedgeState(positionTicket) == false &&
//         trend == UP_TREND
//      ) {
//         returnValue = positionTicket;
//      }
//   }
//
//   return(returnValue);
//
//}
////+------------------------------------------------------------------+
//long getH3BuyInSignalState() {
//
//   long positionTicket = 0;
//   int barShift = 0;
//   long returnValue = 0;
//
//   int positionTicketsId = 0;
//   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
//      positionTicket = positionTickets[positionTicketsId];
//
//      if(
//         PositionType(positionTicket) == ORDER_TYPE_SELL &&
//         positionIsHedgeHedgeState(positionTicket) == true &&
//         hedgeHedgeIsHedgedState(positionTicket) == false &&
//         trend == UP_TREND
//      ) {
//         returnValue = positionTicket;
//      }
//   }
//
//   return(returnValue);
//
//}
////+------------------------------------------------------------------+
