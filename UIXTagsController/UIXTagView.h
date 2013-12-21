//
//  UIXTagView.h
//  hwredesign
//
//  Created by Guy Umbright on 12/20/13.
//  Copyright (c) 2013 Umbright Consulting, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIXTagView : UIView
@property (nonatomic, strong) NSString* tagString;
@property (nonatomic, assign) BOOL activeTag;

@property (nonatomic, strong) UIColor* tagBorderColor;
@property (nonatomic, strong) UIColor* selectedTagBorderColor;
@property (nonatomic, strong) UIColor* tagFillColor;
@property (nonatomic, strong) UIColor* selectedTagFillColor;
@property (nonatomic, strong) UIColor* tagTextColor;
@property (nonatomic, strong) UIColor* selectedTagTextColor;
@end
