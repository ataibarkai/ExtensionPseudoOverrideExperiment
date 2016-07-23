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

/**
 @brief Call every method which extends the given method according to our method-extending convention.
 
 @discussion 
 
 @param selector the selector associated with the method we wish to extend
 @param instance the instance on which we wish to invoke the extending methods
 @param args     a `nil`-terminated list of `void *` buffers (pointers) to the arguments to be passed to the extending methods
 */
+(void)callMethodsApparentlyExtendingSelector:(SEL)selector
                                   onInstance:(id)instance
                                withArguments:(void *)args, ...;

@end
