//
//  ExtendableViewController+PrintHiOnViewDidLoad.m
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 7/22/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import "ExtendableViewController+PrintHiOnViewDidLoad.h"
#import <Foundation/Foundation.h>

@implementation ExtendableViewController (PrintHiOnViewDidLoad)

-(void)PrintHiOnViewDidLoad_DXExtending_create {
    
    // extend viewDidLoad
    [self addViewDidLoadExtension:^{
        NSLog(@"HI!!!!!!");
    }];
    
    // extend viewDidAppear
    [self addViewDidAppearExtension:^(BOOL animated) {
        NSLog(@"Yoyoyo viewDidAppear:(animated = %@)", animated ? @"YES" : @"NO" );
    }];
}

-(void)PrintHiOnViewDidLoad_DXExtending_destroy {
    
}

@end
