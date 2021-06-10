//+------------------------------------------------------------------+
//|                                           HandleHedgeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

// TODOs:
//    -

//Print("-----------------setHedgeReEntryLevel--------------------------------" );
//Print("hedgeTicket: " + hedgeTicket);
//Print("positionIsHedgeState(positionTicket): " + positionIsHedgeState(hedgeTicket));
//Print("positionIsOpenState(positionTicket): " + positionIsOpenState(hedgeTicket));
//printArrayTwoDimensions(positionGroups, ArrayRange(positionGroups, 0), 4);
//+------------------------------------------------------------------+

void handleHedgeHedgeAction() {

   setHedgeHedgeReEntryLevel();
   trailHedgeHedgeReEntryLevel();
   openHedgeHedgeReEntry();

}

void setHedgeHedgeReEntryLevel() {

   long    positionTriggerTicket = 0;
   long    hedgeHedgeTicket = 0;
   long    nextReEntryLevelPersist = 0;
   double   levelOffset = InpLevelOffset * Point();
   double   nextReEntryLevelTmp = 0;

   //ArraySort(positionTickets);
   for(int positionGroupsId = 0; positionGroupsId < ArrayRange(positionGroups, 0); positionGroupsId++) {
      hedgeHedgeTicket = positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_HEDGE_TICKET];

      if(
         hedgeHedgeTicket != 0 &&
         positionIsOpenState(hedgeHedgeTicket) == false
      ) {

         positionTriggerTicket = positionGroups[positionGroupsId][POSITIONGROUP_ID_TRIGGER_TICKET];
         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_BUY) {
            nextReEntryLevelPersist = (int)((Bid() + levelOffset) / Point());
         }

         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_SELL) {
            nextReEntryLevelPersist = (int)((Bid() - levelOffset) / Point());
         }

         positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_HEDGE_TICKET] = 0;
         positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY] = nextReEntryLevelPersist;

         nextReEntryLevelTmp = nextReEntryLevelPersist * Point();

         if(showObj(InpShowObjOnVisualMode) == true) {
            createHLine(NEXT_ENTRY_LEVEL + DoubleToString(positionTriggerTicket), nextReEntryLevelTmp, NEXT_ENTRY_LEVEL + " (" + DoubleToString(nextReEntryLevelTmp) + ")", clrBlack);
         }

      }
   }
}

//+------------------------------------------------------------------+
void trailHedgeHedgeReEntryLevel() {

   long    nextReEntryLevelPersist = 0;
   long    positionTriggerTicket = 0;
   double   nextReEntryLevelTmp = 0;
   double   levelOffset = InpLevelOffset * Point();
   
   int positionGroupsId = 0;
   for(positionGroupsId; positionGroupsId < ArrayRange(positionGroups, 0); positionGroupsId++) {

      nextReEntryLevelPersist = positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY];
      if(nextReEntryLevelPersist > 0) {
         positionTriggerTicket = positionGroups[positionGroupsId][POSITIONGROUP_ID_TRIGGER_TICKET];
         nextReEntryLevelTmp = nextReEntryLevelPersist * Point();
         
         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_SELL) {
            if(Bid() > (nextReEntryLevelTmp + levelOffset)) {
               nextReEntryLevelTmp = Bid() - levelOffset;
               nextReEntryLevelPersist = (int)(nextReEntryLevelTmp / Point());
               positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY] = nextReEntryLevelPersist;
               moveReEntryLevelObject(positionTriggerTicket, nextReEntryLevelTmp);
            }
         }

         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_BUY) {
            if(Bid() < (nextReEntryLevelTmp - levelOffset)) {
               nextReEntryLevelTmp = Bid() + levelOffset;
               nextReEntryLevelPersist = (int)(nextReEntryLevelTmp / Point());
               positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY] = nextReEntryLevelPersist;
               moveReEntryLevelObject(positionTriggerTicket, nextReEntryLevelTmp);
            }
         }
      }
   }
}

//+------------------------------------------------------------------+

void openHedgeHedgeReEntry() {

   long     nextReEntryLevelPersist = 0;
   long     positionTriggerTicket = 0;
   double   nextReEntryLevelTmp = 0;
   int      barShift = 0;

   int positionGroupsId = 0;
   for(positionGroupsId; positionGroupsId < ArrayRange(positionGroups, 0); positionGroupsId++) {

      nextReEntryLevelPersist = positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY];
      if(nextReEntryLevelPersist > 0) {
         positionTriggerTicket = positionGroups[positionGroupsId][POSITIONGROUP_ID_TRIGGER_TICKET];
         nextReEntryLevelTmp = nextReEntryLevelPersist * Point();

         if(Ask() < nextReEntryLevelTmp && getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_SELL && trend == DOWN_TREND) {
            openReEntryHedgeHedgeSellOrderAction(positionTriggerTicket);
            positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY] = 0;
         }

         if(Ask() > nextReEntryLevelTmp && getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_BUY && trend == UP_TREND) {
            openReEntryHedgeHedgeBuyOrderAction(positionTriggerTicket);
            positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY] = 0;
         }
      }
   }
}
//+------------------------------------------------------------------+
