//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by nevercry on 13-3-9.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()




@end


@implementation CardMatchingGame


- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)removeUnplayableCards
{
    NSMutableArray *unplayableCards = [NSMutableArray array];
    for (Card *card in self.cards) {
        if (card.isUnplayable) [unplayableCards addObject:card];
    }
    
    
    [self.cards removeObjectsInArray:unplayableCards];
}



- (void)flipCardAtIndex:(NSUInteger)index
{
    // abstract
}



@end
