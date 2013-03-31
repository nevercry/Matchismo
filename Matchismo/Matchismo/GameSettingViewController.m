//
//  GameSettingViewController.m
//  Matchismo
//
//  Created by nevercry on 13-3-19.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "GameSettingViewController.h"
#import "GameResult.h"

@interface GameSettingViewController ()

@end

@implementation GameSettingViewController

#define ALL_RESULTS_KEY @"GameResult_All"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clearResults {
    
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if (mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = nil;
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
