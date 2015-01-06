//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by qingpei on 1/6/15.
//  Copyright (c) 2015 qingpei. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()

@property(weak, nonatomic) IBOutlet UITextField *nameField;
@property(weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property(weak, nonatomic) IBOutlet UITextField *valueField;
@property(weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation BNRDetailViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  BNRItem *item = self.item;

  self.nameField.text = item.itemName;
  self.serialNumberField.text = item.serialNumber;
  self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];

  // You need an NSDateFormatter that will turn a date into a simple date string
  static NSDateFormatter *dateFormatter = nil;
  if (!dateFormatter) {
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
  }

  // Use filtered NSDate object to set dateLabel contents
  self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
