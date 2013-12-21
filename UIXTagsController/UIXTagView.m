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
    UILabel* tagLabel = self.tagLabel;
    
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

//    NSArray* arr = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[tagLabel(>=0)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tagLabel)];
//    [self addConstraints:arr];
//    arr = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[tagLabel(40)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(tagLabel)];
//    [self addConstraints:arr];
    
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.lineWidth = 1.0;
    self.shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    
    [self.layer insertSublayer:self.shapeLayer atIndex:0];
    //    [self.contentView.layer insertSublayer:self.shapeLayer atIndex:0];
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
    size.height = 40;
    
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
        self.shapeLayer.fillColor = [UIColor greenColor].CGColor;
        self.tagLabel.textColor = [UIColor whiteColor];
    }
    else
    {
        self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        self.tagLabel.textColor = [UIColor blackColor];
    }
}

@end
