//
//  UIXPackedLayout.m
//  
//
//  Created by Guy Umbright on 6/25/13.
//
//

#import "UIXPackedLayout.h"

@interface UIXPackedLayout ()
@end

@implementation UIXPackedLayout
/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) commonInit
{
    self.sectionInset = UIEdgeInsetsZero;
    self.justified = NO;
    self.layoutData = nil;
    self.headerData = nil;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (id) init
{
    if (self = [super init])
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
- (CGSize) collectionViewContentSize
{
    return self.layoutContentSize;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (NSArray*) layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* result = [NSMutableArray array];
    
    for (int sectionNdx=0; sectionNdx < self.layoutData.count; ++sectionNdx)
    {
        NSArray* itemArr = self.layoutData[sectionNdx];
        for (int itemNdx=0; itemNdx < itemArr.count; ++itemNdx)
        {
            UICollectionViewLayoutAttributes* attr = itemArr[itemNdx];
            CGRect intersect = CGRectIntersection(rect, attr.frame);
            if (!CGRectIsEmpty(intersect))
            {
                [result addObject:attr];
            }
        }
    }
    
    for (UICollectionViewLayoutAttributes* attr in self.headerData)
    {
        CGRect intersect = CGRectIntersection(rect, attr.frame);
        if (!CGRectIsEmpty(intersect))
        {
            [result addObject:attr];
        }
    }
    return result;
}

/////////////////////////////////////////////////////
//
////////////////////////////////////////////////////
- (UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* arr = self.layoutData[indexPath.section];
    return arr[indexPath.item];
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

#if 0
/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    NSLog(@"prepareForCollectionViewUpdates");
}

- (void)finalizeCollectionViewUpdates
{
    NSLog(@"finalizeCollectionViewUpdates");
}

- (void)finalizeAnimatedBoundsChange
{
    NSLog(@"finalizeAnimatedBoundsChange");
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingDecorationElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath
{
NSLog(@"finalLayoutAttributesForDisappearingDecorationElementOfKind:");
    return [super finalLayoutAttributesForDisappearingDecorationElementOfKind:elementKind atIndexPath:elementIndexPath];
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    NSLog(@"finalLayoutAttributesForDisappearingItemAtIndexPath");
    return [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath
{
    NSLog(@"finalLayoutAttributesForDisappearingSupplementaryElementOfKind");
    return [super finalLayoutAttributesForDisappearingSupplementaryElementOfKind:elementKind atIndexPath:elementIndexPath];
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingDecorationElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath
{
    NSLog(@"initialLayoutAttributesForAppearingDecorationElementOfKind");
    return [super initialLayoutAttributesForAppearingDecorationElementOfKind:elementKind atIndexPath:elementIndexPath];
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    NSLog(@"initialLayoutAttributesForAppearingItemAtIndexPath");
    return [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath
{
    NSLog(@"initialLayoutAttributesForAppearingSupplementaryElementOfKind");
    return [super initialLayoutAttributesForAppearingSupplementaryElementOfKind:elementKind atIndexPath:elementIndexPath];
}
#endif
@end
