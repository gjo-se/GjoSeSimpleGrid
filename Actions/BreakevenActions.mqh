//+------------------------------------------------------------------+
//|                                             BreakevenActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void setBreakevenAction(long pPositionTicket) {
   Trail.BreakEven(pPositionTicket, InpBreakEvenProfit, InpLockProfit);
}
//+------------------------------------------------------------------+
