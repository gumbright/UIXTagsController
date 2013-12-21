//
//  UIXTagsController.m
//  UIXTagsControllerDemo
//
//  Created by Guy Umbright on 11/12/13.
//  Copyright (c) 2013 Umbright Consulting, Inc. All rights reserved.
//

#import "UIXTagsController.h"
#import "UIXHorizontalPackedLayout.h"
#import "UIXTagCell.h"

@implementation UIXTagInfo
- (instancetype) init
{
    if (self = [super init])
    {
        self.tag = nil;
        self.tagIsActive = NO;
    }
    return self;
}
@end

@interface UIXTagsController ()
@property (nonatomic, strong) IBOutlet UICollectionView* collectionView;
@property (nonatomic, strong) IBOutlet UITextField* entryField;
@property (nonatomic, strong) IBOutlet UIButton* addButton;
@property (nonatomic, strong) UIXTagCell* sizingCell;
@end

@implementation UIXTagsController

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
+ (UIXTagsController*) controller
{
    UIXTagsController* vc = [[UIXTagsController alloc] init];
    return vc;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (id)init
{
    self = [super initWithNibName:@"UIXTagsController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIXHorizontalPackedLayout* layout = [[UIXHorizontalPackedLayout alloc] init];
    layout.delegate = self;
    layout.horizontalSpacing = 10;
    layout.rowSpacing = 10;
    layout.justified = NO;
    layout.rowHeight = 30;
    self.collectionView.collectionViewLayout = layout;

//    UINib *cellNib = [UINib nibWithNibName:@"UIXTagCell" bundle:nil];
//    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"TagCell"];
//    self.sizingCell = [[cellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    
    UINib *cellNib = [UINib nibWithNibName:@"UIXTagCell" bundle:nil];
//    [self.collectionView registerClass:[TagCell class] forCellWithReuseIdentifier:@"TagCell"];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"TagCell"];
    self.sizingCell = [[cellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                      if ([self.datasource respondsToSelector:@selector(tagController:filterChanged:)])
                                                      {
                                                          UITextField* tf = note.object;
                                                          [self.datasource tagController:self filterChanged:tf.text];
                                                          [self.collectionView reloadData];
                                                      }
                                                    
                                                  }];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        CGRect keyboardEndingUncorrectedFrame = [[note.userInfo objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
        
        CGRect collectionFrame = [self.view convertRect:self.collectionView.frame fromView:self.collectionView.superview];
        CGRect overlap = CGRectIntersection(collectionFrame, keyboardEndingFrame);
        
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, overlap.size.height,0);
    }];

    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.collectionView.contentInset = UIEdgeInsetsZero;
    }];
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView*) collectionView
{
    return 1;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSInteger n = [self.datasource tagsControllerNumberOfTags:self];
    self.addButton.enabled = (n == 0);
    return n;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIXTagCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"TagCell" forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL reload = NO;
    
    UIXTagCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(tagController:selectedTagAtIndex:)])
    {
        reload = [self.delegate tagController:self selectedTagAtIndex:indexPath.item];
    }
    
    if (reload)
    {
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
    
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) configureCell:(UIXTagCell*) cell forIndexPath:(NSIndexPath*) indexPath
{
    UIXTagInfo* tagInfo = [[UIXTagInfo alloc] init];
    [self.datasource tagController:self infoForTag:tagInfo atIndex:indexPath.item];

    if (self.tagBorderColor) cell.tagBorderColor = self.tagBorderColor;
    if (self.selectedTagBorderColor) cell.selectedTagBorderColor = self.selectedTagBorderColor;
    if (self.tagFillColor) cell.tagFillColor = self.tagFillColor;
    if (self.selectedTagFillColor) cell.selectedTagFillColor = self.selectedTagFillColor;
    if (self.tagTextColor) cell.tagTextColor = self.tagTextColor;
    if (self.selectedTagTextColor) cell.selectedTagTextColor = self.selectedTagTextColor;

    cell.tagString = tagInfo.tag;
    cell.activeTag = tagInfo.tagIsActive;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (CGSize) UIXPackedLayout: (UIXPackedLayout*) layout sizeForItemAtIndex:(NSIndexPath*) indexPath
{
    [self configureCell:self.sizingCell forIndexPath:indexPath];
    return [self.sizingCell intrinsicContentSize];
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (IBAction) addPressed:(id)sender
{
    [self.entryField resignFirstResponder];
    NSString* newTag = self.entryField.text;
    self.entryField.text = @"";
    [self.datasource tagController:self filterChanged:nil];
    NSInteger newTagIndex = [self.datasource tagController:self createTag:newTag];
    [self.collectionView reloadData];
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (BOOL) textFieldShouldReturn:(UITextField*) textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark Keyboard
- (void) keyboardWillShow: (NSNotification *) note
{
    CGRect keyboardEndingUncorrectedFrame = [[note.userInfo objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    
    CGRect collectionFrame = [self.view convertRect:self.collectionView.frame fromView:self.collectionView.superview];
    CGRect overlap = CGRectIntersection(collectionFrame, keyboardEndingFrame);
    CGRect frame = self.view.frame;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, overlap.size.height);
}

- (void) keyboardWillHide: (NSNotification *) note
{
    self.collectionView.contentInset = UIEdgeInsetsZero;
    
//    UIView*rootView = self.viewController.farthestAncestorController.view;
//    CGRectkeyboardEndingUncorrectedFrame = [[note.userInfoobjectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGRectkeyboardEndingFrame = [rootView convertRect:keyboardEndingUncorrectedFrame  fromView:nil];
//    
//    CGRect frame = self.frame;
//    frame.size.height += self.keyboardHeightAdjustment;
//    
//    CGFloatduration = [[note.userInfoobjectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    CGFloat delay = 0;
//    duration = duration * self.keyboardHeightAdjustment / keyboardEndingFrame.size.height;
//    
//    UIViewAnimationCurve curve = (UIViewAnimationCurve) [[note.userInfoobjectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
//    UIViewAnimationOptions options = 0;
//    switch (curve) {
//        caseUIViewAnimationCurveEaseInOut:
//            options = UIViewAnimationOptionCurveEaseInOut;
//        caseUIViewAnimationCurveEaseIn:
//            options = UIViewAnimationOptionCurveEaseIn;
//        caseUIViewAnimationCurveEaseOut:
//            options = UIViewAnimationOptionCurveEaseOut;
//        caseUIViewAnimationCurveLinear:
//            options = UIViewAnimationOptionCurveLinear;
//    }
//    [UIViewanimateWithDuration: duration delay:delay options:options animations: ^{
//        //self.frame = frame;
//        self.contentInset=UIEdgeInsetsZero;
//    }completion:^(BOOLfinished) {
//    }];
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
//- (void) filterTextChanged:(NSNotification*) notification
//{
//}
@end
