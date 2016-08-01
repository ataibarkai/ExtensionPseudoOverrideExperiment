//
//  Subclass1VC.m
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 8/1/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import "Subclass1VC.h"
#import "ExtendableViewController+PrintHiOnViewDidLoad.h"

@implementation Subclass1VC

# pragma mark Categories Opt-In

-(BOOL)PrintHiOnViewDidLoad_isImplemented {
    return YES;
}

-(BOOL)SayByeOnViewDidLoad_isImplemented {
    return YES;
}

@end
