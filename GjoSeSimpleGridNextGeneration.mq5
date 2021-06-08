/*

   EA GjoSeSimpleGridNextGeneration.mq5
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Version History
   ===============

   1.0.0 Initial version
   1.3.0 optimize Trend
   1.3.3 add H3

   ===============

*/

//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include "Basics\\Includes.mqh"

//+------------------------------------------------------------------+
//| Headers                                                          |
//+------------------------------------------------------------------+
#property copyright   "2021, GjoSe"
#property link        "http://www.gjo-se.com"
#property description "GjoSe SimpleGrid"
#define   VERSION "1.3.3"
#property version VERSION
#property strict

datetime lastBarTime =  0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {

   initializeEAAction();
   initializeArraysAction();
   initializeGlobalsAction();
   initializeIndicatorsAction();

   if(showObj(InpShowDashboardOnVisualMode) == true) {
      createDashboardCanvas();
      createDashboardAccountTable();
   }

   resetAbsoluteEquityAction();

      criterion_Ptr = new TCustomCriterionArray();
      if(CheckPointer(criterion_Ptr) == POINTER_INVALID) {
         return(-1);
      }
      //criterion_Ptr.Add(new TSimpleCriterion( STAT_PROFIT ));
      //criterion_Ptr.Add(new TSimpleDivCriterion( STAT_EQUITY_DDREL_PERCENT ));

      criterion_Ptr.Add(new TTSSFCriterion());

   return(0);
}

// in Time verschieben
// mit anderen NewBar aufräumen
bool  NewBar() {

   datetime currentTime =  iTime(Symbol(), Period(), 0);
   bool     result      =  (currentTime != lastBarTime);
   lastBarTime   =   currentTime;

   return(result);

}

