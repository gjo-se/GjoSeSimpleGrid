//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| ENUMS                                                            |
//+------------------------------------------------------------------+

enum ENUM_TRADE_DIRECTION {
   NONE = 0,
   LONG = 1,
   SHORT = 2,
   BOTH = 3
};

//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
sinput string              TradeDirection;    // ---------- TradeDirection ---------
input ENUM_TRADE_DIRECTION InpTradeDirection = SHORT; // Trade Direction

sinput string              SL_TP;    // ---------- SL & TP ---------
input int                  InpStopLoss = 0; // StopLoss
input int                  InpTakeProfit = 90; // (OPTI 50-250/10) TakeProfit

sinput string              LEVEL;    // ---------- Next Buy / Next Sell Level ---------
input bool                 InpUseLevelTrailingStop = true; // Use LevelTrailing (TODO: raus, fixieren)
input int                  InpLevelOffset = 50; // (OPTI 50-250/10) Level Offset zum Höchst-Kurs
input int                  InpLevelTrailingStop = 80; // (OPTI 50-250/10) Level Trailing Value
input int                  InpLevelStep = 10; // Level Trailing Step (TODO: raus, fixieren)

sinput string              MM;    // ---------- MoneyManagement ---------
input bool                 InpUseMoneyManagement = true; // Use Money Management (TODO: wird so nicht mehr benutzt)
input double               InpLotsPerEquity = 0; // Lots per 1000 Equity
input double               InpFixedVolume = 0; // Fixe Lotgröße
input double               InpMaxPositionRiskPercent = 1; // (OPTI 1-3/0,5) max Position Risk %
input double               InpMaxSymbolRiskPercent = 10; // (OPTI 5-15/1) max Symbol Risk %

sinput string              Basics;    // ---------- Basics ---------
input long                 InpMagicNumber = 1619769100; // MagicNumber (TODO: Logik bauen: SymbolPaar, Strategy, Version)
input string               InpComment = "SimpleGridNextGeneration"; // Comment
input long                 InpMaxSlippage = 3; // max Slippage (TODO: Funktionlität klären)
input int                  InpMaxSpread = 20; // max Spread (TODO: Funktionlität klären)
input bool                 InpTradeOnNewBar = false; // Trade on new Bar (TODO: Funktionlität klären)
input ENUM_TIMEFRAMES      InpNewBarTimeframe = PERIOD_M1; // New Bar Timeframe

sinput string              TI;    // ---------- Timer ---------
input bool                 InpUseTimer = true; // Use Timer
input int                  InpStartHour = 2; // Start Hour
input int                  InpStartMinute = 0; // Start Minute
input int                  InpEndHour = 23; // End Hour
input int                  InpEndMinute = 0; // End Minute
input bool                 InpUseLocalTime = false; // Use Local Time

sinput string              StrategyTester;    // ---------- StrategyTester ---------
input bool                 InpShowObjOnVisualMode = false; // Show Objects on visual Mode
input bool                 InpShowDashboardOnVisualMode = false; // Show Dashboard on visual Mode
input bool                 InpPrintFilter = true; // Print Filter Lines
input datetime             InpTrendLineStartDate = D'2021.09.06 00:00'; // Trendline StartDatum (Objects im Tester nicht vorhanden)
input double               InpTrendLineStartValue = 1.1950;
input double               InpTrendLineH1Bars = 624;
input double               InpTrendLineValueDiff = 3480;

sinput string              PipValues;    // ---------- Pip Values ---------
input double               InpPipValueCHFJPY = 7.60; // Pip Value CHFJPY (TODO: Vereinfachung suchen)
input double               InpPipValueEURJPY = 7.60; // Pip Value EURJPY
input double               InpPipValueEURUSD = 8.60; // Pip Value EURUSD
input double               InpPipValueGBPJPY = 7.60; // Pip Value GBPJPY
input double               InpPipValueGBPUSD = 8.60; // Pip Value GBPUSD
input double               InpPipValueXAUUSD = 8.60; // Pip Value XAUUSD
//+------------------------------------------------------------------+

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