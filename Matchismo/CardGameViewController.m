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
 * When cardButton is touched flip card over and increment count
 */
- (IBAction)touchCardButton:(UIButton *)sender
{
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
        [sender setTitle:@"A♣" forState:UIControlStateNormal];
    }
    
    self.flipCount++;
    
}

@end
