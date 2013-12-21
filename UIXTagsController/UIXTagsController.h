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
@protocol UIXPackedLayoutDelegate;

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

@interface UIXTagsController : UIViewController <UIXPackedLayoutDelegate>
@property (nonatomic, weak) NSObject<UIXTagsControllerDatasource>* datasource;
@property (nonatomic, weak) NSObject<UIXTagsControllerDelegate>* delegate;

@property (nonatomic, strong) UIColor* tagBorderColor;
@property (nonatomic, strong) UIColor* selectedTagBorderColor;
@property (nonatomic, strong) UIColor* tagFillColor;
@property (nonatomic, strong) UIColor* selectedTagFillColor;
@property (nonatomic, strong) UIColor* tagTextColor;
@property (nonatomic, strong) UIColor* selectedTagTextColor;

+ (UIXTagsController*) controller;

@end
