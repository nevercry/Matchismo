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
            
            if (animate) {
                [UIView transitionWithView:playingCardView
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                    playingCardView.faceUp = playingCard.isFaceUp;
                                }
                                completion:NULL];
            
            }
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

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        [self updateUI];
        
        Card *card = [self.game cardAtIndex:indexPath.item];
        
        UICollectionViewCell *cell = [self.cardCollectionView cellForItemAtIndexPath:indexPath];
    
        
        
        if (!card.isUnplayable) {
            [self updateCell:cell usingCard:card animate:YES];
            
        }
        
    
        
        
        self.gameResult.score = self.game.score;
        
    }
}




- (IBAction)deal
{
    self.game = nil;
    self.gameResult = nil;
    [self updateUI];
}

@end
