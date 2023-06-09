/*

   HedgeSellInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

long getHedgeSellInSignalState() {

   long positionTicket = 0;
   int barShift = 0;
   long returnValue = 0;
   
   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      
      if(
         getPositionTypeByPositionTicket(positionTicket) == ORDER_TYPE_BUY &&
         positionIsTriggerState(positionTicket) == true &&
         triggerIsHedgedState(positionTicket) == false &&
         //hedgeIsHedgedState(positionTicket) == false &&
         trend == DOWN_TREND
      ) {
         returnValue = positionTicket;
      }
   }
   
   return(returnValue);

}
//+------------------------------------------------------------------+

long getHedgeHedgeSellInSignalState() {

   long positionTicket = 0;
   int barShift = 0;
   long returnValue = 0;
   
   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      
      if(
         PositionType(positionTicket) == ORDER_TYPE_BUY &&
         //positionIsTriggerState(positionTicket) == false &&
         positionIsHedgeState(positionTicket) == true &&
         hedgeIsHedgedState(positionTicket) == false &&
         positionIsHedgeHedgeState(positionTicket) == false &&
         trend == DOWN_TREND
      ) {
         returnValue = positionTicket;
      }
   }
   
   return(returnValue);

}
//+------------------------------------------------------------------+
long getH3SellInSignalState() {

   long positionTicket = 0;
   int barShift = 0;
   long returnValue = 0;

   for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];

      if(
         PositionType(positionTicket) == ORDER_TYPE_BUY &&
         positionIsHedgeHedgeState(positionTicket) == true &&
         hedgeHedgeIsHedgedState(positionTicket) == false &&
         trend == DOWN_TREND
      ) {
         returnValue = positionTicket;
      }
   }

   return(returnValue);

}