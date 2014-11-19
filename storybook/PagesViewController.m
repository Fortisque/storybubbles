//
//  PagesViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "PagesViewController.h"
#import "BasePageViewController.h"
#import "VoicePageViewController.h"
#import "SampleTwoViewController.h"
#import "UnscrambleWordsViewController.h"

@interface PagesViewController ()
@property (nonatomic, strong) NSArray *vcs;
@end

@implementation PagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"load");
    
    NSDictionary *image1 = @{
                             kImageName: @"character",
                             kFrame: @[@200,@100,@100,@100]
                             };
    NSDictionary *image2 = @{
                             kImageName: @"character",
                             kFrame: @[@500,@300,@100,@100]
                             };
    NSDictionary *text1 = @{
                            kText: @"hello!",
                            kFrame:@[@100,@100,@100,@100]
                            };
    NSDictionary *text2 = @{
                            kText: @"welcome to the best story eva",
                            kFrame:@[@100,@300,@300,@100]
                            };

    
    NSArray *images = @[image1, image2];
    NSArray *texts = @[text1, text2];
    
    BasePageViewController *normalPageViewController = [[BasePageViewController alloc] initWithTextLabels:texts andImageViews:images];
                                                        
    VoicePageViewController *voicePageViewController = [[VoicePageViewController alloc] initWithText:@"What happens next" andImageName:@""];

    UnscrambleWordsViewController *unscrambleWordsVC = [[UnscrambleWordsViewController alloc] initWithText:@"how do you spell this" andImageName:@"character"];
    
    self.vcs = [NSArray arrayWithObjects:normalPageViewController, voicePageViewController, unscrambleWordsVC, nil];
    
    NSArray *viewControllers = [NSArray arrayWithObjects:normalPageViewController, nil];
    
    [self setViewControllers:viewControllers
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:NO
                            completion:nil];

    
    //[self didMoveToParentViewController:self];
    self.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSLog(@"before");
    
    NSUInteger index = [_vcs indexOfObject:viewController];
    
    if (index == 0) {
        return nil;
    }
    return [_vcs objectAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSLog(@"after");
    
    NSUInteger index = [_vcs indexOfObject:viewController];
    
    NSUInteger newIndex = index + 1;
    
    if (newIndex == [_vcs count]) {
        return nil;
    }
    
    return [_vcs objectAtIndex:newIndex];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
