//
//  SetCard.m
//  Matchismo
//
//  Created by nevercry on 13-3-14.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 2) {
        SetCard *otherCard1 = (SetCard *)otherCards[0];
        SetCard *otherCard2 = (SetCard *)otherCards[1];
            
        if ((self.number == otherCard1.number && otherCard1.number == otherCard2.number) || (self.number != otherCard1.number && otherCard1.number != otherCard2.number && otherCard2.number != self.number))
        {
            if ((self.symbol == otherCard1.symbol && otherCard1.symbol == otherCard2.symbol) || (!(self.symbol == otherCard1.symbol) && !(otherCard1.symbol == otherCard2.symbol) && !(otherCard2.symbol == self.symbol)))
            {
                if ((self.shading == otherCard1.shading && otherCard1.shading == otherCard2.shading) || (!(self.shading == otherCard1.shading) && !(otherCard1.shading == otherCard2.shading) && !(otherCard2.shading == self.shading)))
                {
                    if ((self.color == otherCard1.color && otherCard1.color == otherCard2.color) || (!(self.color == otherCard1.color) && !(otherCard1.color == otherCard2.color) && !(otherCard2.color == self.color)))
                        score = 5;
                }
            }
        }
    }
    
    return score;
}








@end
