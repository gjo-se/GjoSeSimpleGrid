//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
enum ENUM_GWL_TREND {
   GWL_UP_TREND = 1,   // GWL UP_TREND
   GWL_DOWN_TREND = -1    // GWL DOWN_TREND
};

enum ENUM_TRADE_DIRECTION {
   NONE = 0,
   LONG = 1,
   SHORT = 2,
   BOTH = 3
};

const int TRADE_DIRECTION_NONE = 0;
const int TRADE_DIRECTION_LONG = 1;
const int TRADE_DIRECTION_SHORT = 2;
const int TRADE_DIRECTION_BOTH = 3;

sinput string              Basics;    // ---------- Basics ---------
input long                 InpMagicNumber = 1619769100;
input string               InpComment = "SimpleGridNextGeneration";
input long                 InpMaxSlippage = 3;
input int                  InpMaxSpread = 20;
input bool                 InpTradeOnNewBar = false;
input ENUM_TIMEFRAMES      InpNewBarTimeframe = PERIOD_M1;
input bool                 InpShowObjOnVisualMode = false;
input bool                 InpShowDashboardOnVisualMode = false;
input ENUM_TRADE_DIRECTION InpTradeDirection = SHORT;
input int                  InpMaxOpenSymbolPositions = 3;

//sinput string              IND_GWL_Trend;    // ---------- IND_GjoSeDynamic GWL ---------
//input ENUM_TIMEFRAMES      InpIND_GjoSeDynamic_GWL_Timeframe = PERIOD_H1;
//input int                  InpIND_GjoSeDynamic_GWL_FAST_Period = 1;
//input int                  InpIND_GjoSeDynamic_GWL_MIDDLE_Period = 100;
//input int                  InpIND_GjoSeDynamic_GWL_SLOW_Period = 200;
//input int                  InpIND_GjoSeDynamic_GWL_MinDynamic = 0;
//input int                  InpIND_GjoSeDynamic_GWL_MaxDynamic = 1500;
//input int                  InpIND_GjoSeDynamic_GWL_FastSlowDynamic = 100;

sinput string              IND_GjoSeTrenddetector;    // ---------- IND_GjoSeTrenddetector ---------
input int                  InpIND_GjoSeTrenddetector_FAST_Period = 1;
input int                  InpIND_GjoSeTrenddetector_Middle_Period = 100;
input int                  InpIND_GjoSeTrenddetector_Slow_Period = 200;
input ENUM_TIMEFRAMES      InpIND_GjoSeTrenddetector_GWL_Timeframe = PERIOD_D1;

//input int                  InpIND_GjoSeDynamic_SGL_MinDynamic = 100;
//input int                  InpIND_GjoSeDynamic_SGL_MaxDynamic = 700;
//input int                  InpIND_GjoSeDynamic_SGL_FastSlowDynamic = 20;
//input int                  InpIND_GjoSeDynamic_SGL_FastSlowSignalOffset = 15;

//sinput string               DYNAMIC;    // Dynamic
//input int                   InpDynamicAVGSpeedMulti = 3;

//sinput string               SGL_BOLLINGER;    // SGL Bollinger Bands
//input int                   InpSGL_BollingerPeriod = 20;
//input int                   InpSGL_BoolingerShift = 0;
//input double                InpSGL_BollingerDeviation = 2;
//input ENUM_APPLIED_PRICE    InpSGL_BollingerPrice = PRICE_CLOSE;
//input int                   InpSGL_Bollinger_MaxOffset = 50;
//
//sinput string               RSI;  // SGL RSI
//input int                   InpRSIPeriod = 14;
//input ENUM_APPLIED_PRICE    InpRSIPrice = PRICE_CLOSE;
//input int                   InpMinRSI = 30;

sinput string              SL_TP;    // ---------- SL & TP ---------
input int                  InpStopLoss = 0;
input int                  InpTakeProfit = 90;

sinput string              LEVEL;    // ---------- Next Buy / Sell Level ---------
input int                  InpLevelOffset = 50;
input bool                 InpUseLevelTrailingStop = true;
input int                  InpLevelTrailingStop = 80;
input int                  InpLevelStep = 10;

sinput string              BE;    // ---------- Break Even ---------
input bool                 InpUseBreakEven = true;
input int                  InpBreakEvenProfit = 50;
input int                  InpLockProfit = 10;

sinput string              TS;      // Trailing Stop
input bool                 InpUseTrailingStop = true;
input int                  InpTrailingStop = 300;
input int                  InpTrailingMinimumProfit = 100;
input int                  InpTrailingStep = 10;

sinput string              MM;    // ---------- MoneyManagement ---------
input bool                 InpUseMoneyManagement = true;
input double               InpRiskPercent = 0;
input double               InpLotsPerEquity = 0.01;
input double               InpFixedVolume = 0;

sinput string              TI;    // ---------- Timer ---------
input bool                 InpUseTimer = true;
input int                  InpStartHour = 2;
input int                  InpStartMinute = 0;
input int                  InpEndHour = 23;
input int                  InpEndMinute = 0;
input bool                 InpUseLocalTime = false;

//sinput string              HE;    // ---------- Hedge ---------
//input double               InpHedgeMulti = 1;
//input double               InpHedgeHedgeMulti = 2;
//input double               InpH3Multi = 1;
//
//
//input string               InpHedgeCommentTriggertBy = "HTBy_";
//input string               InpHedgeCommentReEntryTriggertBy = "ReHTBy_";
//input string               InpHedgeHedgeCommentTriggertBy = "HHTBy_";
//input string               InpH3CommentTriggertBy = "H3TBy_";
//input string               InpHedgeHedgeCommentReEntryTriggertBy = "ReHHTBy_";
//input string               InpTriggerCommentReEntryTriggertBy = "ReTTBy_";
//input string               InpH3CommentReEntryTriggertBy = "ReH3TBy_";
//
//sinput string              SEC;    // ---------- Security ---------
//input int                  InpMaxAbsoluteEquity = 10000;
//input double               InpMaxEquityDD = 20;
//input double               InpEquityDDStep = 2;
//input double               InpMaxEquityDD_OutAndStop = 30;
input bool                 InpPrintFilter = true;
//+------------------------------------------------------------------+
