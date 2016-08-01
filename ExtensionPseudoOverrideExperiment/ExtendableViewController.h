//
//  ViewController.h
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 7/22/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtendableViewController : UIViewController

typedef void (^ViewDidLoad_Ext)();
typedef void (^ViewDidAppear_Ext)(BOOL animated);

-(void)addViewDidLoadExtension:(nonnull ViewDidLoad_Ext)ext;
-(void)addViewDidAppearExtension:(nonnull ViewDidAppear_Ext)ext;

@end

