//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by nevercry on 13-3-24.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
