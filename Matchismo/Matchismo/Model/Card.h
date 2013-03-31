//
//  Card.h
//  Matchismo
//
//  Created by nevercry on 13-3-6.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;


- (int)match:(NSArray *)otherCards;



@end
