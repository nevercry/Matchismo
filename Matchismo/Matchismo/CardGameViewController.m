//
//  CardGameViewController.m
//  Matchismo
//
//  Created by nevercry on 13-3-6.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()




@end

@implementation CardGameViewController

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0; // abstract
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card animate:NO];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;  // this will protect app to crash
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate
{
    // abstract
}

- (GameResult *)gameResult
{
    
    if (!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    
    return _gameResult;
}

- (Deck *)createDeck {
    return nil;
}  // abstract


- (CardMatchingGame *)game
{
    return nil; // adstract
}




- (void)updateUI
{
    // abstract
}


- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        [self updateUI];
        self.gameResult.score = self.game.score;
    }
}

- (IBAction)deal
{
    // abstract
}




@end
