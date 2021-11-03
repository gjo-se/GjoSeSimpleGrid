/*

   TrendState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

   - setTrend UP | DOWN | ROTATION_AREA

*/

// TODO: löschen, wird nicht mehr gebraucht

//void setTrend() {
//
//   int barShift = 0;
//
//   setSGLTrend();
//   setGWLTrend();
//
//   if(gwlTrend == UP_TREND && sglTrend == UP_TREND) {
//      trend = UP_TREND;
//   } else if(gwlTrend == DOWN_TREND && sglTrend == DOWN_TREND) {
//      trend = DOWN_TREND;
//   } else {
//      trend = ROTATION_AREA;
//   }
//}
//
//void setSGLTrend() {
//
//   int barShift = 0;
//
//   if(ArraySize(sglDynamicFastSlowColorBuffer) > 0) {
//
//      if(sglDynamicFastSlowColorBuffer[barShift] == DYNAMIC_UP_TREND_NORMAL) {
//         sglTrend = UP_TREND;
//      } else if(sglDynamicFastSlowColorBuffer[barShift] == DYNAMIC_DOWN_TREND_NORMAL) {
//         sglTrend = DOWN_TREND;
//      } else {
//         sglTrend = ROTATION_AREA;
//         //isTradeable = true;
//      }
//   } else {
//      sglTrend = ROTATION_AREA;
//      //isTradeable = true;
//   }
//}

//void setGWLTrend() {
//
//   int barShift = 0;
//
//   if(ArraySize(gwlDynamicFastSlowColorBuffer) > 0) {
//
//      if(gwlDynamicFastSlowColorBuffer[barShift] == DYNAMIC_UP_TREND_NORMAL) {
//         gwlTrend = UP_TREND;
//      } else if(gwlDynamicFastSlowColorBuffer[barShift] == DYNAMIC_DOWN_TREND_NORMAL) {
//         gwlTrend = DOWN_TREND;
//      } else {
//         gwlTrend = ROTATION_AREA;
//         //isTradeable = true;
//      }
//   } else {
//      gwlTrend = ROTATION_AREA;
//      //isTradeable = true;
//   }
//}