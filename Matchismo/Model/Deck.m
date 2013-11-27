//
//  Deck.m
//  Matchismo
//
//  Created by Mark Nichols on 11/27/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; // of type Card
@end

@implementation Deck

/*
 * Use getter to lazily instantiate cards
 */
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

/*
 * Adds a card to either the top or bottom of the deck
 */
- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
    
}

/*
 * Adds a card to the bottom of the deck
 */
- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

/*
 * Draws a random card from the deck and removes it from the array
 */
- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
    
}

@end
