//
//  Subclass2VC.m
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 8/1/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import "Subclass2VC.h"
#import "ExtendableViewController+SayByOnViewDidLoad.m"


@implementation Subclass2VC

# pragma mark Categories Opt-In

-(BOOL)SayByeOnViewDidLoad_isImplemented {
    return YES;
}

@end
