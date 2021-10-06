//+------------------------------------------------------------------+
//|                                            CleanArraysAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

// now defined in Mql5Book/TradeHedge.mqh
//void cleanPositionTicketsArrayAction() {
//
//   initializeArray(positionTickets, 100000);
//   Positions.GetTickets(InpMagicNumber, positionTickets);
//}

void cleanPositionGroupsArrayAction() {

   long triggerTicket = 0;
   long triggerTicketOrderType = 0;
   long triggerTicketVolume = 0;
   long triggerTicket2 = 0;
   long nextTriggerLevel = 0;
   long hedgeTicket = 0;
   long nextHedgeLevel = 0;
   long hedgeHedgeTicket = 0;
   long nextHedgeHedgeLevel = 0;
   long h3Ticket = 0;
   long nextH3Level = 0;
   int arrayRange = 0;

   ArrayCopy(positionGroupsTmp, positionGroups);
   initializeArray(positionGroups);

   int groupId = 0;
   for( groupId; groupId < ArrayRange(positionGroupsTmp, 0); groupId++) {
      triggerTicket = positionGroupsTmp[groupId][POSITIONGROUP_ID_TRIGGER_TICKET];
      triggerTicketOrderType = positionGroupsTmp[groupId][POSITIONGROUP_ID_TRIGGER_TICKET_ORDER_TYPE];
      triggerTicketVolume = positionGroupsTmp[groupId][POSITIONGROUP_ID_TRIGGER_TICKET_VOLUME];
      triggerTicket2 = positionGroupsTmp[groupId][POSITIONGROUP_ID_TRIGGER_TICKET_2];
      nextTriggerLevel = positionGroupsTmp[groupId][POSITIONGROUP_ID_TRIGGER_ENTRY];
      hedgeTicket = positionGroupsTmp[groupId][POSITIONGROUP_ID_HEDGE_TICKET];
      nextHedgeLevel = positionGroupsTmp[groupId][POSITIONGROUP_ID_HEDGE_ENTRY];
      hedgeHedgeTicket = positionGroupsTmp[groupId][POSITIONGROUP_ID_HEDGE_HEDGE_TICKET];
      nextHedgeHedgeLevel = positionGroupsTmp[groupId][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY];
      h3Ticket = positionGroupsTmp[groupId][POSITIONGROUP_ID_H3_TICKET];
      nextH3Level = positionGroupsTmp[groupId][POSITIONGROUP_ID_H3_ENTRY];

      if(   positionIsOpenState(triggerTicket) == true ||
            positionIsOpenState(triggerTicket2) == true ||
            positionIsOpenState(hedgeTicket) == true ||
            positionIsOpenState(hedgeHedgeTicket) == true
        ) {

         arrayRange = ArrayRange(positionGroups, 0);
         ArrayResize(positionGroups, arrayRange + 1);
         positionGroups[arrayRange][POSITIONGROUP_ID_TRIGGER_TICKET] = triggerTicket;
         positionGroups[arrayRange][POSITIONGROUP_ID_TRIGGER_TICKET_ORDER_TYPE] = triggerTicketOrderType;
         positionGroups[arrayRange][POSITIONGROUP_ID_TRIGGER_TICKET_VOLUME] = triggerTicketVolume;
         positionGroups[arrayRange][POSITIONGROUP_ID_TRIGGER_TICKET_2] = triggerTicket2;
         positionGroups[arrayRange][POSITIONGROUP_ID_TRIGGER_ENTRY] = nextTriggerLevel;
         
         if(positionIsOpenState(hedgeTicket) == true){
            positionGroups[arrayRange][POSITIONGROUP_ID_HEDGE_TICKET] = hedgeTicket;
         }else{
            positionGroups[arrayRange][POSITIONGROUP_ID_HEDGE_TICKET] = 0;
         }
         
         positionGroups[arrayRange][POSITIONGROUP_ID_HEDGE_ENTRY] = nextHedgeLevel;
         positionGroups[arrayRange][POSITIONGROUP_ID_HEDGE_HEDGE_TICKET] = hedgeHedgeTicket;
         positionGroups[arrayRange][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY] = nextHedgeHedgeLevel;
         positionGroups[arrayRange][POSITIONGROUP_ID_H3_TICKET] = h3Ticket;
         positionGroups[arrayRange][POSITIONGROUP_ID_H3_ENTRY] = nextH3Level;
      }
   }

   initializeArray(positionGroupsTmp, 100000);
}

void cleanDealGroupsArrayAndDealGroupProfitArrayAction() {

   long  positionTicket = 0;
   bool  dealGroupIsOpen;
   long  triggerTicketDealGroups = 0;
   int   foundDealGroupProfitIndex = 0;

   ArrayCopy(dealGroupsTmp, dealGroups);
   ArrayCopy(dealGroupProfitTmp, dealGroupProfit);
   initializeArray(dealGroups);
   initializeArray(dealGroupProfit);

   ArraySort(dealGroupsTmp);

   for(int dealGroupId = 0; dealGroupId < ArrayRange(dealGroupsTmp, 0); dealGroupId++) {
      
      dealGroupIsOpen = false;
      for(int positionId = 0; positionId < ArrayRange(dealGroupsTmp, 1); positionId++) {
         positionTicket = dealGroupsTmp[dealGroupId][positionId];

         if(positionTicket > 0) {
            if(positionIsOpenState(positionTicket) == true) {
               dealGroupIsOpen = true;
            } else {
               if(dealGroupsTmp[dealGroupId][DEALGROUP_ID_TRIGGER_TICKET] != positionTicket){
                  dealGroupsTmp[dealGroupId][positionId] = 0;
               } 
            }
         }
      }

      if(dealGroupIsOpen == true) {
         ArrayResize(dealGroups, ArrayRange(dealGroups, 0) + 1);
         for(int positionId = 0; positionId < ArrayRange(dealGroupsTmp, 1); positionId++) {
            dealGroups[ArrayRange(dealGroups, 0) - 1][positionId] = dealGroupsTmp[dealGroupId][positionId];
         }

         triggerTicketDealGroups = dealGroupsTmp[dealGroupId][DEALGROUP_ID_TRIGGER_TICKET];
         if(triggerTicketDealGroups != 0) {
            foundDealGroupProfitIndex = ArrayBsearch(dealGroupProfitTmp, triggerTicketDealGroups);
            if(triggerTicketDealGroups == dealGroupProfitTmp[foundDealGroupProfitIndex][DEALGROUPPROFIT_ID_TRIGGER_TICKET]) {
               ArrayResize(dealGroupProfit, ArrayRange(dealGroupProfit, 0) + 1);
               dealGroupProfit[ArrayRange(dealGroupProfit, 0) - 1][DEALGROUPPROFIT_ID_TRIGGER_TICKET] = triggerTicketDealGroups;
               dealGroupProfit[ArrayRange(dealGroupProfit, 0) - 1][DEALGROUPPROFIT_ID_PROFIT] = dealGroupProfitTmp[foundDealGroupProfitIndex][DEALGROUPPROFIT_ID_PROFIT];

            }
         }
      }
   }

   initializeArray(dealGroupsTmp);
   initializeArray(dealGroupProfitTmp);
}
//+------------------------------------------------------------------+
