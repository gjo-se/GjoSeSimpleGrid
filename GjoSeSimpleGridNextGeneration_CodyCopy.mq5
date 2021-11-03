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

// defined in Mql5Book/Timer.mqh
// datetime lastBarTime =  0;

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

//   if(showObj(InpShowDashboardOnVisualMode) == true) {
//      createDashboardCanvas();
//      createDashboardAccountTable();
//   }

   //resetAbsoluteEquityAction();

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
// defined in Mql5Book/Timer.mqh
//bool  NewBar() {
//
//   datetime currentTime =  iTime(Symbol(), InpNewBarTimeframe, 0);
//   bool     result      =  (currentTime != lastBarTime);
//   lastBarTime   =   currentTime;
//
//   return(result);
//
//}

void OnTick() {

   long positionTicket = 0;

   long triggerTicketForHedgeBuyIn = 0;
   long triggerTicketForHedgeSellIn = 0;
   long triggerTicketForHedgeHedgeBuyIn = 0;
   long triggerTicketForHedgeHedgeSellIn = 0;
   long triggerTicketForH3BuyIn = 0;
   long triggerTicketForH3SellIn = 0;

   bool tradeOnlyOnNewBar = checkTradeOnlyOnNewBar(InpTradeOnNewBar, InpNewBarTimeframe);

   //Trade on newBar Logik:
   // open:
   //   - hier bringt mir das abwarten auf eine neue Bar auch nichts,
   // close:
   //   - immer und zu jeder Zeit, wenn Signal eintrifft, schließen

//closeAgainMonsterMove();

//Print("--------------------------OnTick----positionTickets---------------");
//printArrayOneDimension(positionTickets, ArraySize(positionTickets));
//Print("--------------------------OnTick----positionGroups---------------");
//printArrayTwoDimensions(positionGroups, ArrayRange(positionGroups, 0), 9);
//Print("--------------------------OnTick----dealGroups---------------");
//printArrayTwoDimensions(dealGroups, ArrayRange(dealGroups, 0), 20);
//Print("--------------------------OnTick----dealGroupProfit---------------");
//printArrayTwoDimensions(dealGroupProfit, ArrayRange(dealGroupProfit, 0), 2);

   if(NewM1Bar() == true) {
      M1_Bar.Update(Symbol(), PERIOD_M1);
   }

   // die Close sollte unabhängig von der Tradingzeit sein
   closePositionGroupInProfit();

   //closePositionInLoss();
   //      closePositionInProfit();
   //closeHedgeOnOpositeTrend();
   //closeH1OnSameTrend();

   // TODO: neu bearbeiten
   //closeOnRotationArea();
   //closeOnLocalHighestHigh();
   //closeOnSGLMaxDynamic();
   //closeOnSGLOpositeTrend();
   // closeOnTrendline();



   bool tradeOnlyOnTradingTime = checkTradeOnlyOnTradingTime(InpUseTimer, InpStartHour, InpStartMinute, InpEndHour, InpEndMinute, InpUseLocalTime);
   if( tradeOnlyOnNewBar == true &&  tradeOnlyOnTradingTime == true && securityStop == false) {
      //if( tradeOnlyOnTradingTime == true && securityStop == false) {

//      Print("--------------------------OnTick----positionTickets---------------");
//      printArrayOneDimension(positionTickets, ArraySize(positionTickets));

      cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);
      ArraySort(positionTickets);


      cleanPositionGroupsArrayAction();
      ArraySort(positionGroups);

      if(ArraySize(positionTickets) > 0) {
         if(ArrayRange(positionGroups, 0) == 0) {
            buyIsTradeable = false;
            sellIsTradeable = false;
            //Print("sellIsTradeableArrayRange: " + sellIsTradeable + " // " + ArrayRange(positionGroups, 0));
         } else {
            buyIsTradeable = true;
            sellIsTradeable = true;
            //Print("sellIsTradeableArrayRange: " + sellIsTradeable);
         }
      }

      if(printMessages == true) {
         Print("Time: " + M1_Bar.Time());
//
         Print("--------------------------OnTick----positionTickets---------------: " + ArraySize(positionTickets));
         printArrayOneDimension(positionTickets, ArraySize(positionTickets));
         Print("--------------------------OnTick----positionGroups---------------: " + ArrayRange(positionGroups, 0));
         printArrayTwoDimensions(positionGroups, ArrayRange(positionGroups, 0), 9);
         printMessages = false;
//
      }


//         Print("--------------------------OnTick----positionGroups---------------: " + ArrayRange(positionGroups, 0));
//         printArrayTwoDimensions(positionGroups, ArrayRange(positionGroups, 0), 9);




      cleanDealGroupsArrayAndDealGroupProfitArrayAction();
      ArraySort(dealGroups);

      ArraySort(dealGroupProfit);



      //if(RelativeEquityDDGreaterThanMaxEquityDD_OutState () == true) {
      //   closeAllPositions(CLOSED_BY_EQUITY_DD_OUT);
      //   resetRelativeEquity();
      //}


      // so jetzt definitv scheiße - zurückbauen oder gerade ziehen
//      for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//         positionTicket = positionTickets[positionTicketId];
//         if(InpUseBreakEven == true) setBreakevenAction(positionTicket);
//      }
//
//      for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//         positionTicket = positionTickets[positionTicketId];
//         if(InpUseTrailingStop == true) setTrailingStopAction(positionTicket);
//      }

      //getHedgeBuyInSignalState();


      //Trigger
      //if(getTriggerBuyInSignalState() == true) openBuyOrderAction();
      if(getTriggerSellInSignalState() == true) openSellOrderAction();

      //handleTriggerAction();

      //Hedge
      //triggerTicketForHedgeBuyIn =

      //if(triggerTicketForHedgeBuyIn > 0) {
      //   openHedgeBuyOrderAction(triggerTicketForHedgeBuyIn);
      //   newHedgeIsSet = true;
      //}


//
//         triggerTicketForHedgeSellIn = getHedgeSellInSignalState();
//         if(triggerTicketForHedgeSellIn > 0) openHedgeSellOrderAction(triggerTicketForHedgeSellIn);

      //handleHedgeAction();

      //HedgeHedge
//         triggerTicketForHedgeHedgeBuyIn = getHedgeHedgeBuyInSignalState();
//         if(triggerTicketForHedgeHedgeBuyIn > 0) openHedgeHedgeBuyOrderAction(triggerTicketForHedgeHedgeBuyIn);
//
//         triggerTicketForHedgeHedgeSellIn = getHedgeHedgeSellInSignalState();
//         if(triggerTicketForHedgeHedgeSellIn > 0) openHedgeHedgeSellOrderAction(triggerTicketForHedgeHedgeSellIn);
//
//         handleHedgeHedgeAction();

      // H3
//         triggerTicketForH3BuyIn = getH3BuyInSignalState();
//         if(triggerTicketForH3BuyIn > 0) openH3BuyOrderAction(triggerTicketForH3BuyIn);
//
//         triggerTicketForH3SellIn = getH3SellInSignalState();
//         if(triggerTicketForH3SellIn > 0) openH3SellOrderAction(triggerTicketForH3SellIn);
//
//         handleH3Action();


//      if(getAbsoluteEquityDD(EQUITY_DD_PERCENT, InpMaxAbsoluteEquity) > InpMaxEquityDD_OutAndStop) {
//         closeAllPositions(CLOSED_BY_EQUITY_DD_OUT_STOP);
//         securityStop = true;
//         TesterStop();
//      }
//
//      if(showObj(InpShowDashboardOnVisualMode) == true) {
//         createDashboardCanvas();
//         createDashboardAccountTable();
//      }


      //Print("--------------------------OnTick----positionGroups---------------");
      //printArrayTwoDimensions(positionGroups, ArrayRange(positionGroups, 0), 11);
      //Print("--------------------------OnTick----dealGroups---------------");
      //printArrayTwoDimensions(dealGroups, ArrayRange(dealGroups, 0), 20);
      //Print("--------------------------OnTick----dealGroupProfit---------------");
      //printArrayTwoDimensions(dealGroupProfit, ArrayRange(dealGroupProfit, 0), 2);

   }

