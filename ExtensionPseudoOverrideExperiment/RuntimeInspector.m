//
//  RuntimeInspector.m
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 7/22/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import "RuntimeInspector.h"
#import "NSArray+Functional.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation RuntimeInspector

#pragma mark - Public Methods -

+(void)callMethodsApparentlyExtendingSelector:(SEL)selector onInstance:(id)instance withArguments:(void *)arg0, ... {
    
    // gather variadic arguments into an array
    NSMutableArray *argumentArray = [NSMutableArray array];
    va_list args;
    va_start(args, arg0);
    for (void *nextArg = arg0; nextArg != nil; nextArg = va_arg(args, void *)) {
        [argumentArray addObject:[NSValue valueWithPointer:nextArg]];
    }
    va_end(args);
    
    
    [self callMethodsApparentlyExtendingSelector:selector onInstance:instance withArgumentsArray:argumentArray];
}



#pragma mark - Private Helper Methods -

/**
 @brief Call every method which extends the given method according to our method-extending convention
 
 @param selector the selector associated with the method we wish to extend
 @param instance the instance on which we wish to invoke the extending methods
 @param args     An array of `NSValue`-wrapped `void *` buffers (pointers) to the arguments to be passed to the extending methods
 */
+(void)callMethodsApparentlyExtendingSelector:(SEL)selector onInstance:(id)instance withArgumentsArray:(NSArray *)args {
    
    NSArray *methodsToCall = [self methodsApparentlyExtendingSelector:selector onClass:object_getClass(instance)];
    
    for (InstanceMethod *method in methodsToCall) {
        [self callMethod:method onInstance:instance withArgumentsArray:args];
    }
}

/**
 @brief Call the given method on the given instance with the given arguments
 
 @param method   the method we wish to call
 @param instance the instance on which we wish to call the method
 @param args     An array of `NSValue`-wrapped `void *` buffers (pointers) to the arguments to be passed to the extending methods
 */
+(void)callMethod:(InstanceMethod *)method onInstance:(id)instance withArgumentsArray:(NSArray *)args {
    
    SEL selectorToCall = NSSelectorFromString(method.name);
    
    NSMethodSignature *signature = [instance methodSignatureForSelector:selectorToCall];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selectorToCall];
    [invocation setTarget:instance];
    for (int i = 0; i < args.count; i++) {
        NSValue *nextArgPointer = [args objectAtIndex:i];
        [invocation setArgument:([nextArgPointer pointerValue]) atIndex:i+2]; // we place at index (i+2) because the first 2 args are reserved
    }
    
    [invocation invoke];

}

/**
 @brief Get an array of all the methods which apparently extend the given selector on the given class, according to method-extending semantics and convention
 
 @param selector        the selector associated with the method we wish to extend
 @param associatedClass the class associated with the method we wish to extend
 
 @return an array of the instance methods determined to extend the given method
 
 @see `[RuntimeInspector instanceMethod:extendsMethod:]` for method-extending semantics and convention
 */
+(NSArray<InstanceMethod *> *)methodsApparentlyExtendingSelector:(SEL)selector onClass:(Class)associatedClass {
    NSArray <InstanceMethod *> *allInstanceMethodsOfClass = [self allInstanceMethodsAssociatedWithClass:associatedClass];

    InstanceMethod *extendedMethod = [[InstanceMethod alloc] initWithMethod:class_getInstanceMethod(associatedClass, selector)];
    NSArray <InstanceMethod *> *extensionsOfGivenMethod = [allInstanceMethodsOfClass filtered:^BOOL(InstanceMethod *element) {
        return [self instanceMethod:element extendsMethod:extendedMethod];
    }];
    
    return extensionsOfGivenMethod;
}


+(NSArray<InstanceMethod *> *)allInstanceMethodsAssociatedWithClass:(Class)associatedClass {
    
    // get all of the methods associated with the given class, in the most primitive representation
    unsigned int methodListCount = 0;
    Method * methodList = class_copyMethodList(associatedClass, &methodListCount);
    
    // turn each method into an `InstanceMethod` and add it to the returned array
    NSMutableArray *returned  = [NSMutableArray arrayWithCapacity: methodListCount];
    for(int i = 0; i < methodListCount; i++) {
        InstanceMethod *correspondingInstanceMethod = [[InstanceMethod alloc] initWithMethod:methodList[i]];
        [returned addObject: correspondingInstanceMethod];
    }
    
    return returned;
}



/**
 @brief Determine whether one method appears to extend another method according to method-extension semantics as well as our method-extendion convention
 
 @param potentiallyExtendingMethod the method-extending candidate
 @param originalMethod             the method we wish to extend
 
 @return `YES` if the `potentiallyExtendingMethod` extends `originalMethod`, and `NO` otherwise
 */
+(BOOL)instanceMethod:(InstanceMethod *)potentiallyExtendingMethod extendsMethod:(InstanceMethod *)originalMethod {
    return
    
    // method-extending semantic conditions
        // only void-returning functions can be extensions of functions
        [InstanceMethod returnTypeStringIsSignifyingVoid:potentiallyExtendingMethod.returnTypeString] &&
    
        // the given method has the same type as the extended method
        [potentiallyExtendingMethod.typeEncodingString isEqualToString:originalMethod.typeEncodingString] &&
    
    // method-extending convention conditions
        // if we are extending `func`, we want functions of the form `something_DXExtending_func`
        [potentiallyExtendingMethod.name hasSuffix:[NSString stringWithFormat:@"_DXExtending_%@", originalMethod.name]];
}


@end
