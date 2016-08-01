//
//  ExtendableViewController+SayByOnViewDidLoad.m
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 8/1/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import "ExtendableViewController+SayByOnViewDidLoad.h"

@implementation ExtendableViewController (SayByOnViewDidLoad)

-(BOOL)SayByeOnViewDidLoad_isImplemented {
    return NO;
}

-(void)SayByeOnViewDidLoad_DXExtending_setup {
    
    // if only perform the side effects in subclasses that specifically opt-in.
    if (![self SayByeOnViewDidLoad_isImplemented]) {
        return;
    }
    
    // extend viewDidLoad
    [self addViewDidLoadExtension:^{
        NSLog(@"Bye.....");
    }];
    
}

@end
