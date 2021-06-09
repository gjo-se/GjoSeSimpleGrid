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
   ENUM_TIMEFRAMES gwlTimeFrame = InpIND_GjoSeTrenddetector_GWL_Timeframe;
   ENUM_SGL_GWL    sgl_gwl_type = InpIND_GjoSeTrenddetector_SGL_GWL_Type;
   int gwlFast = InpIND_GjoSeTrenddetector_GWL_FAST_Period;
   int gwlMiddle = InpIND_GjoSeTrenddetector_GWL_MIDDLE_Period;
   int gwlSLOW = InpIND_GjoSeTrenddetector_GWL_SLOW_Period;
  

   tickvolumeHandle = iVolumes(Symbol(), PERIOD_M1, VOLUME_TICK);

   sglTrendHandle = iCustom(Symbol(), InpIND_GjoSeTrenddetector_GWL_Timeframe, "GjoSe\\GjoSeTrendDecetor\\IND_GjoSeTrenddetector", sgl_gwl_type, gwlTimeFrame, gwlFast, gwlMiddle, gwlSLOW, InpMinTrendStrength, InpMinFastMiddleOffset, InpMinMiddleSlowOffset);
   if(sglTrendHandle==INVALID_HANDLE) Print("Expert: iCustom call: Error code=",GetLastError());
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
