//+------------------------------------------------------------------+
//|                                             BreakevenAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void setBreakevenAction(long pPositionTicket) {

   if(positionIsTriggerState(pPositionTicket) == true) {
      Trail.BreakEven(pPositionTicket, InpBreakEvenProfit, InpLockProfit);
   }
   //if(positionIsHedgeState(pPositionTicket) == true) {
   //   Trail.BreakEven(pPositionTicket, InpBreakEvenProfit, InpLockProfit);
   //}
}
//+------------------------------------------------------------------+

void setTrailingStopAction(long pPositionTicket) {

   if(positionIsTriggerState(pPositionTicket) == true) {
      Trail.TrailingStop(pPositionTicket, InpTrailingStop, InpTrailingMinimumProfit, InpTrailingStep);
   }
}