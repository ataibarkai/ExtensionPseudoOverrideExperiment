//
//  InstanceMethod.h
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 7/22/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface InstanceMethod: NSObject

+(BOOL)returnTypeStringIsSignifyingVoid:(NSString *)returnTypeString;

//-(instancetype)initWithClass:(Class)associatedClass selector:(SEL)selector;
-(instancetype)initWithMethod:(Method)method;

//@property (nonatomic, readonly) Class associatedClass;
//@property (nonatomic, readonly) SEL selector;
@property (nonatomic, readonly) Method method;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *returnTypeString;
@property (nonatomic, readonly) NSString *typeEncodingString;


@end