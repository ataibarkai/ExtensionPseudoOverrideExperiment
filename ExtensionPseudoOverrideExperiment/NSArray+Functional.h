//
//  NSArray+Functional.h
//  ExtensionPseudoOverrideExperiment
//
//  Created by Atai Barkai on 7/22/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^FilterBlock)(id element);
typedef id (^MapBlock)(id element);

@interface NSArray (Functional)

/**
 @brief Filters `self` using the given block
 
 @param shouldInclude for each element, returns `YES` if it should be included in the filtered array, and `NO` otherwise
 
 @return a new filtered array
 */
-(instancetype)filtered:(FilterBlock)shouldInclude;

/**
 @brief Transfors `self` into a new array using the given transformation
 
 @param transformation A block which transforms current array elements into new array elements
 
 @return A new transformed array
 */
-(instancetype)map:(MapBlock)transformation;

@end
