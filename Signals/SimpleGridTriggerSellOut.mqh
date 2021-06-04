/*

   EA GjoSeTrend.mq4
   Copyright 2020, Gregory Jo
   https://www.gjo-se.com

   Version History
   ===============

   1.1.0 Initial version

   ===============

//*/

bool getSellOutSignal() {

   //color backgroundColor;
   string objName = __FUNCTION__;

   if(getBasicSellOutSignal()
     ) {

//      if(inPrice >= Ask ) {
//         backgroundColor = BG_COLOR_SELL_PLUS;
//      } else {
//         backgroundColor = BG_COLOR_SELL_MINUS;
//      }
//
//      createRectangle(objName + TimeToString(currentTime), inTime, inPrice, currentTime, Ask, backgroundColor);

      return true;
   }

   return false;

}

bool getBasicSellOutSignal() {

   bool signal = false;
   bool printLocal = false;
   string objName = __FUNCTION__;

//   if(signal == true && (InpPrintSellOutLines == true || printLocal == true)) {
//      createVLine(objName + TimeToString(currentTime), currentTime, SELL_OUT_LINE_COLOR, 1, SGL_LINE_STYLE);
//      ObjectSetString(0, objName + TimeToStr(currentTime), OBJPROP_TEXT, objName + " (" + IntegerToString(orderCounter) + ")SLOW: " + last_MA_SLOW + " FAST: " + last_MA_FAST);
//   }

   return(signal);

}
//+------------------------------------------------------------------+
