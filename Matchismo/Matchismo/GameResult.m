//
//  GameResult.m
//  Matchismo
//
//  Created by nevercry on 13-3-14.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "GameResult.h"

@interface GameResult ()

@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define GAMENAME_KEY @"GameName"


+ (NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    
    return allGameResults;
}

// convenience initializer
- (id)initFromPropertyList:(id)plist
{
    self = [self init];
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            _gameName = resultDictionary[GAMENAME_KEY];
            if (!_start || !_end) self = nil;
        }
    }
    return self;
}

- (void)synchronize
{
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if (!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
     
}


- (id)asPropertyList
{
    return @{ START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score), GAMENAME_KEY : self.gameName};
}



// designated initializer
- (id)init
{
    self = [super init];
    if (self) {
        _start = [NSDate date];
        _end = _start;
        _gameName = @"UnknowGame";
    }
    return self;
}

- (NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

- (void)setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

- (void)setGameName:(NSString *)gameName
{
    _gameName = gameName;
    [self synchronize];
}



@end