//   ArraySetAsSeries(sglTrendBuffer, true);
//   CopyBuffer(sglTrendHandle, TREND_BUFFER, 0, 10, sglTrendBuffer);
//
//   ArraySetAsSeries(gwlTrendBuffer, true);
//   CopyBuffer(gwlTrendHandle, TREND_BUFFER, 0, 10, gwlTrendBuffer);

//   ArraySetAsSeries(equityDDBuffer, true);
//   CopyBuffer(equityDDHandle, EQUITY_DD_BUFFER, 0, 10, equityDDBuffer);
//
//   ArraySetAsSeries(equityDDDynamicBuffer, true);
//   CopyBuffer(equityDDHandle, EQUITY_DD_DYNAMIC_BUFFER, 0, 10, equityDDDynamicBuffer);

   // SGL
//   ArraySetAsSeries(sglDynamicFastSlowBuffer, true);
//   CopyBuffer(sglDynamicHandle, DYNAMIC_FAST_SLOW_BUFFER, 0, 100, sglDynamicFastSlowBuffer);
//   ArraySetAsSeries(sglDynamicFastSlowColorBuffer, true);
//   CopyBuffer(sglDynamicHandle, DYNAMIC_FAST_SLOW_COLOR_BUFFER, 0, 100, sglDynamicFastSlowColorBuffer);
//   ArraySetAsSeries(sglDynamicFastSlowSignalBuffer, true);
//   CopyBuffer(sglDynamicHandle, DYNAMIC_FAST_SLOW_SIGNAL_BUFFER, 0, 100, sglDynamicFastSlowSignalBuffer);
//   ArraySetAsSeries(sglDynamicFastSlowSignalColorBuffer, true);
//   CopyBuffer(sglDynamicHandle, DYNAMIC_FAST_SLOW_SIGNAL_COLOR_BUFFER, 0, 100, sglDynamicFastSlowSignalColorBuffer);

   ArraySetAsSeries(trendBuffer, true);
   CopyBuffer(trendHandle, TREND_BUFFER, 0, 100, trendBuffer);



