//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Mark Nichols on 11/26/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

/*
 * Lazily instantiate game when it is needed
 */
- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

/*
 * Create a deck of cards
 */
- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

/*
 * When cardButton is touched flip card over and increment count.
 * Randomly choose card from deck
 */
- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}
/*
 * Visit each card in the UI and ensure that it represents the model correctly.
 */
-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        // have cardButton and card now, set cardButton attrobutes to match card values
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

/*
 * utility method to return card contents only when it's chosen
 */
- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

/*
 * utility method to return card image based on it's chosen state
 */
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
