//
//  SetCardView.h
//  Matchismo
//
//  Created by nevercry on 13-3-25.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@interface SetCardView : UIView

@property (nonatomic) SetNumber number;
@property (nonatomic) SetSymbol symbol;
@property (nonatomic) SetShading  shading;
@property (nonatomic) SetColor color;

@property (nonatomic,getter = isFaceUp) BOOL faceUp;

@end
