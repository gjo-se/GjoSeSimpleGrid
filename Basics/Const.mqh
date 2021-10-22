//+------------------------------------------------------------------+
//|                                                        Const.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

const double   LOWEST_PRICE = EMPTY_VALUE;
const double   HIGHEST_PRICE = 0;
const int      NOT_FOUND = -1;

//const int      TICK_VOLUME_BUFFER = 0;
//const int      TREND_BUFFER = 0;
//const int      EQUITY_DD_BUFFER = 0;
//const int      EQUITY_DD_DYNAMIC_BUFFER = 1;

//const int      DYNAMIC_FAST_SELF_BUFFER = 0;
//const int      DYNAMIC_FAST_SLOW_BUFFER = 0;
//const int      DYNAMIC_FAST_SLOW_COLOR_BUFFER = 1;
//const int      DYNAMIC_FAST_SLOW_SIGNAL_BUFFER = 2;
//const int      DYNAMIC_FAST_SLOW_SIGNAL_COLOR_BUFFER = 3;
////const int      DYNAMIC_MIDDLE_SELF_BUFFER = 2;
//const int      DYNAMIC_MIDDLE_SLOW_BUFFER = 4;
//const int      DYNAMIC_SLOW_SELF_BUFFER = 4;

const int      TREND_BUFFER = 4;

//const int       DYNAMIC_ROTATION_AREA = 0;
//const int       DYNAMIC_UP_TREND = 1;
//const int       DYNAMIC_UP_TREND_STRONG = 2;
//const int       DYNAMIC_DOWN_TREND = 3;
//const int       DYNAMIC_DOWN_TREND_STRONG = 4;

const int      ROTATION_AREA = 0;
const int      UP_TREND = 1;
const int      DOWN_TREND = 2;

const string   NEXT_BUY_LEVEL = "nextBuyLevel_";
const int      NEXT_BUY_LEVEL_DEFAULT_VALUE = 0;
const string   NEXT_SELL_LEVEL = "nextSellLevel_";
const int      NEXT_SELL_LEVEL_DEFAULT_VALUE = 1000;
const string   NEXT_ENTRY_LEVEL = "nextEntryLevel_";

const string   CLOSED_BY_EQUITY_DD_OUT = "byEquityDD_Out_";
const string   CLOSED_BY_EQUITY_DD_OUT_STOP = "byEquityDD_OutAndStop";
const string   CLOSED_BY_GROUP_PROFIT = "byGroupProfitTBy_";
const string   CLOSED_BY_POSITION_PROFIT = "byPositionProfitTBy_";
const string   CLOSED_BY_POSITION_LOSS = "byPositionLossTBy_";
const string   CLOSED_BY_H1_OPTREND = "byH1OPTrendTBy_";
const string   CLOSED_BY_H2_ROTATION = "byH2RotationAresTBy_";
const string   CLOSED_BY_H2_OPOSITE_TREND = "byH2OpositeTrendTBy_";

const int      INITIAL_VALUE = 0;

const int      POSITIONGROUP_ID_TRIGGER_TICKET = 0;
const int      POSITIONGROUP_ID_TRIGGER_TICKET_ORDER_TYPE = 1;
const int      POSITIONGROUP_ID_TRIGGER_TICKET_VOLUME = 2;
const int      POSITIONGROUP_ID_TRIGGER_TICKET_2 = 3;
const int      POSITIONGROUP_ID_TRIGGER_ENTRY = 4;
const int      POSITIONGROUP_ID_HEDGE_TICKET = 5;
const int      POSITIONGROUP_ID_HEDGE_ENTRY = 6;
const int      POSITIONGROUP_ID_HEDGE_HEDGE_TICKET = 7;
const int      POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY = 8;
const int      POSITIONGROUP_ID_H3_TICKET = 9;
const int      POSITIONGROUP_ID_H3_ENTRY = 10;

const int      DEALGROUP_ID_TRIGGER_TICKET = 0;
const int      DEALGROUPPROFIT_ID_TRIGGER_TICKET = 0;
const int      DEALGROUPPROFIT_ID_PROFIT = 1;
const int      DEALGROUPPROFIT_DEFAULT_PROFIT = 0;
//+------------------------------------------------------------------+
