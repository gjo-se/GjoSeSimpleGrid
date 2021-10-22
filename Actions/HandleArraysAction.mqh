//+------------------------------------------------------------------+
//|                                          HandleArraysAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void addTriggerTicketInPositionGroupsAction() {

   long positionTicket = 0;
   int positionGroupId = 0;

   int positionTicketId = 0;
   for(positionTicketId; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
      positionTicket = positionTickets[positionTicketId];
      positionGroupId = getPositionGroupIdByPositionTicket(positionTicket);

      if(positionGroupId == NOT_FOUND) {
         ArrayResize(positionGroups, ArrayRange(positionGroups, 0) + 1);
         positionGroups[ArrayRange(positionGroups, 0) - 1][POSITIONGROUP_ID_TRIGGER_TICKET] = positionTicket;
         positionGroups[ArrayRange(positionGroups, 0) - 1][POSITIONGROUP_ID_TRIGGER_TICKET_ORDER_TYPE] = PositionType(positionTicket);
         positionGroups[ArrayRange(positionGroups, 0) - 1][POSITIONGROUP_ID_TRIGGER_TICKET_VOLUME] = (int)(PositionVolume(positionTicket) * 100);
         positionGroups[ArrayRange(positionGroups, 0) - 1][POSITIONGROUP_ID_TRIGGER_TICKET_2] = positionTicket;
         positionGroups[ArrayRange(positionGroups, 0) - 1][POSITIONGROUP_ID_TRIGGER_ENTRY] = INITIAL_VALUE;
         positionGroups[ArrayRange(positionGroups, 0) - 1][POSITIONGROUP_ID_HEDGE_TICKET] = INITIAL_VALUE;
         positionGroups[ArrayRange(positionGroups, 0) - 1][POSITIONGROUP_ID_HEDGE_ENTRY] = INITIAL_VALUE;
         positionGroups[ArrayRange(positionGroups, 0) - 1][POSITIONGROUP_ID_HEDGE_HEDGE_TICKET] = INITIAL_VALUE;
         positionGroups[ArrayRange(positionGroups, 0) - 1][POSITIONGROUP_ID_HEDGE_HEDGE_ENTRY] = INITIAL_VALUE;
         positionGroups[ArrayRange(positionGroups, 0) - 1][POSITIONGROUP_ID_H3_TICKET] = INITIAL_VALUE;
         positionGroups[ArrayRange(positionGroups, 0) - 1][POSITIONGROUP_ID_H3_ENTRY] = INITIAL_VALUE;
      }
   }
}

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
//+------------------------------------------------------------------+

//void addTriggerTicketReEnInPositionGroupsAction(long pTriggerTicket) {
//
//   long  triggerTicketReEn = 0;
//   int   positionGroupId = 0;
//   long  positionTicket = 0;
//
//   positionGroupId = getPositionGroupIdByPositionTicket(pTriggerTicket);
//   if(positionGroupId != NOT_FOUND) {
//      for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//         positionTicket = positionTickets[positionTicketId];
//
//         if(StringFind(PositionComment(positionTicket), InpTriggerCommentReEntryTriggertBy + IntegerToString(pTriggerTicket)) != NOT_FOUND) {
//            triggerTicketReEn = positionTickets[positionTicketId];
//
//            if(triggerTicketReEn > 0 && positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET] == pTriggerTicket) {
//               positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET_2] = triggerTicketReEn;
//
//               if(ObjectFind(0, NEXT_ENTRY_LEVEL + IntegerToString(pTriggerTicket)) >= 0) {
//                  deleteHLine(0, NEXT_ENTRY_LEVEL + IntegerToString(pTriggerTicket));
//               }
//
//            } else {
//
//               // dann liegt definitv ein Fehler vor!!
//            }
//         }
//      }
//
//   } else {
//
//      // dann liegt definitv ein Fehler vor!!
//
//   }
//}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//void addHedgeTicketInPositionGroupsAction(long pTriggerTicket) {
//
//   long hedgeTicket = 0;
//   int positionGroupId = 0;
//
//   positionGroupId = getPositionGroupIdByPositionTicket(pTriggerTicket);
//   if(positionGroupId != NOT_FOUND) {
//
//      int hedgeTicketId = 0;
//      for(hedgeTicketId; hedgeTicketId < ArraySize(positionTickets); hedgeTicketId++) {
//         long ticket = positionTickets[hedgeTicketId];
//
//         if(StringFind(PositionComment(ticket), InpHedgeCommentTriggertBy + IntegerToString(pTriggerTicket)) != NOT_FOUND) {
//            hedgeTicket = positionTickets[hedgeTicketId];
//
//            if(hedgeTicket > 0 && positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET] == pTriggerTicket) {
//               positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_TICKET] = hedgeTicket;
//
//               if(ObjectFind(0, NEXT_ENTRY_LEVEL + IntegerToString(pTriggerTicket)) >= 0) {
//                  deleteHLine(0, NEXT_ENTRY_LEVEL + IntegerToString(pTriggerTicket));
//               }
//
//            } else {
//
//               // dann liegt definitv ein Fehler vor!!
//            }
//         }
//      }
//
//   } else {
//
//      // dann liegt definitv ein Fehler vor!!
//
//   }
//}
//
//void addHedgeHedgeTicketInPositionGroupsAction(long pTriggerTicket) {
//
//   long tmpTicket = 0;
//   long hedgeHedgeTicket = 0;
//   int positionGroupId = 0;
//
//   positionGroupId = getPositionGroupIdByPositionTicket(pTriggerTicket);
//   if(positionGroupId != NOT_FOUND) {
//
//      int positionTicketId = 0;
//      for(positionTicketId; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//         tmpTicket = positionTickets[positionTicketId];
//
//         if(StringFind(PositionComment(tmpTicket), InpHedgeHedgeCommentTriggertBy + IntegerToString(pTriggerTicket)) != NOT_FOUND) {
//            hedgeHedgeTicket = positionTickets[positionTicketId];
//
//            if(hedgeHedgeTicket > 0 && positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET] == pTriggerTicket) {
//               positionGroups[positionGroupId][POSITIONGROUP_ID_HEDGE_HEDGE_TICKET] = hedgeHedgeTicket;
//
//               //if(ObjectFind(0, NEXT_ENTRY_LEVEL + pTriggerTicket) >= 0) {
//               //   deleteHLine(0, NEXT_ENTRY_LEVEL + pTriggerTicket);
//               //}
//
//            } else {
//               // dann liegt definitv ein Fehler vor!!
//            }
//         }
//      }
//
//   } else {
//
//      // dann liegt definitv ein Fehler vor!!
//
//   }
//}
//
//void addH3TicketInPositionGroupsAction(long pTriggerTicket) {
//
//   long tmpTicket = 0;
//   long h3Ticket = 0;
//   int positionGroupId = 0;
//
//   positionGroupId = getPositionGroupIdByPositionTicket(pTriggerTicket);
//   if(positionGroupId != NOT_FOUND) {
//
//      for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//         tmpTicket = positionTickets[positionTicketId];
//
//         if(StringFind(PositionComment(tmpTicket), InpH3CommentTriggertBy + IntegerToString(pTriggerTicket)) != NOT_FOUND) {
//            h3Ticket = positionTickets[positionTicketId];
//
//            if(h3Ticket > 0 && positionGroups[positionGroupId][POSITIONGROUP_ID_TRIGGER_TICKET] == pTriggerTicket) {
//               positionGroups[positionGroupId][POSITIONGROUP_ID_H3_TICKET] = h3Ticket;
//            } else {
//               // dann liegt definitv ein Fehler vor!!
//            }
//         }
//      }
//
//   } else {
//
//      // dann liegt definitv ein Fehler vor!!
//
//   }
//}


