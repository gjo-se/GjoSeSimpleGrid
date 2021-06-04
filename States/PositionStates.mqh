/*

   PositionStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   State-Beschreibung
   ===============

   POSITIONGROUP_ID_TRIGGER_TICKET = 0;
   POSITIONGROUP_ID_HEDGE_TICKET = 1;
   POSITIONGROUP_ID_HEDGE_ENTRY = 2;
   POSITIONGROUP_ID_HEDGE_HEDGE = 3;
   POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY = 4;

                                 0  1  2  3  4
   positionIsTriggerState:       1  -  -  -  -
   triggerIsHedgedState:         1& 1| 1  -  -
   positionIsHedgeState:         -  1| 1  -  -
   hedgeIsHedgedState:           -  1& -  1| 1
   positionIsHedgeHedgeState:    -  -  -  1| 1

   ===============

*/

ENUM_ORDER_TYPE getPositionTypeByPositionTicket(long pTriggerTicket) {

   int positionGroupId = 0;

   positionGroupId = ArrayBsearch(positionGroups, pTriggerTicket);

   if(positionGroupId >= 0) {
      if(positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET] == pTriggerTicket) {

         return ((ENUM_ORDER_TYPE)positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET_ORDER_TYPE]);
      }
   }

   return((ENUM_ORDER_TYPE)NOT_FOUND);
}

double getPositionVolumeByPositionTicket(long pTriggerTicket) {

   int      positionGroupId = 0;
   double   volume = 0;

   positionGroupId = ArrayBsearch(positionGroups, pTriggerTicket);

   if(positionGroupId >= 0) {
      if(positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET] == pTriggerTicket) {
         volume = (double)positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET_VOLUME] / 100;

         return (NormalizeDouble(volume, 2));
      }
   }

   return(NOT_FOUND);
}

int getPositionGroupIdByPositionTicket(long positionTicket) {

   for(int i = 0; i < ArrayRange(positionGroups, 0); i++) {
      for(int j = 0; j < ArrayRange(positionGroups, 1); j++) {
         if(positionGroups[i][j] == positionTicket) return(i);
      }
   }

   return(NOT_FOUND);
}

int getDealGroupIdByPositionTicket(long positionTicket) {

   for(int i = 0; i < ArrayRange(dealGroups, 0); i++) {
      for(int j = 0; j < ArrayRange(dealGroups, 1); j++) {
         if(dealGroups[i][j] == positionTicket) return(i);
      }
   }

   return(NOT_FOUND);
}
//+------------------------------------------------------------------+

int getDealGroupIdByTriggerTicket(long pTriggerTicket) {

   int dealGroupsId = 0;

   dealGroupsId = ArrayBsearch(dealGroups, pTriggerTicket);

   if(dealGroupsId >= 0) {
      if(dealGroups[dealGroupsId][DEALGROUP_ID_TRIGGER_TICKET] == pTriggerTicket) return (dealGroupsId);
   }

   return(NOT_FOUND);
}

int getCurrentDealGroupProfitByTriggerTicket(long pTriggerTicket) {

   int dealGroupsProfitId = 0;
   int currentDealGroupProfit = 0;

//ArraySort(dealGroupProfit);
   dealGroupsProfitId = ArrayBsearch(dealGroupProfit, pTriggerTicket);

   if(dealGroupsProfitId >= 0) {
      if(dealGroupProfit[dealGroupsProfitId][DEALGROUPPROFIT_ID_TRIGGER_TICKET] == pTriggerTicket) {
         currentDealGroupProfit = (int)dealGroupProfit[dealGroupsProfitId][DEALGROUPPROFIT_ID_PROFIT];

         return (currentDealGroupProfit);
      }
   }

   return(NOT_FOUND);
}

void setCurrentDealGroupProfit(long pTriggerTicket, int pDealGroupHistoryProfit) {

   int dealGroupsProfitId = 0;

//ArraySort(dealGroupProfit);
   dealGroupsProfitId = ArrayBsearch(dealGroupProfit, pTriggerTicket);

   if(dealGroupsProfitId >= 0) {
      if(dealGroupProfit[dealGroupsProfitId][DEALGROUPPROFIT_ID_TRIGGER_TICKET] == pTriggerTicket) {
         dealGroupProfit[dealGroupsProfitId][DEALGROUPPROFIT_ID_PROFIT] = pDealGroupHistoryProfit;
      }
   }
}

long getTriggerTicketByPositionTicket(long pPositionTicket) {

   int dealGroupsId = 0;
   long triggerTicket = 0;

   dealGroupsId = getDealGroupIdByPositionTicket(pPositionTicket);

   if(dealGroupsId >= 0) {
      triggerTicket = dealGroups[dealGroupsId][DEALGROUP_ID_TRIGGER_TICKET];
   }

   return(triggerTicket);
}

bool positionIsOpenState(long pPositionTicket) {

   long positionTicket = 0;

   if(pPositionTicket != 0) {

      for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
         positionTicket = positionTickets[positionTicketId];
         if(positionTicket == pPositionTicket)
            return(true);
      }
   }
   return(false);
}

bool positionIsTriggerState(long pPositionTicket) {

   int positionGroupId = getPositionGroupIdByPositionTicket(pPositionTicket);

//ArraySort(positionGroups);
   if(positionGroupId != NOT_FOUND) {
      if(pPositionTicket == positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET]) {
         return(true);
      }
   }

   return(false);
}

bool triggerIsHedgedState(long pPositionTicket) {

   int positionGroupId = getPositionGroupIdByPositionTicket(pPositionTicket);

   if(positionGroupId != NOT_FOUND) {
      if(
         pPositionTicket == positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET] &&
         (positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_TICKET] != 0 ||
          positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_ENTRY] != 0)
      ) {
         return(true);
      }
   }

   return(false);
}

bool positionIsHedgeState(long pPositionTicket) {

   int positionGroupId = getPositionGroupIdByPositionTicket(pPositionTicket);

   if(positionGroupId != NOT_FOUND) {
      if(
         pPositionTicket == positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_TICKET] ||
         positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_ENTRY] != 0
      ) {
         return(true);
      }
   }

   return(false);
}

bool hedgeIsHedgedState(long pPositionTicket) {

   int positionGroupId = getPositionGroupIdByPositionTicket(pPositionTicket);

   if(positionGroupId != NOT_FOUND) {
      if(
         pPositionTicket == positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_TICKET] &&
         (positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_HEDGE_TICKET] != 0 ||
          positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY] != 0)
      ) {
         return(true);
      }
   }

   return(false);
}

bool positionIsHedgeHedgeState(long pPositionTicket) {

   int positionGroupId = getPositionGroupIdByPositionTicket(pPositionTicket);

   if(positionGroupId != NOT_FOUND) {
      if(
         positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_HEDGE_TICKET] != 0 ||
         positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY] != 0
      ) {
         return(true);
      }
   }

   return(false);
}
//+------------------------------------------------------------------+
