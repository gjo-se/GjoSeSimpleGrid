/*

   EA GjoSeSimpleGridNextGeneration.mq5
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Version History
   ===============

   1.0.0 Initial version
   1.3.0 optimize Trend
   1.3.3 add H3
   1.4.0 add GWL
   1.4.1 GWL & SGL
   2.0.0 newVersion, maxSimple

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
#define   VERSION "2.0"
#property version VERSION
#property strict

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {

   initializeEAAction();
   initializeArraysAction();
   initializeGlobalsAction();
   initializeIndicatorsAction();

   cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);
   ReadPositionGroupsData();

   if(showObj(InpShowDashboardOnVisualMode) == true) {
      createDashboardCanvas();
      createDashboardAccountTable();
   }

   criterion_Ptr = new TCustomCriterionArray();
   if(CheckPointer(criterion_Ptr) == POINTER_INVALID) {
      return(-1);
   }
   criterion_Ptr.Add(new TTSSFCriterion());

   return(0);
}

void OnTick() {

   long positionTicket = 0;

//   long triggerTicketForHedgeBuyIn = 0;
//   long triggerTicketForHedgeSellIn = 0;
//   long triggerTicketForHedgeHedgeBuyIn = 0;
//   long triggerTicketForHedgeHedgeSellIn = 0;
//   long triggerTicketForH3BuyIn = 0;
//   long triggerTicketForH3SellIn = 0;

   bool tradeOnlyOnNewBar = checkTradeOnlyOnNewBar(InpTradeOnNewBar, InpNewBarTimeframe);


   if(NewM1Bar() == true) {
      M1_Bar.Update(Symbol(), PERIOD_M1);
   }

   closeActions();

   bool tradeOnlyOnTradingTime = checkTradeOnlyOnTradingTime(InpUseTimer, InpStartHour, InpStartMinute, InpEndHour, InpEndMinute, InpUseLocalTime);
   if( tradeOnlyOnNewBar == true &&  tradeOnlyOnTradingTime == true && securityStop == false) {

      cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);
      ArraySort(positionTickets);

      cleanPositionGroupsArrayAction();
      ArraySort(positionGroups);

      cleanDealGroupsArrayAndDealGroupProfitArrayAction();
      ArraySort(dealGroups);

      ArraySort(dealGroupProfit);

      if(ArraySize(positionTickets) > 0) {
         if(ArrayRange(positionGroups, 0) == 0) {
            buyIsTradeable = false;
            sellIsTradeable = false;
         } else {
            buyIsTradeable = true;
            sellIsTradeable = true;
         }
      }

      //Trigger
      if(getTriggerSellInSignalState() == true) openSellOrderAction();

   }
}

void OnDeinit(const int reason) {

   Comment("");
   WritePositionGroupsData();
   printMessages = true;

   Print(__FUNCTION__, " UninitializeReason() = ", getUninitReasonText(UninitializeReason()));
}

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double  OnTester() {
   double   param = 0.0;

// Balance max + min Drawdown + Trades Number:
   if(CheckPointer(criterion_Ptr) != POINTER_INVALID) {
      param = criterion_Ptr.GetCriterion();
   }

   return(param);
}
//+------------------------------------------------------------------+
