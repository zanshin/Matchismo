//
//  PlayingCard.m
//  Matchismo
//
//  Created by Mark Nichols on 11/27/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

/*
 * Need to synthesize suit as we override both its getter and setter
 */
@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

/* 
 * Class method to return rank strings
 */
+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

/*
 * Class method to return valid suits
 */
+ (NSArray *)validSuits
{
    return @[@"♣",@"♠",@"♦",@"♥"];
}

/*
 * Class method to return max rank
 */
+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

/*
 * Build a PlayingCard's contents by appending the rank and suit together
 */
- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

// Matching suit is a 1 in 4 proposition = 1 point.
// Matching rank is a 1 in 13 proposition = 4 points.
static const int MATCH_SUIT = 1;
static const int MATCH_RANK = 4;

/*
 * Override match to provide better matching logic for Playing Cards
 */
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if ([self.suit isEqualToString:otherCard.suit]) {
            score = MATCH_SUIT;
        } else if (self.rank == otherCard.rank) {
            score = MATCH_RANK;
        }
    }
    
    return score;
}

@end
