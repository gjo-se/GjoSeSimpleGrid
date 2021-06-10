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
   openBuyPositionsFilter = false;
   nextBuyLevel = NEXT_BUY_LEVEL_DEFAULT_VALUE;
   nextSellLevel = NEXT_SELL_LEVEL_DEFAULT_VALUE;
   securityStop = false;
   restartAfterEquityDD_Out = true;
   lastHistoryCall = 0;
   trend = ROTATION_AREA;

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

    //tickvolumeHandle = iVolumes(Symbol(), PERIOD_M1, VOLUME_TICK);

   ENUM_TIMEFRAMES gwlTimeFrame = InpIND_GjoSeTrenddetector_GWL_Timeframe;
   ENUM_SGL_GWL    gwlType = InpIND_GjoSeTrenddetector_GWL_Type;
   int gwlFast = InpIND_GjoSeTrenddetector_GWL_FAST_Period;
   int gwlMiddle = InpIND_GjoSeTrenddetector_GWL_MIDDLE_Period;
   int gwlSLOW = InpIND_GjoSeTrenddetector_GWL_SLOW_Period;
   gwlTrendHandle = iCustom(Symbol(), InpIND_GjoSeTrenddetector_GWL_Timeframe, "GjoSe\\GjoSeTrendDecetor\\IND_GjoSeTrenddetector", gwlType, gwlTimeFrame, gwlFast, gwlMiddle, gwlSLOW, InpMin_GWL_TrendStrength, InpMin_GWL_FastMiddleOffset, InpMin_GWL_MiddleSlowOffset);
   if(gwlTrendHandle == INVALID_HANDLE) Print("Expert: iCustom call: Error code=",GetLastError());

   ENUM_TIMEFRAMES sglTimeFrame = InpIND_GjoSeTrenddetector_SGL_Timeframe;
   ENUM_SGL_GWL    sglType = InpIND_GjoSeTrenddetector_SGL_Type;
   int sglFast = InpIND_GjoSeTrenddetector_SGL_FAST_Period;
   int sglMiddle = InpIND_GjoSeTrenddetector_SGL_MIDDLE_Period;
   int sglSLOW = InpIND_GjoSeTrenddetector_SGL_SLOW_Period;
   sglTrendHandle = iCustom(Symbol(), InpIND_GjoSeTrenddetector_SGL_Timeframe, "GjoSe\\GjoSeTrendDecetor\\IND_GjoSeTrenddetector", sglType, sglTimeFrame, sglFast, sglMiddle, sglSLOW, InpMin_SGL_TrendStrength, InpMin_SGL_FastMiddleOffset, InpMin_SGL_MiddleSlowOffset);
   if(sglTrendHandle == INVALID_HANDLE) Print("Expert: iCustom call: Error code=",GetLastError());
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
