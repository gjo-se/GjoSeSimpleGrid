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
         pPositionTicket == positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_TICKET]
          // || positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_ENTRY] != 0
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
      if(pPositionTicket == positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_HEDGE_TICKET]) {
         return(true);
      }
   }

   return(false);
}
//+------------------------------------------------------------------+

bool hedgeHedgeIsHedgedState(long pPositionTicket) {

   int positionGroupId = getPositionGroupIdByPositionTicket(pPositionTicket);

   if(positionGroupId != NOT_FOUND) {
      if(
         pPositionTicket == positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_HEDGE_TICKET] &&
         (positionGroups[positionGroupId][POSITIONGROUP_ID_H3_TICKET] != 0 ||
          positionGroups[positionGroupId][POSITIONGROUP_ID_H3_ENTRY] != 0)
      ) {
         return(true);
      }
   }

   return(false);
}