void OnTick() {

   long positionTicket = 0;

   long triggerTicketForHedgeBuyIn = 0;
   long triggerTicketForHedgeSellIn = 0;
   long triggerTicketForHedgeHedgeBuyIn = 0;
   long triggerTicketForHedgeHedgeSellIn = 0;
   long triggerTicketForH3BuyIn = 0;
   long  triggerTicketForH3SellIn = 0;

   bool tradeOnlyOnNewBar = checkTradeOnlyOnNewBar(InpTradeOnNewBar, InpNewBarTimeframe);



   //Print("--------------------------OnTick----positionTickets---------------");
   //printArrayOneDimension(positionTickets, ArraySize(positionTickets));
   //Print("--------------------------OnTick----positionGroups---------------");
   //printArrayTwoDimensions(positionGroups, ArrayRange(positionGroups, 0), 9);
   //Print("--------------------------OnTick----dealGroups---------------");
   //printArrayTwoDimensions(dealGroups, ArrayRange(dealGroups, 0), 20);
   //Print("--------------------------OnTick----dealGroupProfit---------------");
   //printArrayTwoDimensions(dealGroupProfit, ArrayRange(dealGroupProfit, 0), 2);

   if(NewBar() == true) {

      Bar.Update(Symbol(), Period());


      closePositionGroupInProfit();
      closePositionInProfit();
      //closeH2OnOpositeTrend();

      cleanPositionTicketsArrayAction();
      cleanPositionGroupsArrayAction();
      cleanDealGroupsArrayAndDealGroupProfitArrayAction();


      bool tradeOnlyOnTradingTime = checkTradeOnlyOnTradingTime(InpUseTimer, InpStartHour, InpStartMinute, InpEndHour, InpEndMinute, InpUseLocalTime);
      if( tradeOnlyOnNewBar == true &&  tradeOnlyOnTradingTime == true && securityStop == false) {

         ArraySort(positionTickets);
         ArraySort(positionGroups);
         ArraySort(dealGroups);
         ArraySort(dealGroupProfit);

         if(RelativeEquityDDGreaterThanMaxEquityDD_OutState () == true) {
            closeAllPositions(CLOSED_BY_EQUITY_DD_OUT);
            resetRelativeEquity();
         }


         // so jetzt definitv scheiße - zurückbauen oder gerade ziehen
         for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
            positionTicket = positionTickets[positionTicketId];

            // hier wird der Trigger nicht mehr aussortiert!
            if(InpUseBreakEven == true) setBreakevenAction(positionTicket);
         }

         //Trigger
         if(getTriggerBuyInSignalState() == true) openBuyOrderAction();
         if(getTriggerSellInSignalState() == true) openSellOrderAction();

         handleTriggerAction();

         //Hedge
         triggerTicketForHedgeBuyIn = getHedgeBuyInSignalState();
         if(triggerTicketForHedgeBuyIn > 0) openHedgeBuyOrderAction(triggerTicketForHedgeBuyIn);

         triggerTicketForHedgeSellIn = getHedgeSellInSignalState();
         if(triggerTicketForHedgeSellIn > 0) openHedgeSellOrderAction(triggerTicketForHedgeSellIn);

         handleHedgeAction();

         //HedgeHedge
         triggerTicketForHedgeHedgeBuyIn = getHedgeHedgeBuyInSignalState();
         if(triggerTicketForHedgeHedgeBuyIn > 0) openHedgeHedgeBuyOrderAction(triggerTicketForHedgeHedgeBuyIn);

         triggerTicketForHedgeHedgeSellIn = getHedgeHedgeSellInSignalState();
         if(triggerTicketForHedgeHedgeSellIn > 0) openHedgeHedgeSellOrderAction(triggerTicketForHedgeHedgeSellIn);

         handleHedgeHedgeAction();

         // H3
         triggerTicketForH3BuyIn = getH3BuyInSignalState();
         if(triggerTicketForH3BuyIn > 0) openH3BuyOrderAction(triggerTicketForH3BuyIn);

         triggerTicketForH3SellIn = getH3SellInSignalState();
         if(triggerTicketForH3SellIn > 0) openH3SellOrderAction(triggerTicketForH3SellIn);

         handleH3Action();


         if(getAbsoluteEquityDD(EQUITY_DD_PERCENT, InpMaxAbsoluteEquity) > InpMaxEquityDD_OutAndStop) {
            closeAllPositions(CLOSED_BY_EQUITY_DD_OUT_STOP);
            securityStop = true;
            TesterStop();
         }

         if(showObj(InpShowDashboardOnVisualMode) == true) {
            createDashboardCanvas();
            createDashboardAccountTable();
         }


         //Print("--------------------------OnTick----positionGroups---------------");
         //printArrayTwoDimensions(positionGroups, ArrayRange(positionGroups, 0), 11);
         //Print("--------------------------OnTick----dealGroups---------------");
         //printArrayTwoDimensions(dealGroups, ArrayRange(dealGroups, 0), 20);
         //Print("--------------------------OnTick----dealGroupProfit---------------");
         //printArrayTwoDimensions(dealGroupProfit, ArrayRange(dealGroupProfit, 0), 2);

      }

      ArraySetAsSeries(tickVolumeBuffer, true);
      CopyBuffer(tickvolumeHandle, TICK_VOLUME_BUFFER, 0, 300, tickVolumeBuffer);

      ArraySetAsSeries(sglTrendBuffer, true);
      CopyBuffer(sglTrendHandle, SGL_TREND_BUFFER, 0, 10, sglTrendBuffer);

   }
}

void OnDeinit(const int reason) {

   Comment("");

   Print(__FUNCTION__, " UninitializeReason() = ", getUninitReasonText(UninitializeReason()));
}

//+------------------------------------------------------------------+

double  OnTester() {
   double   param = 0.0;

// Balance max + min Drawdown + Trades Number:
   if(CheckPointer(criterion_Ptr) != POINTER_INVALID) {
      param = criterion_Ptr.GetCriterion();
   }

   return(param);
}