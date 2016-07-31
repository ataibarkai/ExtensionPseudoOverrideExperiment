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


@interface ExtendableViewController ()

@property (atomic, strong, nonnull) NSMutableArray<ViewDidLoad_Ext>     *viewDidLoadExtensions;
@property (atomic, strong, nonnull) NSMutableArray<ViewDidAppear_Ext>   *viewDidAppearExtensions;

@end


@implementation ExtendableViewController

#pragma mark - Extendability Setup -

# pragma mark Creation Hooks

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self commonSetup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonSetup];
    }
    return self;
}

-(instancetype)init {
    if(self = [super init]){
        [self commonSetup];
    }
    return self;
}

-(void)commonSetup {
    self.viewDidLoadExtensions = [[NSMutableArray alloc] init];
    self.viewDidAppearExtensions = [[NSMutableArray alloc] init];
    
    [RuntimeInspector setupExtensionsForInstance:self];
}



# pragma mark Destruction Hooks

-(void)dealloc {
    [RuntimeInspector destroyExtensionsForInstance:self];
}

#pragma mark Extension Hooks

-(void)setup {}
-(void)destroy {}


#pragma mark - Extendability Access Points -

-(void)addViewDidLoadExtension:(nonnull ViewDidLoad_Ext)ext {
    [self.viewDidLoadExtensions addObject:ext];
}

-(void)addViewDidAppearExtension:(nonnull ViewDidAppear_Ext)ext {
    [self.viewDidAppearExtensions addObject:ext];
}


#pragma mark - Extendability Implementation -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (ViewDidLoad_Ext ext in self.viewDidLoadExtensions) {
        ext();
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for (ViewDidAppear_Ext ext in self.viewDidAppearExtensions) {
        ext(animated);
    }
}





@end
