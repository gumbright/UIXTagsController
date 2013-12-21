//
//  UIXTagsController.h
//  UIXTagsControllerDemo
//
//  Created by Guy Umbright on 11/12/13.
//  Copyright (c) 2013 Umbright Consulting, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIXTagInfo : NSObject
@property (nonatomic, copy) NSString* tag;
@property (nonatomic, assign) BOOL tagIsActive;
@end

@class UIXTagsController;

@protocol UIXTagsControllerDatasource <NSObject>

- (NSInteger) tagsControllerNumberOfTags:(UIXTagsController*) controller;
- (void) tagController:(UIXTagsController *)controller infoForTag:(UIXTagInfo*) tagInfo atIndex:(NSInteger) index;

- (void) tagController:(UIXTagsController*) controller filterChanged:(NSString*) newFilter;

- (NSInteger) tagController:(UIXTagsController*) controller createTag:(NSString*) tag;

//- (BOOL) tagController:(UIXTagsController*) controller markTagAsSelected: (NSInteger) index;
@end

@protocol UIXTagsControllerDelegate <NSObject>

//returns YES if tag should be reloaded
- (BOOL) tagController:(UIXTagsController *)controller selectedTagAtIndex:(NSInteger) index;

@end

@interface UIXTagsController : UIViewController
@property (nonatomic, weak) NSObject<UIXTagsControllerDatasource>* datasource;
@property (nonatomic, weak) NSObject<UIXTagsControllerDelegate>* delegate;

+ (UIXTagsController*) controller;

@end
