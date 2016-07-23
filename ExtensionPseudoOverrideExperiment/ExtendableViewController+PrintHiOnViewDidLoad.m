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

-(void)PrintHiOnViewDidLoad_viewDidLoad {
    NSLog(@"Hi!");
}

-(void)PrintHiOnViewDidLoad_viewDidAppear:(BOOL)animated {
    NSLog(@"HHEEEY");
}

@end
