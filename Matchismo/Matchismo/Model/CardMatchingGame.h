//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by nevercry on 13-3-9.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface CardMatchingGame : NSObject

@property (strong,nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) NSString *matchResult;



- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck; // designated initializer

- (void)flipCardAtIndex:(NSUInteger)index; // abstract

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)removeUnplayableCards;



@end
