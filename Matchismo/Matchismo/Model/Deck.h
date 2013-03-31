//
//  Deck.h
//  Matchismo
//
//  Created by nevercry on 13-3-6.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Deck : NSObject


- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
