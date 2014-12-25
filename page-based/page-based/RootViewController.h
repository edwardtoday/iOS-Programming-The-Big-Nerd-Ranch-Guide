//
//  RootViewController.h
//  page-based
//
//  Created by edwardtoday on 12/25/14.
//  Copyright (c) 2014 edwardtoday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