//   ArraySetAsSeries(sglDynamicMiddleSelfBuffer, true);
//   CopyBuffer(sglDynamicHandle, DYNAMIC_MIDDLE_SELF_BUFFER, 0, 100, sglDynamicMiddleSelfBuffer);
//   ArraySetAsSeries(sglDynamicMiddleSlowBuffer, true);
//   CopyBuffer(sglDynamicHandle, DYNAMIC_MIDDLE_SLOW_BUFFER, 0, 100, sglDynamicMiddleSlowBuffer);
//   ArraySetAsSeries(sglDynamicSlowSelfBuffer, true);
//   CopyBuffer(sglDynamicHandle, DYNAMIC_SLOW_SELF_BUFFER, 0, 100, sglDynamicSlowSelfBuffer);

   // GWL
//   ArraySetAsSeries(gwlDynamicFastSlowBuffer, true);
//   CopyBuffer(gwlDynamicHandle, DYNAMIC_FAST_SLOW_BUFFER, 0, 100, gwlDynamicFastSlowBuffer);
//   ArraySetAsSeries(gwlDynamicFastSlowColorBuffer, true);
//   CopyBuffer(gwlDynamicHandle, DYNAMIC_FAST_SLOW_COLOR_BUFFER, 0, 100, gwlDynamicFastSlowColorBuffer);
//   ArraySetAsSeries(gwlDynamicFastSlowSignalBuffer, true);
//   CopyBuffer(gwlDynamicHandle, DYNAMIC_FAST_SLOW_SIGNAL_BUFFER, 0, 100, gwlDynamicFastSlowSignalBuffer);
//   ArraySetAsSeries(gwlDynamicFastSlowSignalColorBuffer, true);
//   CopyBuffer(gwlDynamicHandle, DYNAMIC_FAST_SLOW_SIGNAL_COLOR_BUFFER, 0, 100, gwlDynamicFastSlowSignalColorBuffer);
//   ArraySetAsSeries(gwlDynamicMiddleSelfBuffer, true);
//   CopyBuffer(gwlDynamicHandle, DYNAMIC_MIDDLE_SELF_BUFFER, 0, 100, gwlDynamicMiddleSelfBuffer);
//   ArraySetAsSeries(gwlDynamicMiddleSlowBuffer, true);
//   CopyBuffer(gwlDynamicHandle, DYNAMIC_MIDDLE_SLOW_BUFFER, 0, 100, gwlDynamicMiddleSlowBuffer);
//   ArraySetAsSeries(gwlDynamicSlowSelfBuffer, true);
//   CopyBuffer(gwlDynamicHandle, DYNAMIC_SLOW_SELF_BUFFER, 0, 100, gwlDynamicSlowSelfBuffer);

//   setMaxEquityDD();
//Comment("currentDD: " + NormalizeDouble(equityDDBuffer[0], 1) + " // nextEquityDD: " + nextEquityDD);


//}
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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void WritePositionGroupsData() {

   string directoryName = "ArrayData";
   string fileName = "PositionGroups.bin";
   string path = directoryName + "//" + fileName;

   FileDelete(path);
   cleanPositionGroupsArrayAction();
   ResetLastError();
   int handle = FileOpen(path, FILE_READ | FILE_WRITE | FILE_BIN);
   if(handle != INVALID_HANDLE) {
      FileSeek(handle, 0, SEEK_SET);
      FileWriteArray(handle, positionGroups, 0);
      FileClose(handle);
   } else
      Print("Fehler beim Schreiben der Datei" + fileName + "Fehler: " + GetLastError());
}
//+------------------------------------------------------------------+

void ReadPositionGroupsData() {

   initializeArray(positionGroups);

   string directoryName = "ArrayData";
   string fileName = "PositionGroups.bin";
   string path = directoryName + "//" + fileName;

   ResetLastError();
   int handle = FileOpen(path, FILE_READ | FILE_BIN);
   if(handle != INVALID_HANDLE) {
      FileReadArray(handle, positionGroups);
      FileClose(handle);
   } else {
      string errorMsg = "Fehler beim Lesen der Datei " + fileName + " - Fehler: " + GetLastError();
      Print(errorMsg);
      Alert(errorMsg);
      buyIsTradeable = false;
      sellIsTradeable = false;
   }
}
//+------------------------------------------------------------------+
