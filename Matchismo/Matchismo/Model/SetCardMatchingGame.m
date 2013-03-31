//
//  SetCardMatchingGame.m
//  Matchismo
//
//  Created by nevercry on 13-3-30.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "SetCardMatchingGame.h"


#define MATCH_BOUNS 2
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

@implementation SetCardMatchingGame



- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            NSMutableArray *matchCards = [NSMutableArray arrayWithCapacity:2];
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [matchCards addObject:otherCard];
                }
            }
            if ([matchCards count] == 2) {
                int matchScore = [card match:matchCards];
                if (matchScore) {
                    card.unplayable = YES;
                    for (Card *otherCard in matchCards) {
                        otherCard.unplayable = YES;
                    }
                    
                    self.score += matchScore *MATCH_BOUNS;
                    self.matchCards = @[card,matchCards[0],matchCards[1]];
                    self.matchResult = [NSString stringWithFormat:@"Match %@&%@&%@ for 10 points",[card contents],[matchCards[0] contents],[matchCards[1] contents]];
                } else {
                    for (Card *otherCard in matchCards) {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    self.matchCards = @[card,matchCards[0],matchCards[1]];
                    self.matchResult = [NSString stringWithFormat:@"%@&%@&%@ don't match (-2 penalty)",[card contents],[matchCards[0] contents],[matchCards[1] contents]];
                }
            }
        }
        self.score -= FLIP_COST;
    }
    card.faceUp = !card.isFaceUp;
}



@end
