//+------------------------------------------------------------------+
//|                                                     Includes.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include "Inputs.mqh"
#include "Const.mqh"

#include <Mql5Book\TradeHedge.mqh>
#include <Mql5Book\Pending.mqh>
#include <Mql5Book\Price.mqh>
#include <Mql5Book\MoneyManagement.mqh>
#include <Mql5Book\TrailingStops.mqh>
#include <Mql5Book\Timer.mqh>
#include <Mql5Book\Indicators.mqh>
#include <Trade\DealInfo.mqh>

#include "Globals.mqh"
#include "..\\Actions\\InitializeActions.mqh"
#include "..\\Actions\\CleanArraysActions.mqh"
#include "..\\Actions\\HandleArraysActions.mqh"
#include "..\\Actions\\CloseActions.mqh"
#include "..\\Actions\\OpenActions.mqh"
#include "..\\Actions\\HandleTriggerActions.mqh"
#include "..\\Actions\\HandleHedgeActions.mqh"
#include "..\\Actions\\HandleHedgeHedgeActions.mqh"
#include "..\\Actions\\BreakevenActions.mqh"
#include "..\\Actions\\DiverseActions.mqh"



#include "..\\Actions\\SecurityActions.mqh"

#include "..\\States\\PositionStates.mqh"
#include "..\\States\\SecurityStates.mqh"
#include "..\\States\\TriggerBuyInStates.mqh"
#include "..\\States\\TriggerSellInStates.mqh"
#include "..\\States\\HedgeBuyInStates.mqh"
#include "..\\States\\HedgeSellInStates.mqh"

#include "..\\Signals\\SimpleGridTriggerBuyOut.mqh"
#include "..\\Signals\\SimpleGridTriggerSellOut.mqh"

#include <GjoSe\\Utilities\\InclUtilities.mqh>
#include <GjoSe\\Objects\\InclLabel.mqh>
#include <GjoSe\\Objects\\InclRectangleLabel.mqh>
#include <GjoSe\\Objects\\InclHLine.mqh>
#include "..\\Dependencies\\GjoSeDashboard.mqh"
