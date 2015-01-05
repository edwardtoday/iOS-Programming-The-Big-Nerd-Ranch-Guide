//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by edwardtoday on 12/26/14.
//  Copyright (c) 2014 edwardtoday. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>
@property(nonatomic) BNRHypnosisView *hypnosis;

@end

@implementation BNRHypnosisViewController

- (void)loadView {
  // Create a view
  _hypnosis = [[BNRHypnosisView alloc] init];

  // Set it as *the* view of this view controller
  self.view = _hypnosis;

  CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
  UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
  // Setting the border style on the text field will allow us to see it more
  // easily
  textField.borderStyle = UITextBorderStyleRoundedRect;
  textField.placeholder = @"Hypnotize me";
  textField.returnKeyType = UIReturnKeyDone;

  // There will be a warning on this line. We will discuss it shortly.
  textField.delegate = self;

  [self.view addSubview:textField];

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self drawHypnoticMessage:textField.text];

  textField.text = @"";
  [textField resignFirstResponder];

  return YES;
}

- (void)drawHypnoticMessage:(NSString *)message {
  for (int i = 0; i < 20; i++) {
    UILabel *messageLabel = [[UILabel alloc] init];

    // Configure the label's colors and text
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.text = message;

    // This method resizes the label, which will be relative to the text that it
    // is displaying
    [messageLabel sizeToFit];

    // Get a random x value that fits within the hypnosis view's width
    int width =
        (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
    int x = arc4random() % width;

    // Get a random y value that fits within the hypnosis view's height
    int height =
        (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
    int y = arc4random() % height;

    // Update the label's frame
    CGRect frame = messageLabel.frame;
    frame.origin = CGPointMake(x, y);
    messageLabel.frame = frame;

    // Add the label to the hierarchy
    [self.view addSubview:messageLabel];

    UIInterpolatingMotionEffect *motionEffect;
    motionEffect = [[UIInterpolatingMotionEffect alloc]
        initWithKeyPath:@"center.x"
                   type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionEffect.minimumRelativeValue = @(-25);
    motionEffect.maximumRelativeValue = @(25);
    [messageLabel addMotionEffect:motionEffect];

    motionEffect = [[UIInterpolatingMotionEffect alloc]
        initWithKeyPath:@"center.y"
                   type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    motionEffect.minimumRelativeValue = @(-25);
    motionEffect.maximumRelativeValue = @(25);
    [messageLabel addMotionEffect:motionEffect];
  }
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
