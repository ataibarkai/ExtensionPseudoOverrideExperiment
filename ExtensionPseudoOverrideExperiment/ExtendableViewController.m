//
//  ViewController.m
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 7/22/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import "ExtendableViewController.h"
#import <Foundation/Foundation.h>
#import "RuntimeInspector.h"


#pragma mark - ExtendableViewController

@interface ExtendableViewController ()

@end

@implementation ExtendableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RuntimeInspector callMethodsApparentlyExtendingSelector:_cmd onInstance:self];
}

@end
