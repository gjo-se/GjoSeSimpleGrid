//+------------------------------------------------------------------+
//|                                              SecurityActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void resetAbsoluteEquityAction() {
   maxAbsolutEquityValue = MathMax(NormalizeDouble(AccountInfoDouble(ACCOUNT_EQUITY), 2), InpMaxAbsoluteEquity);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void resetRelativeEquity() {
   maxRelativeEquityValue = NormalizeDouble(AccountInfoDouble(ACCOUNT_EQUITY), 2);
}
