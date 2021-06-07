//+------------------------------------------------------------------+
//|                                                      Globals.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

CTradeHedge Trade;
CPending    Pending;
CPositions  Positions;
CBars       Bar;
CTrailing   Trail;
CTimer      Timer;
CNewBar     NewBar;
//CiMA        GWL_MA;
CiMA        SGL_MA_SLOW;
CiMA        SGL_MA_MIDDLE;
CiMA        SGL_MA_FAST;
CDealInfo   Deal;
TCustomCriterionArray   *criterion_Ptr;

long  positionTickets[];
long  positionGroups[][9];
long  positionGroupsTmp[][9];
long  dealGroups[][200];
long  dealGroupsTmp[][200];
long  dealGroupProfit[][2];
long  dealGroupProfitTmp[][2];

int      tickvolumeHandle;
double   tickVolumeBuffer[];
int      sglTrendHandle;
double   sglTrendBuffer[];

bool openBuyPositionsFilter;

// nextLevel
double   nextBuyLevel;
double   nextSellLevel;

// Security
double   equityDD;
bool     securityStop;
bool     restartAfterEquityDD_Out;

datetime lastHistoryCall;
//+------------------------------------------------------------------+
