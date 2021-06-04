//+------------------------------------------------------------------+
//|                                               DiverseActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void moveReEntryLevelObject(long pPositionTriggerTicket, double pNextReEntryLevelTmp) {

   int      chartId = 0;

   if(ObjectFind(chartId, NEXT_ENTRY_LEVEL + IntegerToString(pPositionTriggerTicket)) >= 0) {
      ObjectSetDouble(chartId, NEXT_ENTRY_LEVEL + IntegerToString(pPositionTriggerTicket), OBJPROP_PRICE, pNextReEntryLevelTmp);
      ObjectSetString(chartId, NEXT_ENTRY_LEVEL + IntegerToString(pPositionTriggerTicket), OBJPROP_TEXT, NEXT_ENTRY_LEVEL + " (" + DoubleToString(pNextReEntryLevelTmp) + ")");
   }
}
