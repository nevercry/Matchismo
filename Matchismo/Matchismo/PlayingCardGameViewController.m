//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by nevercry on 13-3-24.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"
#import "PlayingCardMatchingGame.h"


@interface PlayingCardGameViewController ()



@end

@implementation PlayingCardGameViewController

@synthesize game = _game;

- (CardMatchingGame *)game
{
    if (!_game) _game = [[PlayingCardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck]];
    
        
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate
{
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]]) {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            
            playingCardView.faceUp = playingCard.isFaceUp;
            
            playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
            
        }
    }
}

- (void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath  = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:NO];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultLabel.text = self.game.matchResult;
    self.resultLabel.alpha = 1.0;
    self.gameResult.score = self.game.score;
    self.gameResult.gameName = self.gameName;
}


- (NSUInteger)startingCardCount
{
    return 22;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

- (NSString*)cellIdentifier
{
    return @"PlayingCard";
}

- (NSString*)gameName
{
    return @"CardGame";
}

- (IBAction)deal
{
    self.game = nil;
    self.gameResult = nil;
    [self updateUI];
}

@end
