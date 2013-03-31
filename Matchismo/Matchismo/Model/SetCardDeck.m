//
//  SetCardDeck.m
//  Matchismo
//
//  Created by nevercry on 13-3-14.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        for (SetColor color = SetColorRed; color < SetColorPurple + 1;color++) {
            for (SetNumber number = SetNumberOne; number < SetNumberThree + 1; number++) {
                for (SetSymbol symbol = SetSymbolDiamond; symbol < SetSymbolOval + 1; symbol++ ) {
                    for (SetShading shading = SetShadingSolid; shading < SetShadingOpen + 1; shading++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
