//
//  NSArray+Functional.m
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 7/22/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import "NSArray+Functional.h"

@implementation NSArray (Functional)

-(instancetype)filtered:(FilterBlock)shouldInclude {
    NSMutableArray *returned = [NSMutableArray array];
    
    for (id element in self){
        if(shouldInclude(element)) {
            [returned addObject:element];
        }
    }
    return returned;
}

-(instancetype)map:(MapBlock)transformation {
    NSMutableArray *returned = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id element in self){
        [returned addObject:transformation(element)];
    }
    return returned;
}

@end
