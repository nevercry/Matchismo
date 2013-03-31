//
//  Card.m
//  Matchismo
//
//  Created by nevercry on 13-3-6.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "Card.h"

@interface Card()

@end



@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}



@end
