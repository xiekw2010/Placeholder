//
//  DXViewController.m
//  Placeholder
//
//  Created by 逸言 on 08/26/2015.
//  Copyright (c) 2015 逸言. All rights reserved.
//

#import "DXViewController.h"
#import "Placeholder.h"

@interface DXViewController ()

@end

@implementation DXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    PHFeedUser *user = [PHFeedUser randomModel];
    
    PHFeedComment *comment = [PHFeedComment randomModel];
    
    [PHFeed asyncRandomModelWithRange:NSMakeRange(3, 4) completionBlock:^(NSArray *models, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
