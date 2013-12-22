//
//  ViewController.m
//  UIXTagsControllerDemo
//
//  Created by Guy Umbright on 11/12/13.
//  Copyright (c) 2013 Umbright Consulting, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray* tags;
@property (nonatomic, strong) NSArray* filteredTags;
@property (nonatomic, strong) NSMutableArray* selectedTags;

@end

@implementation ViewController
/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray* arr = @[@"arachnid",@"banana",@"crotch",@"drag",@"ectoplasm",@"flipflop",@"groin",@"hamburger",@"igloo",@"jumper",@"knickknack",@"lubricant",@"muffler",@"ninny",@"ogre",@"puddle",@"quiver",@"retsin",@"strap",@"toaster",@"uvula",@"viceroy",@"witch",@"xiv",@"yodeller",@"zenith",@"apple",@"muppet",@"monsters",@"spork",@"comic",@"frog",@"talentless"];
    self.tags = [NSMutableArray arrayWithArray:[arr sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    self.selectedTags = [NSMutableArray arrayWithObjects:@"igloo",@"viceroy",@"witch",@"knickknack",nil];
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
- (IBAction) navPressed:(id)sender
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIXTagsController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TagsController"];
    UIXTagsController* vc = [UIXTagsController controller];
    vc.datasource = self;
    vc.delegate = self;
    
    vc.tagBorderColor = [UIColor greenColor];
    vc.selectedTagBorderColor = [UIColor orangeColor];
    vc.tagFillColor = [UIColor yellowColor];
    vc.selectedTagFillColor = [UIColor redColor];
    vc.tagTextColor = [UIColor blueColor];
    vc.selectedTagTextColor = [UIColor cyanColor];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UIXTagController
/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (NSInteger) tagsControllerNumberOfTags:(UIXTagsController*) controller
{
    NSInteger n = self.tags.count;
    if (self.filteredTags)
    {
        n = self.filteredTags.count;
    }
    return n;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) tagController:(UIXTagsController *)controller infoForTag:(UIXTagInfo*) tagInfo atIndex:(NSInteger) index;
{
    NSString* s = nil;
    if (self.filteredTags)
    {
        s = self.filteredTags[index];
    }
    else
    {
        s = self.tags[index];
    }
    
    tagInfo.tag = s;
    tagInfo.tagIsActive = [self.selectedTags containsObject:s];
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (void) tagController:(UIXTagsController*) controller filterChanged:(NSString*) newFilter
{
    if (newFilter.length)
    {
        NSIndexSet* indexes = [self.tags indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            BOOL result = NO;
            NSString* s = obj;
            NSRange prefixRange = [s rangeOfString:newFilter
                                                    options:(NSAnchoredSearch | NSCaseInsensitiveSearch)];
            result = (prefixRange.location != NSNotFound);
            return result;
        }];
        
        self.filteredTags = [self.tags objectsAtIndexes:indexes];
    }
    else
    {
        self.filteredTags = nil;
    }
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (BOOL) tagController:(UIXTagsController *)controller selectedTagAtIndex:(NSInteger) index
{
    BOOL result = YES;
    
    UIXTagInfo* tagInfo = [[UIXTagInfo alloc] init];
    
    [self tagController:controller infoForTag:tagInfo atIndex:index];
    if ([self.selectedTags containsObject:tagInfo.tag])
    {
        [self.selectedTags removeObject:tagInfo.tag];
        //remove tag
    }
    else
    {
        [self.selectedTags addObject:tagInfo.tag];
    }
    
    return result;
}

/////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////
- (NSInteger) tagController:(UIXTagsController*) controller createTag:(NSString*) tag
{
    [self.tags addObject:tag];
    self.tags = [NSMutableArray arrayWithArray:[self.tags sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    [self.selectedTags addObject:tag];
    return [self.tags indexOfObject:tag];
}

@end
