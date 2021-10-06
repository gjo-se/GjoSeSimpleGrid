//+------------------------------------------------------------------+
//|                                           HandleHedgeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//
//void handleHedgeAction() {
//
//   setHedgeReEntryLevel();
//   trailHedgeReEntryLevel();
//   openHedgeReEntry();
//
//}
//
//void setHedgeReEntryLevel() {
//
//   long    positionTriggerTicket = 0;
//   long    hedgeTicket = 0;
//   long    nextReEntryLevelPersist = 0;
//   double   levelOffset = InpLevelOffset * Point();
//   double   nextReEntryLevelTmp = 0;
//
//   for(int positionGroupsId = 0; positionGroupsId < ArrayRange(positionGroups, 0); positionGroupsId++) {
//      hedgeTicket = positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_TICKET];
//
//      if(
//         hedgeTicket != 0 &&
//         positionIsOpenState(hedgeTicket) == false
//      ) {
//
//         positionTriggerTicket = positionGroups[positionGroupsId][POSITIONGROUP_ID_TRIGGER_TICKET];
//         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_BUY) {
//            nextReEntryLevelPersist = (int)((Bid() - levelOffset) / Point());
//         }
//
//         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_SELL) {
//            nextReEntryLevelPersist = (int)((Bid() + levelOffset) / Point());
//         }
//
//         positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_TICKET] = 0;
//         positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_ENTRY] = nextReEntryLevelPersist;
//
//         nextReEntryLevelTmp = nextReEntryLevelPersist * Point();
//
//         if(showObj(InpShowObjOnVisualMode) == true) {
//            createHLine(NEXT_ENTRY_LEVEL + DoubleToString(positionTriggerTicket), nextReEntryLevelTmp, NEXT_ENTRY_LEVEL + " (" + DoubleToString(nextReEntryLevelTmp) + ")", clrBlack);
//         }
//
//      }
//   }
//}
//
////+------------------------------------------------------------------+
//void trailHedgeReEntryLevel() {
//
//   long    nextReEntryLevelPersist = 0;
//   long    positionTriggerTicket = 0;
//   double   nextReEntryLevelTmp = 0;
//   double   levelOffset = InpLevelOffset * Point();
//
//   int positionGroupsId = 0;
//   for(positionGroupsId; positionGroupsId < ArrayRange(positionGroups, 0); positionGroupsId++) {
//
//      nextReEntryLevelPersist = positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_ENTRY];
//      if(nextReEntryLevelPersist > 0) {
//         positionTriggerTicket = positionGroups[positionGroupsId][POSITIONGROUP_ID_TRIGGER_TICKET];
//         nextReEntryLevelTmp = nextReEntryLevelPersist * Point();
//
//         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_BUY) {
//            if(Bid() > (nextReEntryLevelTmp + levelOffset)) {
//               nextReEntryLevelTmp = Bid() - levelOffset;
//               nextReEntryLevelPersist = (int)(nextReEntryLevelTmp / Point());
//               positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_ENTRY] = nextReEntryLevelPersist;
//               moveReEntryLevelObject(positionTriggerTicket, nextReEntryLevelTmp);
//            }
//         }
//
//         if(getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_SELL) {
//            if(Bid() < (nextReEntryLevelTmp - levelOffset)) {
//               nextReEntryLevelTmp = Bid() + levelOffset;
//               nextReEntryLevelPersist = (int)(nextReEntryLevelTmp / Point());
//               positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_ENTRY] = nextReEntryLevelPersist;
//               moveReEntryLevelObject(positionTriggerTicket, nextReEntryLevelTmp);
//            }
//         }
//      }
//   }
//}
//
////+------------------------------------------------------------------+
//
//void openHedgeReEntry() {
//
//   long     nextReEntryLevelPersist = 0;
//   long     positionTriggerTicket = 0;
//   double   nextReEntryLevelTmp = 0;
//   int      barShift = 0;
//
//   int positionGroupsId = 0;
//   for(positionGroupsId; positionGroupsId < ArrayRange(positionGroups, 0); positionGroupsId++) {
//
//      nextReEntryLevelPersist = positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_ENTRY];
//      if(nextReEntryLevelPersist > 0) {
//         positionTriggerTicket = positionGroups[positionGroupsId][POSITIONGROUP_ID_TRIGGER_TICKET];
//         nextReEntryLevelTmp = nextReEntryLevelPersist * Point();
//
//         if(Ask() < nextReEntryLevelTmp && getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_BUY && trend == DOWN_TREND) {
//            openReEntryHedgeSellOrderAction(positionTriggerTicket);
//            positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_ENTRY] = 0;
//         }
//
//         if(Ask() > nextReEntryLevelTmp && getPositionTypeByPositionTicket(positionTriggerTicket) == ORDER_TYPE_SELL && trend == UP_TREND) {
//            openReEntryHedgeBuyOrderAction(positionTriggerTicket);
//            positionGroups[positionGroupsId][POSITIONGROUP_ID_HEDGE_ENTRY] = 0;
//         }
//      }
//   }
//}
////+------------------------------------------------------------------+
