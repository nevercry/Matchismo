//
//  CardGameViewController.h
//  Matchismo
//
//  Created by nevercry on 13-3-6.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController : UIViewController <UICollectionViewDataSource>


- (Deck *)createDeck; // abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate; // abstract
- (void)updateUI; //abstract
- (IBAction)deal; // abstract

@property (nonatomic) NSUInteger startingCardCount; // abstract
@property (nonatomic, strong) NSString *cellIdentifier; // abstract
@property (strong, nonatomic) CardMatchingGame *game; // abstract
@property (strong, nonatomic) NSString *gameName; // abstract
@property (strong, nonatomic) GameResult *gameResult;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
