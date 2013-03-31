//
//  PlayingCardMatchingGame.m
//  Matchismo
//
//  Created by nevercry on 13-3-30.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "PlayingCardMatchingGame.h"


#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1


@implementation PlayingCardMatchingGame

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.matchResult = [NSString stringWithFormat:@"Matched %@ & %@ for 4 point",otherCard.contents,card.contents];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.matchResult = [NSString stringWithFormat:@"%@ and %@ don't match! 2 point penalty!",otherCard.contents,card.contents];
                    }
                    break;
                } else
                {
                    self.matchResult = [NSString stringWithFormat:@"Flipped up %@",card.contents];
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }

}


@end
