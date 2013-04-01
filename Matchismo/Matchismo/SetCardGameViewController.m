//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by nevercry on 13-3-30.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetGameCollectionViewCell.h"
#import "SetCardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@property (nonatomic, strong) SetCardDeck *cardDeck;
@property (weak, nonatomic) IBOutlet UILabel *addCardLabel;
@property (weak, nonatomic) IBOutlet UIButton *addCardButton;
@property (weak, nonatomic) IBOutlet UICollectionView *selectedCardview;


@end

@implementation SetCardGameViewController

@synthesize game = _game;

- (NSArray *)selectedCards
{
    NSMutableArray *sCards = [NSMutableArray arrayWithCapacity:3];
    for (Card *card in self.game.cards) {
        if (card.isFaceUp) {
            [sCards addObject:card];
        }
    }
    
    return sCards;
}



- (CardMatchingGame *)game
{
    if (!_game) _game = [[SetCardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck]];
    
    
    return _game;
}

- (SetCardDeck *)cardDeck
{
    if (!_cardDeck) _cardDeck = [[SetCardDeck alloc] init];
    
    return _cardDeck;
}



- (Deck *)createDeck
{
    return self.cardDeck;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate
{
    if ([cell isKindOfClass:[SetGameCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetGameCollectionViewCell *)cell).setCardView;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            setCardView.number = setCard.number;
            setCardView.symbol = setCard.symbol;
            setCardView.color = setCard.color;
            setCardView.shading = setCard.shading;
            
            setCardView.faceUp = setCard.isFaceUp;
            setCardView.alpha = setCard.isUnplayable ? 0.3 : 1.0;
            
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.cardCollectionView == collectionView) {
        return [self.game.cards count];
    } else if (self.selectedCardview == collectionView)
    {
        return [[self selectedCards] count];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cardCollectionView == collectionView) {
        UICollectionViewCell *cell = [self.cardCollectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:NO];
        return cell;
    } else if (self.selectedCardview == collectionView) {
        UICollectionViewCell *cell = [self.selectedCardview  dequeueReusableCellWithReuseIdentifier:@"SelectedCard" forIndexPath:indexPath];
        Card *card = [[self selectedCards] objectAtIndex:indexPath.item];

        [self updateCell:cell usingCard:card animate:NO];
        return cell;
    }
    
    return nil;
}


- (NSUInteger)startingCardCount
{
    return 12;
}


- (void)updateUI
{

    [self.selectedCardview reloadData];
    
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath  = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:NO];
    }
    
    for (UICollectionViewCell *cell in [self.selectedCardview visibleCells]) {
        NSIndexPath *indexPath = [self.selectedCardview indexPathForCell:cell];
        Card *card = [[self selectedCards] objectAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:NO];
    }
    
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.gameResult.gameName = self.gameName;
    self.gameResult.score = self.game.score;
}

- (NSString *)cellIdentifier
{
    return @"SetCard";
}

- (NSString *)gameName
{
    return @"SetGame";
}

- (IBAction)deal
{
    self.game = nil;
    self.cardDeck =nil;
    self.gameResult = nil;
    self.addCardButton.enabled = YES;
    self.addCardLabel.text = @"add 3 more";
    [self.cardCollectionView reloadData];
    [self updateUI];
}


- (IBAction)addThreeCards:(UIButton *)sender
{
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:3];
    
    for (int i = 0; i < 3; i++) {
        Card *card = [self.cardDeck drawRandomCard];
        
        if (card) {
            [self.game.cards addObject:card];
    
        
            UICollectionViewCell *cell = [[self.cardCollectionView visibleCells] lastObject];
            
            NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
            
            NSIndexPath *anotherindexPath = [NSIndexPath indexPathForItem:[self.game.cards count]-1
                                                                inSection:indexPath.section];
            
            [indexPaths addObject:anotherindexPath];
        } else
        {
            self.addCardButton.enabled = NO;
            self.addCardLabel.text = @"No card";
            break;
        }
    }
    
    [self.cardCollectionView insertItemsAtIndexPaths:indexPaths];
    [self.cardCollectionView scrollToItemAtIndexPath:[indexPaths lastObject] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
    
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        [self updateUI];
        [self deleteUnplayableCardView];
        self.gameResult.score = self.game.score;
    
    }
}

- (void)deleteUnplayableCardView
{
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:3];
    for (SetGameCollectionViewCell *cell in [self.cardCollectionView visibleCells])
    {
        if (cell.setCardView.isFaceUp)
        {
            NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
            
            [indexPaths addObject:indexPath];
        }
    }
    
    
    if ([indexPaths count] == 3) {
        
        [self.game removeUnplayableCards];
        [self.cardCollectionView deleteItemsAtIndexPaths:indexPaths];
    }
        
}



- (IBAction)deselectedCard:(UITapGestureRecognizer *)sender
{
    CGPoint tapLocation = [sender locationInView:self.selectedCardview];
    NSIndexPath *indexPath = [self.selectedCardview indexPathForItemAtPoint:tapLocation];
    
    if (indexPath) {
        Card *card = [[self selectedCards] objectAtIndex:indexPath.item];
        for (Card *anotherCard in self.game.cards)
        {
            if (anotherCard == card)
            {
                anotherCard.faceUp = NO;
                [self updateUI];
            }
        }
    }

}















@end
