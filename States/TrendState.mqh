/*

   TRendState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

   - setTrend UP | DOWN | ROTATION_AREA

*/

void setTrend() {

   int barShift = 0;
   int gwlTrend = ROTATION_AREA;
   int sglTrend = ROTATION_AREA;



   if(ArraySize(gwlTrendBuffer) > 0) {

      if(gwlTrendBuffer[barShift] > InpMin_GWL_TrendStrength ) {
         gwlTrend = UP_TREND;
      } else if(gwlTrendBuffer[barShift] < InpMin_GWL_TrendStrength * -1) {
         gwlTrend = DOWN_TREND;
      } else {
         gwlTrend = ROTATION_AREA;
      }
   } else {

      sglTrend = ROTATION_AREA;

   }

   if(ArraySize(sglTrendBuffer) > 0) {

      if(sglTrendBuffer[barShift] > InpMin_SGL_TrendStrength ) {
         sglTrend = UP_TREND;
      } else if(sglTrendBuffer[barShift] < InpMin_SGL_TrendStrength * -1) {
         sglTrend = DOWN_TREND;
      } else {
         sglTrend = ROTATION_AREA;
      }
   } else {
      sglTrend = ROTATION_AREA;
   }

   if(gwlTrend == UP_TREND && sglTrend == UP_TREND) {
      trend = UP_TREND;
   } else if(gwlTrend == DOWN_TREND && sglTrend == DOWN_TREND) {
      trend = DOWN_TREND;
   } else {
      trend = ROTATION_AREA;
   }


}
//+------------------------------------------------------------------+