void addTriggerTicketInDealGroupsAndDealGroupProfitAction() {

   long  positionTicket = 0;
   long  triggerTicket = 0;
   int   dealGroupId = 0;
   int   dealGroupRange = 0;

   int positionTicketId = 0;
   for(positionTicketId; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
      positionTicket = positionTickets[positionTicketId];

      if(StringFind(PositionComment(positionTicket), InpComment) != NOT_FOUND) {
         triggerTicket = positionTickets[positionTicketId];
      }

      dealGroupId = getDealGroupIdByTriggerTicket(triggerTicket);

      if(dealGroupId == NOT_FOUND && triggerTicket != 0) {

         dealGroupRange = ArrayRange(dealGroups, 0);
         ArrayResize(dealGroups, dealGroupRange + 1);
         for(int dealGroupMemberId = 0; dealGroupMemberId < ArrayRange(dealGroups, 1); dealGroupMemberId++) {
            dealGroups[dealGroupRange][dealGroupMemberId] = INITIAL_VALUE;
         }
         dealGroups[ArrayRange(dealGroups, 0) - 1][DEALGROUP_ID_TRIGGER_TICKET] = triggerTicket;

         ArrayResize(dealGroupProfit, ArrayRange(dealGroupProfit, 0) + 1);
         dealGroupProfit[ArrayRange(dealGroupProfit, 0) - 1][DEALGROUPPROFIT_ID_TRIGGER_TICKET] = triggerTicket;
         dealGroupProfit[ArrayRange(dealGroupProfit, 0) - 1][DEALGROUPPROFIT_ID_PROFIT] = DEALGROUPPROFIT_DEFAULT_PROFIT;
      }
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void addTicketInDealGroupsAction(long pTriggerTicket, string pComment) {

   long hedgeTicket = 0;

   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
      long ticket = positionTickets[positionTicketId];
      if(StringFind(PositionComment(ticket), pComment + IntegerToString(pTriggerTicket)) != NOT_FOUND) {
         hedgeTicket = positionTickets[positionTicketId];
      }
   }

   if(hedgeTicket > 0) {
      for(int dealGroupId = 0; dealGroupId < ArrayRange(dealGroups, 0); dealGroupId++) {
         if(dealGroups[dealGroupId][DEALGROUP_ID_TRIGGER_TICKET] == pTriggerTicket) {
            for(int dealId = 0; dealId < ArrayRange(dealGroups, 1); dealId++) {
               if(dealGroups[dealGroupId][dealId] == 0) {
                  dealGroups[dealGroupId][dealId] = hedgeTicket;
                  break;
               }
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
