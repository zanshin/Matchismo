//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Mark Nichols on 11/27/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSString *results;
@property (nonatomic, strong) NSMutableArray *cards; // of Cards
@end

@implementation CardMatchingGame

/*
 * Lazily instantiate cards when needed
 */
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

/*
 * initialize the CardMatchingGame with a number of cards and a deck
 */
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    // fill cards array with `count` random cards from `deck`
    // if more cards are required than are available, fail to initialize
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

/*
 * Force nil from init, since you can't get a well-formed CardMatchingGame
 * by calling just init.
 */
- (instancetype)init
{
    return nil;
}

/*
 * Can't have fewer than 2 cards to match.
 */
- (int)numberOfCardsToMatch
{
    if (!_numberOfCardsToMatch) _numberOfCardsToMatch = 2;
    return _numberOfCardsToMatch;
}

// Misses cost you 2 points. Matches get 4x bonus.
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

/*
 * 2-card matching game logic.
 */
- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    int flipScore = 0;
    self.results = nil; // clear for this flip
    
    if (!card.isMatched) {
        if (card.isChosen) {
            // toggle choosen card to unchoosen
            card.chosen = NO;
        } else {
            // match against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        flipScore += matchScore * MATCH_BONUS;
                        self.score += flipScore;
                        card.matched = YES;
                        otherCard.matched = YES;
                        
                        self.results = [NSString stringWithFormat:@"Matched %@ %@ for %d points.", card.contents, otherCard.contents, flipScore];
                    } else {
                        flipScore -= MISMATCH_PENALTY;
                        self.score -= flipScore;
                        otherCard.chosen = NO;
                        
                        self.results = [NSString stringWithFormat:@"%@ %@ don't match. %d points.", card.contents, otherCard.contents, flipScore];
                    }
                    break;
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            
        }
        
        if (!self.results) {
            self.results = [NSString stringWithFormat:@"%@ is flipped %@.",
                            card.contents, (card.isChosen ? @"up" : @"down")];
        }
    }
}

/*
 * return the card at the given index
 */
- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
