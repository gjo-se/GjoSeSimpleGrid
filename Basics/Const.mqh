//+------------------------------------------------------------------+
//|                                                        Const.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

const double   LOWEST_PRICE = EMPTY_VALUE;
const double   HIGHEST_PRICE = 0;
const int      NOT_FOUND = -1;

const int      TICK_VOLUME_BUFFER = 0;
const int      GWL_TREND_BUFFER = 0;
const int      SGL_TREND_BUFFER = 0;

const int      UP_TREND = 1;
const int      DOWN_TREND = -1;
const int      ROTATION_AREA = 0;

const string   NEXT_BUY_LEVEL = "nextBuyLevel_";
const int      NEXT_BUY_LEVEL_DEFAULT_VALUE = 0;
const string   NEXT_SELL_LEVEL = "nextSellLevel_";
const int      NEXT_SELL_LEVEL_DEFAULT_VALUE = 100;
const string   NEXT_ENTRY_LEVEL = "nextEntryLevel_";

const string   CLOSED_BY_EQUITY_DD_OUT = "byEquityDD_Out_";
const string   CLOSED_BY_EQUITY_DD_OUT_STOP = "byEquityDD_OutAndStop";
const string   CLOSED_BY_GROUP_PROFIT = "byGroupProfitTBy_";
const string   CLOSED_BY_POSITION_PROFIT = "byPositionProfitTBy_";
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
