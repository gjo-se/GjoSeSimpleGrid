//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void initializeEAAction() {

   Trade.Deviation(InpMaxSlippage);
   Trade.MagicNumber(InpMagicNumber);

}
//+------------------------------------------------------------------+
void initializeGlobalsAction() {

   isNewBar = false;
   //nextEquityDD = InpMaxEquityDD;
   openBuyPositionsFilter = false;
   nextBuyLevel = NEXT_BUY_LEVEL_DEFAULT_VALUE;
   nextSellLevel = NEXT_SELL_LEVEL_DEFAULT_VALUE;
   securityStop = false;
   restartAfterEquityDD_Out = true;
   lastHistoryCall = 0;
   //gwlTrend = ROTATION_AREA;
   //sglTrend = ROTATION_AREA;
   //gwlSessionMaxTrendStrength = 0;
   //sglSessionMaxTrendStrength = 0;
   trend = ROTATION_AREA;
   buyIsTradeable = true;
   sellIsTradeable = true;
   dynamicIsHigherMINDynamicBuyInSignalIsTriggert = false;
   fastCrossedSlowFromAboveIndex = 0;

}
//+------------------------------------------------------------------+
void initializeArraysAction() {

   initializeArray(positionTickets);
   initializeArray(positionGroups);
   initializeArray(positionGroupsTmp);
   initializeArray(dealGroups);
   initializeArray(dealGroupsTmp);
   initializeArray(dealGroupProfit);
   initializeArray(dealGroupProfitTmp);
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void initializeIndicatorsAction() {

//   equityDDHandle = iCustom(Symbol(), Period(), "GjoSe\\GjoSeEquityDD\\IND_GjoSeEquityDD", InpMaxEquityDD, InpMaxEquityDD_OutAndStop);
//   if(equityDDHandle == INVALID_HANDLE) Print("Expert: iCustom - equityDDHandle - call: Error code=",GetLastError());

//   ENUM_TIMEFRAMES sglTimeFrame = InpIND_GjoSeDynamic_SGL_Timeframe;
//   int sglFast = InpIND_GjoSeDynamic_SGL_FAST_Period;
//   int sglMiddle = InpIND_GjoSeDynamic_SGL_MIDDLE_Period;
//   int sglSLOW = InpIND_GjoSeDynamic_SGL_SLOW_Period;
//   //int sglMinDynamic = InpIND_GjoSeDynamic_SGL_MinDynamic;
//   //int sglMaxDynamic = InpIND_GjoSeDynamic_SGL_MaxDynamic;
//   //int sglFastSlowDynamic = InpIND_GjoSeDynamic_SGL_FastSlowDynamic;
//   //int sglFastSlowSignalOffset = InpIND_GjoSeDynamic_SGL_FastSlowSignalOffset;
////   sglDynamicHandle = iCustom(Symbol(), Period(), "GjoSe\\GjoSeDynamic\\IND_GjoSeDynamic", sglTimeFrame, sglFast, sglMiddle, sglSLOW, sglMinDynamic, sglMaxDynamic, sglFastSlowSignalOffset);
//   sglDynamicHandle = iCustom(Symbol(), Period(), "GjoSe\\GjoSeDynamic\\IND_GjoSeDynamic", sglTimeFrame, sglFast, sglMiddle, sglSLOW);
//   if(sglDynamicHandle == INVALID_HANDLE) Print("Expert: iCustom - sglDynamicHandle - call: Error code=",GetLastError());

   trendHandle = iCustom(
    Symbol(),
    Period(),
    "GjoSe\\GjoSeTrendDetector\\IND_GjoSeTrenddetector",
    InpIND_GjoSeTrenddetector_FAST_Period,
    InpIND_GjoSeTrenddetector_Middle_Period,
    InpIND_GjoSeTrenddetector_Slow_Period,
    InpIND_GjoSeTrenddetector_GWL_Timeframe
    );
   if(trendHandle == INVALID_HANDLE) Print("Expert: iCustom - IND_GjoSeTrenddetector - call: Error code=",GetLastError());




//   ENUM_TIMEFRAMES gwlTimeFrame = InpIND_GjoSeDynamic_GWL_Timeframe;
//   int gwlFast = InpIND_GjoSeDynamic_GWL_FAST_Period;
//   int gwlMiddle = InpIND_GjoSeDynamic_GWL_MIDDLE_Period;
//   int gwlSLOW = InpIND_GjoSeDynamic_GWL_SLOW_Period;
//   //int gwlMinDynamic = InpIND_GjoSeDynamic_GWL_MinDynamic;
//   //int gwlMaxDynamic = InpIND_GjoSeDynamic_GWL_MaxDynamic;
//   //int gwlFastSlowDynamic = InpIND_GjoSeDynamic_GWL_FastSlowDynamic;
//   //gwlDynamicHandle = iCustom(Symbol(), Period(), "GjoSe\\GjoSeDynamic\\IND_GjoSeDynamic", gwlTimeFrame, gwlFast, gwlMiddle, gwlSLOW, gwlMinDynamic, gwlMaxDynamic);
//   gwlDynamicHandle = iCustom(Symbol(), Period(), "GjoSe\\GjoSeDynamic\\IND_GjoSeDynamic", gwlTimeFrame, gwlFast, gwlMiddle, gwlSLOW);
//   if(gwlDynamicHandle == INVALID_HANDLE) Print("Expert: iCustom - gwlDynamicHandle - call: Error code=",GetLastError());

//   int sglSLowMAShift = 0;
//   SGL_MA_SLOW.Init(Symbol(),InpIND_GjoSeDynamic_SGL_Timeframe,InpIND_GjoSeDynamic_SGL_FAST_Period,sglSLowMAShift,MODE_SMA, PRICE_CLOSE);
//
//   M1_MA_SLOW.Init(Symbol(),PERIOD_M1,200,0,MODE_SMA, PRICE_CLOSE);
//   M1_MA_MIDDLE.Init(Symbol(),PERIOD_M1,100,0,MODE_SMA, PRICE_CLOSE);
//   M1_MA_FAST.Init(Symbol(),PERIOD_M1,1,0,MODE_SMA, PRICE_CLOSE);
//
//   SGL_Bollinger.Init(Symbol(),InpIND_GjoSeDynamic_SGL_Timeframe,InpSGL_BollingerPeriod,InpSGL_BoolingerShift,InpSGL_BollingerDeviation,InpSGL_BollingerPrice);

//   SGL_RSI.Init(Symbol(),InpIND_GjoSeTrenddetector_SGL_Timeframe,InpRSIPeriod,InpRSIPrice);
//   M1_RSI.Init(Symbol(),PERIOD_M1,InpRSIPeriod,InpRSIPrice);

}
//+------------------------------------------------------------------+

void initializeNextBuyLevelAction() {

   nextBuyLevel = NEXT_BUY_LEVEL_DEFAULT_VALUE;
   int chartId = 0;

   if(ObjectFind(chartId, NEXT_BUY_LEVEL) >= 0) {
      ObjectDelete(chartId, NEXT_BUY_LEVEL);
   }
}

void initializeNextSellLevelAction() {

   nextSellLevel = NEXT_SELL_LEVEL_DEFAULT_VALUE;
   int chartId = 0;

   if(ObjectFind(chartId, NEXT_SELL_LEVEL) >= 0) {
      ObjectDelete(chartId, NEXT_SELL_LEVEL);
   }
}
//+------------------------------------------------------------------+
