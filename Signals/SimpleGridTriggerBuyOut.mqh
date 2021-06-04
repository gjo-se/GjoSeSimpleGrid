/*

   DynamicBuyOut
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Version History
   ===============

   1.0.0 Initial version

   ===============

*/

bool getBuyOutSignal() {

   //color backgroundColor;
   string objName = __FUNCTION__;

   if(getBasicBuyOutSignal()
     ) {

      //if(inPrice <= Bid ) {
      //   backgroundColor = BG_COLOR_BUY_PLUS;
      //} else {
      //   backgroundColor = BG_COLOR_BUY_MINUS;
      //}

      //createRectangle(objName + TimeToString(currentTime), inTime, inPrice, currentTime, Bid, backgroundColor);

      return true;
   }

   return false;

}
//+------------------------------------------------------------------+

bool getBasicBuyOutSignal() {

   bool signal = false;
   bool printLocal = false;
   string objName = __FUNCTION__;

   //if(signal == true && (InpPrintBuyOutLines == true || printLocal == true)) {
   //   createVLine(objName + TimeToString(currentTime), currentTime, BUY_OUT_LINE_COLOR, 1, SGL_LINE_STYLE);
   //   ObjectSetString(0, objName + TimeToStr(currentTime), OBJPROP_TEXT, objName + " (" + IntegerToString(orderCounter) + ")");
   //}

   return(signal);
}
