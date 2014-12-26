//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by edwardtoday on 12/26/14.
//  Copyright (c) 2014 edwardtoday. All rights reserved.
//

#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()

@property(nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

- (IBAction)addReminder:(id)sender {
  NSDate *date = self.datePicker.date;
  NSLog(@"Setting a reminder for %@", date);

  UILocalNotification *note = [[UILocalNotification alloc] init];
  note.alertBody = @"Hypnotize me!";
  note.fireDate = date;
  [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  NSLog(@"BNRReminderViewController loaded its view.");
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  if (self) {
    // Get the tab bar item
    UITabBarItem *tbi = self.tabBarItem;
    // Give it a label
    tbi.title = @"Reminder";
    // Give it an image
    UIImage *i = [UIImage imageNamed:@"Time.png"];
    tbi.image = i;
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
