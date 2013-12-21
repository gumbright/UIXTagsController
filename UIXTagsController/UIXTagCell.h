//
//  TagCell.h
//  UIXTagsControllerDemo
//
//  Created by Guy Umbright on 11/13/13.
//  Copyright (c) 2013 Umbright Consulting, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIXTagCell : UICollectionViewCell
@property (nonatomic, strong) NSString* tagString;
@property (nonatomic, assign) BOOL activeTag;

@property (nonatomic, strong) UIColor* tagBorderColor;
@property (nonatomic, strong) UIColor* selectedTagBorderColor;
@property (nonatomic, strong) UIColor* tagFillColor;
@property (nonatomic, strong) UIColor* selectedTagFillColor;
@property (nonatomic, strong) UIColor* tagTextColor;
@property (nonatomic, strong) UIColor* selectedTagTextColor;
@end
