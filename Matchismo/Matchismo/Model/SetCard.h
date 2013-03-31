//
//  SetCard.h
//  Matchismo
//
//  Created by nevercry on 13-3-14.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "Card.h"


typedef enum
{
    SetSymbolDiamond,
    SetSymbolSquiggle,
    SetSymbolOval
} SetSymbol;

typedef enum
{
    SetShadingSolid,
    SetShadingStriped,
    SetShadingOpen
} SetShading;

typedef enum
{
    SetColorRed,
    SetColorGreen,
    SetColorPurple
} SetColor;

typedef enum
{
    SetNumberOne,
    SetNumberTwo,
    SetNumberThree
} SetNumber;



@interface SetCard : Card

@property (nonatomic) SetNumber number;
@property (nonatomic) SetSymbol symbol;
@property (nonatomic) SetShading shading;
@property (nonatomic) SetColor color;


@end
