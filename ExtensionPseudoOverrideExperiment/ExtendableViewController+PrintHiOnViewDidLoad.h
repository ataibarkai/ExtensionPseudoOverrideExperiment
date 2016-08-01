//
//  ExtendableViewController+PrintHiOnViewDidLoad.h
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 7/22/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import "ExtendableViewController.h"

@interface ExtendableViewController (PrintHiOnViewDidLoad)

/// By default, side effects of the cateogory are disabled.
/// Subclasses must specifically opt-in.
-(BOOL)PrintHiOnViewDidLoad_isImplemented;

@end
