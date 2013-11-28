//
//  Card.h
//  Matchismo
//
//  Created by Mark Nichols on 11/27/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
