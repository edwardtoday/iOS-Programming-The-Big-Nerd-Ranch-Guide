//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by edwardtoday on 12/26/14.
//  Copyright (c) 2014 edwardtoday. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController ()
@property(nonatomic) BNRHypnosisView *hypnosis;

@end

@implementation BNRHypnosisViewController

- (void)loadView {
  // Create a view
  _hypnosis = [[BNRHypnosisView alloc] init];

  // Set it as *the* view of this view controller
  self.view = _hypnosis;

  UISegmentedControl *segmentCtrl = [[UISegmentedControl alloc]
      initWithItems:@[ @"Red", @"Green", @"Blue" ]];
  [segmentCtrl setBackgroundColor:[UIColor whiteColor]];
  segmentCtrl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |
                                 UIViewAutoresizingFlexibleBottomMargin |
                                 UIViewAutoresizingFlexibleLeftMargin |
                                 UIViewAutoresizingFlexibleRightMargin;
  [segmentCtrl addTarget:self
                  action:@selector(changeColorTo:)
        forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:segmentCtrl];
}

- (void)changeColorTo:(UISegmentedControl *)segment {
  switch (segment.selectedSegmentIndex) {
  case 0:
    [_hypnosis setCircleColor:[UIColor redColor]];
    break;
  case 1:
    [_hypnosis setCircleColor:[UIColor greenColor]];
    break;
  case 2:
    [_hypnosis setCircleColor:[UIColor blueColor]];
    break;
  default:
    break;
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  NSLog(@"BNRHypnosisViewController loaded its view.");
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  if (self) {
    // Set the tab bar item's title
    self.tabBarItem.title = @"Hypnotize";

    // Create a UIImage from a file
    // This will use Hypno@2x.png on retina display devices
    UIImage *i = [UIImage imageNamed:@"Hypno.png"];

    // Put that image on the tab bar item
    self.tabBarItem.image = i;
  }
  return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
