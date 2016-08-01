//
//  InstanceMethod.m
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 7/22/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import "InstanceMethod.h"

#pragma mark - Private Interface -

@interface InstanceMethod()
@property (nonatomic, assign) Method method;
@end

#pragma mark - Implementation -

@implementation InstanceMethod

#pragma mark Class Methods

+(BOOL)returnTypeStringIsSignifyingVoid:(NSString *)returnTypeString {
    return [returnTypeString isEqualToString:@"v"];
}

#pragma mark Initalization

-(instancetype)initWithMethod:(Method)method {
    self = [super init];
    if (self) {
        self.method = method;
    }
    
    return self;
}

#pragma mark Convenience Properties Implementation

-(NSString *)name {
    return NSStringFromSelector(method_getName(self.method));
}

-(NSString *)returnTypeString {
    char typeStr[256];
    method_getReturnType(self.method, typeStr, sizeof(typeStr));
    
    return [NSString stringWithCString:typeStr encoding:NSASCIIStringEncoding];
}

-(NSString *)typeEncodingString {
    return [NSString stringWithCString:method_getTypeEncoding(self.method) encoding:NSASCIIStringEncoding];
}


-(NSString *)uniqueIdentifier {
    return [NSString stringWithFormat:@"%@-%@", self.name, self.typeEncodingString];
}

@end
