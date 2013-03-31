//
//  GameResult.h
//  Matchismo
//
//  Created by nevercry on 13-3-14.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults; // of GameResult

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
@property (nonatomic) NSString *gameName;

@end
