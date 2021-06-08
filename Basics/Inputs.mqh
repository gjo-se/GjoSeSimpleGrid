//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
sinput string              Basics;    // ---------- Basics ---------
input long                 InpMagicNumber = 1619769100;
input string               InpComment = "SimpleGrid";
input long                 InpMaxSlippage = 3;
input int                  InpMaxSpread = 10;
input bool                 InpTradeOnNewBar = true;
input ENUM_TIMEFRAMES      InpNewBarTimeframe = PERIOD_M1;
input bool                 InpShowObjOnVisualMode = false;
input bool                 InpShowDashboardOnVisualMode = false;

sinput string              IND_Trend;    // ---------- IND_GjoSeTrenddetector ---------
input ENUM_TIMEFRAMES      InpIND_GjoSeTrenddetector_SGL_Timeframe = PERIOD_M1;
input int                  InpIND_GjoSeTrenddetector_SGL_FAST_Period = 10;
input int                  InpIND_GjoSeTrenddetector_SGL_MIDDLE_Period = 100;
input int                  InpIND_GjoSeTrenddetector_SGL_SLOW_Period = 200;
input double               InpMinTrendStrength = 30;
input double               InpMinFastMiddleOffset = 30;
input double               InpMinMiddleSlowOffset = 30;

sinput string              SL_TP;    // ---------- SL & TP ---------
input int                  InpStopLoss = 0;
input int                  InpTakeProfit = 40;

sinput string              LEVEL;    // ---------- Next Buy / Sell Level ---------
input int                  InpLevelOffset = 100;
input bool                 InpUseLevelTrailingStop = true;
input int                  InpLevelTrailingStop = 80;
input int                  InpLevelStep = 10;

sinput string              BE;    // ---------- Break Even ---------
input bool                 InpUseBreakEven = true;
input int                  InpBreakEvenProfit = 50;
input int                  InpLockProfit = 10;

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

sinput string              HE;    // ---------- Hedge ---------
input double               InpHedgeMulti = 1;
input double               InpHedgeHedgeMulti = 2;
input double               InpH3Multi = 1;


input string               InpHedgeCommentTriggertBy = "HTBy_";
input string               InpHedgeCommentReEntryTriggertBy = "ReHTBy_";
input string               InpHedgeHedgeCommentTriggertBy = "HHTBy_";
input string               InpH3CommentTriggertBy = "H3TBy_";
input string               InpHedgeHedgeCommentReEntryTriggertBy = "ReHHTBy_";
input string               InpTriggerCommentReEntryTriggertBy = "ReTTBy_";
input string               InpH3CommentReEntryTriggertBy = "ReH3TBy_";

sinput string              SEC;    // ---------- Security ---------
input double               InpMaxAbsoluteEquity = 10000;
input double               InpMaxEquityDD_Out = 30;
input double               InpMaxEquityDD_OutAndStop = 30;