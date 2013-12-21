//
//  TagCell.m
//  UIXTagsControllerDemo
//
//  Created by Guy Umbright on 11/13/13.
//  Copyright (c) 2013 Umbright Consulting, Inc. All rights reserved.
//

#import "UIXTagCell.h"
#import "UIXTagView.h"
#import <QuartzCore/QuartzCore.h>

@interface UIXTagCell ()
@property (nonatomic, strong) IBOutlet UILabel* tagLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint* labelLeading;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint* labelTrailing;
@property (nonatomic, strong) CAShapeLayer* shapeLayer;
@property (nonatomic, strong) NSString* tagValue;
@property (nonatomic, strong) UIXTagView* tagView;
@end

@implementation UIXTagCell

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) commonInit
{
//    self.shapeLayer = [[CAShapeLayer alloc] init];
//    self.shapeLayer.lineWidth = 1.0;
//    self.shapeLayer.strokeColor = [UIColor greenColor].CGColor;
//    self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
//    [self.contentView.layer insertSublayer:self.shapeLayer atIndex:0];

    self.tagView = [[UIXTagView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:self.tagView];
    
    UIXTagView* tv = self.tagView;
    NSArray* arr = [NSLayoutConstraint constraintsWithVisualFormat:@"|[tv(>=0)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tv)];
    [self addConstraints:arr];
    arr = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tv(>=0)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tv)];
    [self addConstraints:arr];
    
    
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) awakeFromNib
{
    [self commonInit];
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (CGSize) intrinsicContentSize
{
    return [self.tagView intrinsicContentSize];
//    CGSize size = [self.tagLabel intrinsicContentSize];
//    size.width += 16;
//    size.height = 40;
//    
//    return size;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) setTagString:(NSString *)tagString
{
    self.tagView.tagString = tagString;
//    _tagString = tagString;
//    _tagLabel.text = tagString;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
//- (void) layoutSubviews
//{
//    [super layoutSubviews];
//    CGSize sz = [self intrinsicContentSize];
//    
//    CGRect r = CGRectMake(0, 0, sz.width, sz.height);
//    r = CGRectInset(r, 1, 1);
//    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:r
//                                                    cornerRadius:r.size.height/2];
//    self.shapeLayer.path = path.CGPath;
//}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) setActiveTag:(BOOL)activeTag
{
    self.tagView.activeTag = activeTag;
//    _activeTag = activeTag;
//    
//    if (activeTag)
//    {
//        self.shapeLayer.fillColor = [UIColor greenColor].CGColor;
//        self.tagLabel.textColor = [UIColor whiteColor];
//    }
//    else
//    {
//        self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
//        self.tagLabel.textColor = [UIColor blackColor];
//    }
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*) tagBorderColor
{
    return self.tagView.tagBorderColor;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) setTagBorderColor:(UIColor*) color
{
    self.tagView.tagBorderColor = color;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*) selectedTagBorderColor
{
    return self.tagView.selectedTagBorderColor;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) setSelectedTagBorderColor:(UIColor*) color
{
    self.tagView.selectedTagBorderColor = color;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*) tagFillColor
{
    return self.tagView.tagFillColor;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) setTagFillColor:(UIColor*) color
{
    self.tagView.tagFillColor = color;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*) selectedTagFillColor
{
    return self.tagView.selectedTagFillColor;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) setSelectedTagFillColor:(UIColor*) color
{
    self.tagView.selectedTagFillColor = color;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*) tagTextColor
{
    return self.tagView.tagTextColor;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) setTagTextColor:(UIColor*) color
{
    self.tagView.tagTextColor = color;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*) selectedTagTextColor
{
    return self.tagView.selectedTagTextColor;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) setSelectedTagTextColor:(UIColor*) color
{
    self.tagView.selectedTagTextColor = color;
}

@end
