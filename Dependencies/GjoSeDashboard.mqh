/*

   GjoSeDashboard.mqh
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

//*/

//+------------------------------------------------------------------+
//| Const                                                            |
//+------------------------------------------------------------------+
const int dashboardCanvasX = 50;
const int dashboardCanvasY = 50;
const int dashboardCanvasWidth = 600;
const int dashboardCanvasHeight = 200;

const string OBJ_PREFIX = "gjo_dashboard_";
const int HEADER_FONT_SIZE = 12;

const int OFFSET_TAB_1_ROW_1 = 20;
const int OFFSET_TAB_1_ROW_2 = 45;
const int OFFSET_TAB_1_COL_1 = 10;
const int OFFSET_TAB_1_COL_2 = 80;
const int OFFSET_TAB_1_COL_3 = 170;
const int OFFSET_TAB_1_COL_4 = 260;
const int OFFSET_TAB_1_COL_5 = 330;
const int OFFSET_TAB_1_COL_6 = 400;
const int OFFSET_TAB_1_COL_7 = 500;

const int OFFSET_TAB_2_ROW_1 = 70;
const int OFFSET_TAB_2_ROW_2 = 85;
const int OFFSET_TAB_2_COL_1 = 10;
const int OFFSET_TAB_2_COL_2 = 80;
const int OFFSET_TAB_2_COL_3 = 150;
const int OFFSET_TAB_2_COL_4 = 250;
const int OFFSET_TAB_2_COL_5 = 320;

const string SYMBOL_MAPPING_FILE_NAME = "SymbolMapping.csv";
const int SYMBOL_MAPPING_ARRAY_NUMBER_INDEX = 0;
const int SYMBOL_MAPPING_ARRAY_NAME_INDEX = 1;

//+------------------------------------------------------------------+
//| Globals                                                          |
//+------------------------------------------------------------------+
int dashboardCanvasLabelX;
int dashboardCanvasLabelY;

string symbolsMappingArray[100][2];
int      serverRequest = 0;

void createDashboardAccountTable() {

// Balance
   string balanceLabelObjName = "Balance";
   createLabel(0, balanceLabelObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_1, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_1, balanceLabelObjName, HEADER_FONT_SIZE);

   string balanceValueObjName = "BalanceValue";
   double accountBalanceValue = NormalizeDouble(AccountInfoDouble(ACCOUNT_BALANCE), 2);
   createLabel(0, balanceValueObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_1, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_2, DoubleToString(accountBalanceValue, 0));

// Equity
   string equityLabelObjName = "Equity";
   createLabel(0, equityLabelObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_2, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_1, equityLabelObjName, HEADER_FONT_SIZE);

   string equityValueObjName = "EquityValue";
   double currEquityValue = NormalizeDouble(AccountInfoDouble(ACCOUNT_EQUITY), 2);

   string equityValue = DoubleToString(maxAbsolutEquityValue, 0) + " / " + DoubleToString(currEquityValue, 0);
   createLabel(0, equityValueObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_2, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_2, equityValue);

// DrawDown
   string equityDrawDownLabelObjName = "DrawDawn";
   createLabel(0, equityDrawDownLabelObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_3, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_1, equityDrawDownLabelObjName, HEADER_FONT_SIZE);

   string accountDrawDownValueObjName = "DrawDownValue";
   string accountDrawDownValue = DoubleToString(getRelativeEquityDD(EQUITY_DD_CURRENCY), 0) + " (" + DoubleToString(getRelativeEquityDD(EQUITY_DD_PERCENT), 1) + "%)";
   createLabel(0, accountDrawDownValueObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_3, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_2, accountDrawDownValue);

// Margin
   string marginLabelObjName = "Margin";
   createLabel(0, marginLabelObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_4, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_1, marginLabelObjName, HEADER_FONT_SIZE);

   string marginValueObjName = "MarginValue";
   double marginValue = NormalizeDouble(AccountInfoDouble(ACCOUNT_MARGIN_LEVEL), 2);
   createLabel(0, marginValueObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_4, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_2, DoubleToString(marginValue, 0) + "%");

// Open Positions
   string openPositionsCountLabelObjName = "OpenPos";
   createLabel(0, openPositionsCountLabelObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_5, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_1, openPositionsCountLabelObjName, HEADER_FONT_SIZE);

   string openPositionsCountValueObjName = "OpenPosValue";
   int openPositionsCountValueArray = ArraySize(positionTickets);
   //int hedgedPositionsCountValueArray = ArraySize(hedgedPositionTickets);
   //createLabel(0, openPositionsCountValueObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_5, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_2, IntegerToString(openPositionsCountValueArray) + " (" + IntegerToString(hedgedPositionsCountValueArray) + ")");

   //Print("--------------------------positionGroups Dashboard-------------------");
   //printArrayTwoDimensions(positionGroups, ArrayRange(positionGroups, 0), 10);
   
   
// Server Requests
   string serverRequestCountLabelObjName = "SRequests";
   createLabel(0, serverRequestCountLabelObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_6, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_1, serverRequestCountLabelObjName, HEADER_FONT_SIZE);

   string serverRequestCountValueObjName = "SRequestsValue";
   int serverRequestCountValue = serverRequest;
   createLabel(0, serverRequestCountValueObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_1_COL_6, dashboardCanvasLabelY + OFFSET_TAB_1_ROW_2, IntegerToString(serverRequestCountValue));

}

