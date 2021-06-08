//+------------------------------------------------------------------+
//|                                           HandleHedgeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void handleH3Action() {

   setH3ReEntryLevel();
   trailH3ReEntryLevel();
   openH3ReEntry();

}

void setH3ReEntryLevel() {

   long    positionTriggerTicket = 0;
   long    h3Ticket = 0;
   long    nextReEntryLevelPersist = 0;
   double   levelOffset = InpLevelOffset * Point();
   double   nextReEntryLevelTmp = 0;

   for(int positionGroupsId = 0; positionGroupsId < ArrayRange(positionGroups, 0); positionGroupsId++) {
      h3Ticket = positionGroups[positionGroupsId][POSITIONGROUP_ID_H3_TICKET];

      if(
         h3Ticket != 0 &&
         positionIsOpenState(h3Ticket) == false
      ) {

         positionTriggerTicket = positionGroups[positionGroupsId][POSITIONGROUP_ID_TRIGGER_TICKET];
         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_BUY) {
            nextReEntryLevelPersist = (int)((Bid() - levelOffset) / Point());
         }

         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_SELL) {
            nextReEntryLevelPersist = (int)((Bid() + levelOffset) / Point());
         }

         positionGroups[positionGroupsId][POSITIONGROUP_ID_H3_TICKET] = 0;
         positionGroups[positionGroupsId][POSITIONGROUP_ID_H3_ENTRY] = nextReEntryLevelPersist;

         nextReEntryLevelTmp = nextReEntryLevelPersist * Point();

         if(showObj(InpShowObjOnVisualMode) == true) {
            createHLine(NEXT_ENTRY_LEVEL + DoubleToString(positionTriggerTicket), nextReEntryLevelTmp, NEXT_ENTRY_LEVEL + " (" + DoubleToString(nextReEntryLevelTmp) + ")", clrBlack);
         }

      }
   }
}

//+------------------------------------------------------------------+
void trailH3ReEntryLevel() {

   long    nextReEntryLevelPersist = 0;
   long    positionTriggerTicket = 0;
   double   nextReEntryLevelTmp = 0;
   double   levelOffset = InpLevelOffset * Point();

   for(int positionGroupsId = 0; positionGroupsId < ArrayRange(positionGroups, 0); positionGroupsId++) {

      nextReEntryLevelPersist = positionGroups[positionGroupsId][POSITIONGROUP_ID_H3_ENTRY];
      if(nextReEntryLevelPersist > 0) {
         positionTriggerTicket = positionGroups[positionGroupsId][POSITIONGROUP_ID_TRIGGER_TICKET];
         nextReEntryLevelTmp = nextReEntryLevelPersist * Point();

         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_BUY) {
            if(Bid() > (nextReEntryLevelTmp + levelOffset)) {
               nextReEntryLevelTmp = Bid() - levelOffset;
               nextReEntryLevelPersist = (int)(nextReEntryLevelTmp / Point());
               positionGroups[positionGroupsId][POSITIONGROUP_ID_H3_ENTRY] = nextReEntryLevelPersist;
               moveReEntryLevelObject(positionTriggerTicket, nextReEntryLevelTmp);
            }
         }

         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_SELL) {
            if(Bid() < (nextReEntryLevelTmp - levelOffset)) {
               nextReEntryLevelTmp = Bid() + levelOffset;
               nextReEntryLevelPersist = (int)(nextReEntryLevelTmp / Point());
               positionGroups[positionGroupsId][POSITIONGROUP_ID_H3_ENTRY] = nextReEntryLevelPersist;
               moveReEntryLevelObject(positionTriggerTicket, nextReEntryLevelTmp);
            }
         }
      }
   }
}

//+------------------------------------------------------------------+

void openH3ReEntry() {

   long     nextReEntryLevelPersist = 0;
   long     positionTriggerTicket = 0;
   double   nextReEntryLevelTmp = 0;
   int      barShift = 0;

   for(int positionGroupsId = 0; positionGroupsId < ArrayRange(positionGroups, 0); positionGroupsId++) {
      nextReEntryLevelPersist = positionGroups[positionGroupsId][POSITIONGROUP_ID_H3_ENTRY];

      if(nextReEntryLevelPersist > 0) {
         positionTriggerTicket = positionGroups[positionGroupsId][POSITIONGROUP_ID_TRIGGER_TICKET];
         nextReEntryLevelTmp = nextReEntryLevelPersist * Point();

         if(Ask() < nextReEntryLevelTmp && getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_BUY && sglTrendBuffer[barShift] < InpMinTrendStrength *-1) {
            openReEntryH3SellOrderAction(positionTriggerTicket);
            positionGroups[positionGroupsId][POSITIONGROUP_ID_H3_ENTRY] = 0;
         }

         if(Ask() > nextReEntryLevelTmp && getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_SELL && sglTrendBuffer[barShift] > InpMinTrendStrength) {
            openReEntryH3BuyOrderAction(positionTriggerTicket);
            positionGroups[positionGroupsId][POSITIONGROUP_ID_H3_ENTRY] = 0;

         }
      }
   }
}
//+------------------------------------------------------------------+
