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

-(BOOL)PrintHiOnViewDidLoad_isImplemented {
    return NO;
}

-(void)PrintHiOnViewDidLoad_DXExtending_setup {
    
    // if only perform the side effects in subclasses that specifically opt-in.
    if (![self PrintHiOnViewDidLoad_isImplemented]) {
        return;
    }
    
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
    
    // if only perform the side effects in subclasses that specifically opt-in.
    if (![self PrintHiOnViewDidLoad_isImplemented]) {
        return;
    }
}

@end
