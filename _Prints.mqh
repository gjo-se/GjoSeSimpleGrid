//Print("--------------------------OnTick----positionTickets---------------");
//printArrayOneDimension(positionTickets, ArraySize(positionTickets));
//Print("--------------------------OnTick----positionGroups---------------");
//printArrayTwoDimensions(positionGroups, ArrayRange(positionGroups, 0), 9);
//Print("--------------------------OnTick----dealGroups---------------");
//printArrayTwoDimensions(dealGroups, ArrayRange(dealGroups, 0), 20);
//Print("--------------------------OnTick----dealGroupProfit---------------");
//printArrayTwoDimensions(dealGroupProfit, ArrayRange(dealGroupProfit, 0), 2);


      if(printMessages == true) {
         Print("Time: " + M1_Bar.Time());

         Print("--------------------------OnTick----positionTickets---------------: " + ArraySize(positionTickets));
         printArrayOneDimension(positionTickets, ArraySize(positionTickets));
         Print("--------------------------OnTick----positionGroups---------------: " + ArrayRange(positionGroups, 0));
         printArrayTwoDimensions(positionGroups, ArrayRange(positionGroups, 0), 9);
         printMessages = false;
      }