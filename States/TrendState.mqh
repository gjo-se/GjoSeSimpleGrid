/*

   TrendState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

   - setTrend UP | DOWN | ROTATION_AREA

*/

void setTrend() {

   int barShift = 0;

   if(ArraySize(sglTrendBuffer) > 0) {
   
      if(sglTrendBuffer[barShift] > InpMin_SGL_TrendStrength && InpIND_GjoSeTrenddetector_GWL_Trend == GWL_UP_TREND) {
         trend = UP_TREND;
      } else if(sglTrendBuffer[barShift] < InpMin_SGL_TrendStrength * -1 && InpIND_GjoSeTrenddetector_GWL_Trend == GWL_DOWN_TREND) {
         trend = DOWN_TREND;
      } else {
         trend = ROTATION_AREA;
      }
   } else {
      trend = ROTATION_AREA;
   }
}
//+------------------------------------------------------------------+
