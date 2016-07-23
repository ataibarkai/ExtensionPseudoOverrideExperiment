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

+(void)callMethodsApparentlyExtendingSelector:(SEL)selector onInstance:(id)instance {
    
    NSArray *methodsToCall = [self voidMethodsApparentlyExtendingSelector:selector onClass:object_getClass(instance)];
    
    for (InstanceMethod *method in methodsToCall) {
        [instance performSelector:NSSelectorFromString(method.name)];
    }
}

#pragma mark - Private Helper Methods -

+(NSArray<InstanceMethod *> *)voidMethodsApparentlyExtendingSelector:(SEL)selector onClass:(Class)associatedClass {
    
    InstanceMethod *extendedMethod = [[InstanceMethod alloc] initWithMethod:class_getInstanceMethod(associatedClass, selector)];
    
    NSArray <InstanceMethod *> *allInstanceMethodsOfClass = [self allInstanceMethodsAssociatedWithClass:associatedClass];
    NSArray <InstanceMethod *> *voidOnly = [allInstanceMethodsOfClass filtered:^BOOL(InstanceMethod *element) {
        return [InstanceMethod returnTypeStringIsSignifyingVoid:element.returnTypeString];
    }];
    
    NSString *acceptablePrefixForExtendingMethods = [NSString stringWithFormat:@"%@_", extendedMethod.name];
    NSArray <InstanceMethod *> *extensionsOfGivenMethod = [voidOnly filtered:^BOOL(InstanceMethod *element) {
        return
        [element.name hasPrefix:acceptablePrefixForExtendingMethods] &&                 // the given method has an acceptable name
        [element.typeEncodingString isEqualToString:extendedMethod.typeEncodingString]; // the given method has the same type as the extended method
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


+(NSArray<InstanceMethod *> *)keepVoidOnlyFromInstanceMethodArray:(NSArray<InstanceMethod *> *)instanceMethods {
    NSMutableArray<InstanceMethod *> *returned = [NSMutableArray arrayWithCapacity: [instanceMethods count]];
    
    for (InstanceMethod *methodWrapper in instanceMethods) {
        Method method = methodWrapper.method;
        
        // get the return type, and check if it is `void`
        char typeStr[256];
        method_getReturnType(method, typeStr, sizeof(typeStr));
        BOOL isVoidReturnType = (strcmp(typeStr, "v") == 0);
        
        if(isVoidReturnType) {
            [returned addObject: methodWrapper];
        }
    }
    
    return returned;
}


@end