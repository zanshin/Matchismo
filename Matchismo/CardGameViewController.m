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

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@property (strong, nonatomic) Deck *deck;

@end

@implementation CardGameViewController

/* 
 * Extended flipCount setter to adjust UI when count changes
 */
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount changed to %d", self.flipCount);
}

/*
 * Lazily instantiate deck when it is needed
 */
- (Deck *)deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

/*
 * When cardButton is touched flip card over and increment count.
 * Randomly choose card from deck
 */
- (IBAction)touchCardButton:(UIButton *)sender
{
    Card *card = [self.deck drawRandomCard];
    if (card)
        if ([sender.currentTitle length]) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
            [sender setTitle:@"" forState:UIControlStateNormal];
            
            // put the card back in the deck, since we didn't show anything on this flip
            [self.deck addCard:card atTop:NO];
        } else {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:card.contents forState:UIControlStateNormal];
    } else {
        
        // no more cards, hide the button, i.e, the deck, and don't count this flip
        sender.hidden = YES;
        self.flipCount--;
    }

    self.flipCount++;
    
}

@end
