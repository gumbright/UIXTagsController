//
//  UIXTagView.m
//  hwredesign
//
//  Created by Guy Umbright on 12/20/13.
//  Copyright (c) 2013 Umbright Consulting, Inc. All rights reserved.
//

#import "UIXTagView.h"
#import <QuartzCore/QuartzCore.h>

@interface UIXTagView ()
@property (nonatomic, strong) UILabel* tagLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint* labelLeading;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint* labelTrailing;
@property (nonatomic, strong) CAShapeLayer* shapeLayer;
@property (nonatomic, strong) NSString* tagValue;
@end

@implementation UIXTagView
/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) commonInit
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [self.tagLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tagLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.tagLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.tagLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self addSubview:self.tagLabel];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tagLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tagLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];

    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.lineWidth = 2.0;
    self.shapeLayer.strokeColor = self.tagBorderColor.CGColor;
    self.shapeLayer.fillColor = self.tagFillColor.CGColor;
    
    [self.layer insertSublayer:self.shapeLayer atIndex:0];    
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (CGSize) intrinsicContentSize
{
    CGSize size = [self.tagLabel intrinsicContentSize];
    size.width += 16;
    size.height = 30;
    
    return size;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) setTagString:(NSString *)tagString
{
    _tagString = tagString;
    _tagLabel.text = tagString;
    
    [self layoutIfNeeded];
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) layoutSubviews
{
    [super layoutSubviews];
    CGSize sz = [self intrinsicContentSize];
    
    CGRect r = CGRectMake(0, 0, sz.width, sz.height);
    r = CGRectInset(r, 1, 1);
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:r
                                                    cornerRadius:r.size.height/2];
    self.shapeLayer.path = path.CGPath;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) setActiveTag:(BOOL)activeTag
{
    _activeTag = activeTag;
    
    if (activeTag)
    {
        self.shapeLayer.strokeColor = self.selectedTagBorderColor.CGColor;
        self.shapeLayer.fillColor = self.selectedTagFillColor.CGColor;
        self.tagLabel.textColor = self.selectedTagTextColor;
    }
    else
    {
        self.shapeLayer.strokeColor = self.tagBorderColor.CGColor;
        self.shapeLayer.fillColor = self.tagFillColor.CGColor;
        self.tagLabel.textColor = self.tagTextColor;
    }
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*) tagBorderColor
{
    if (_tagBorderColor == nil)
    {
        return [UIColor blackColor];
    }
    return _tagBorderColor;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*) selectedTagBorderColor
{
    if (_selectedTagBorderColor == nil)
    {
        return [UIColor blackColor];
    }
    return _selectedTagBorderColor;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*)  tagFillColor
{
    if (_tagFillColor == nil)
    {
        return [UIColor whiteColor];
    }
    return _tagFillColor;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*)  selectedTagFillColor
{
    if (_selectedTagFillColor == nil)
    {
        return [UIColor blackColor];
    }
    return _selectedTagFillColor;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*)  tagTextColor
{
    if (_tagTextColor == nil)
    {
        return [UIColor blackColor];
    }
    return _tagTextColor;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UIColor*)  selectedTagTextColor
{
    if (_selectedTagTextColor == nil)
    {
        return [UIColor whiteColor];
    }
    return _selectedTagTextColor;
}
@end
