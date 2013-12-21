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
@end
