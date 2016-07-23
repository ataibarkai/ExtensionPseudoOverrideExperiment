//
//  RuntimeInspector.h
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 7/22/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstanceMethod.h"

@interface RuntimeInspector : NSObject


+(void)callMethodsApparentlyExtendingSelector:(SEL)selector onInstance:(id)instance withArguments:(NSArray *)args;

@end