void createSymbolTable() {

   string symbolLabelObjName = "Symbol";
   createLabel(0, symbolLabelObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_2_COL_1, dashboardCanvasLabelY + OFFSET_TAB_2_ROW_1, symbolLabelObjName, HEADER_FONT_SIZE);

   string symbolDDLabelObjName = "SyDD";
   createLabel(0, symbolDDLabelObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_2_COL_2, dashboardCanvasLabelY + OFFSET_TAB_2_ROW_1, symbolDDLabelObjName, HEADER_FONT_SIZE);

   string buyVolLabelObjName = "BuyVol";
   createLabel(0, buyVolLabelObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_2_COL_3, dashboardCanvasLabelY + OFFSET_TAB_2_ROW_1, buyVolLabelObjName, HEADER_FONT_SIZE);

   string sellVolLabelObjName = "SellVol";
   createLabel(0, sellVolLabelObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_2_COL_4, dashboardCanvasLabelY + OFFSET_TAB_2_ROW_1, sellVolLabelObjName, HEADER_FONT_SIZE);

   string diffVolLabelObjName = "DiffVol";
   createLabel(0, diffVolLabelObjName, 0, dashboardCanvasLabelX + OFFSET_TAB_2_COL_5, dashboardCanvasLabelY + OFFSET_TAB_2_ROW_1, diffVolLabelObjName, HEADER_FONT_SIZE);


   double   symbolGroupArray[20];
// CONST für Indexes setzen
//[0] = SymnolNummer
//(getSymbolNumberBySymbolName() + umgedreht)
// wenn nicht gefunden, eindeutige Sonstige Nummer vergeben
//[1] = SymbolGroupBuyVol
//[2] = SymbolGroupSellVol
//[3] = SymbolGroupDD
   int      symbolIndex = 0;

// false abfangen
   setSymbolMappingArray();

//ArraySort(Symbols, WHOLE_ARRAY, 0, MODE_ASCEND);

//string orderSymbol;

   int orderIndex;
   int index = 0;
   bool orderSymbolFound = false;
   for(orderIndex = 0; orderIndex < OrdersTotal(); orderIndex++) {


//      if(OrderSelect(orderIndex,SELECT_BY_POS)==true) {
//
//         //int foundIndex = ArrayBsearch(Symbols, OrderSymbol(), WHOLE_ARRAY, 0, MODE_DESCEND);
//
//         //Print("foundIndex: " + foundIndex);
//
//
//
//         while(symbolIndex < ArraySize(symbolGroupArray) && !IsStopped()) {
//
//            if(symbolGroupArray[symbolIndex] == OrderSymbol()) {
//               orderSymbolFound = true;
//            }
//
//            if(orderSymbolFound == false) {
//               symbolGroupArray[symbolIndex] = OrderSymbol();
//            }
//
//            symbolIndex++;
//         }
//
//
//         // https://www.mql5.com/en/forum/135608
//
//         //if(Symbols[foundIndex] != OrderSymbol()) {
//         //   Symbols[SymbolsCount] = OrderSymbol();
//         //   SymbolsCount++;
//         //} else {
//         //   //Symbols[foundIndex][orderIndex] = OrderSymbol();
//         //   //Symbols[foundIndex][0] = 1;
//         //}
//
//         //Print("Magic number for the order 10 ", OrderMagicNumber());
//         //Print("OrdersSymbol(): " + OrderSymbol() + orderIndex);
//
//      } else {
//
//         Print("OrderSelect returned error of ",GetLastError());
//      }


   }

}

void createDashboardCanvas() {

   string dashboardCanvasObjName = OBJ_PREFIX + "dashboardCanvas";

   CreateRectangleLabel(0,dashboardCanvasObjName,0,dashboardCanvasX,dashboardCanvasY,dashboardCanvasWidth,dashboardCanvasHeight);

   // Journal: possible loss of data due to type conversion - lässt sich nicht umgehen, gibt double zurück
   dashboardCanvasLabelX = (int)ObjectGetInteger(0, dashboardCanvasObjName, OBJPROP_XDISTANCE);
   dashboardCanvasLabelY = (int)ObjectGetInteger(0, dashboardCanvasObjName, OBJPROP_YDISTANCE);

}

bool setSymbolMappingArray() {

   ResetLastError();

   string fileName = SYMBOL_MAPPING_FILE_NAME;
// Testen, ob ich auf den Sepatror verzichten kann, dann bekomme ich eine Zeile
// und kann den String dann wie unten mit ";" zerlegen
   int filehandle = FileOpen(fileName, FILE_READ | FILE_CSV, ";");

   if(filehandle != INVALID_HANDLE) {

      int    fileSize;
      string symbolInclNumber;
      string separater="_";
      ushort ushortSeparater;
      string symbolArray[];

      int symbolIndex = 0;
      ushortSeparater = StringGetCharacter(separater,0);

      while(!FileIsEnding(filehandle)) {
         fileSize=FileReadInteger(filehandle,INT_VALUE);
         symbolInclNumber=FileReadString(filehandle,fileSize);

         int symbolSplitCount = StringSplit(symbolInclNumber,ushortSeparater,symbolArray);
         if(symbolSplitCount > 0) {
            int symbolSplitIndex = 0;
            for(symbolSplitIndex; symbolSplitIndex < symbolSplitCount; symbolSplitIndex++) {
               symbolsMappingArray[symbolIndex][symbolSplitIndex] = symbolArray[symbolSplitIndex];
            }
         }

         symbolIndex++;
      }

      FileClose(filehandle);

      return(true);

   } else {

      PrintFormat("File open failed: %s\\Files\\%s", TerminalInfoString(TERMINAL_DATA_PATH), fileName);
      Print("File open failed, error ", GetLastError());

      return(false);

   }
}
//+------------------------------------------------------------------+
