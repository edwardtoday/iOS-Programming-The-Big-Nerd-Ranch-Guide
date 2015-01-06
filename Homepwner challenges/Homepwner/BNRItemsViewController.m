//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by qingpei on 1/5/15.
//  Copyright (c) 2015 qingpei. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController ()
@property(nonatomic) NSArray *sectionTitles;
@end

@implementation BNRItemsViewController

- (instancetype)init {
  // Call the superclass's designated initializer
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.sectionTitles = @[ @"more than $50", @"others" ];
    for (int i = 0; i < 1; i++) {
      [[BNRItemStore sharedStore] createItem];
    }
  }
  return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  NSArray *items = [[BNRItemStore sharedStore] allItems];
  NSPredicate *predicate = nil;
  NSArray *filteredItems = nil;
  switch (section) {
  case 0: {
    predicate = [NSPredicate predicateWithFormat:@"valueInDollars > 50"];
    filteredItems = [items filteredArrayUsingPredicate:predicate];
  } break;

  case 1: {
    predicate = [NSPredicate predicateWithFormat:@"valueInDollars <= 50"];
    filteredItems = [items filteredArrayUsingPredicate:predicate];
  } break;

  default:
    break;
  }
  return section == [self numberOfSectionsInTableView:tableView] - 1
             ? [filteredItems count] + 1 // add a constant row in last section
             : [filteredItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  // Create an instance of UITableViewCell, with default appearance
  //  UITableViewCell *cell = [[UITableViewCell alloc]
  //  initWithStyle:UITableViewCellStyleDefault
  //  reuseIdentifier:@"UITableViewCell"];

  // Get a new or recycled cell
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                      forIndexPath:indexPath];

  // Set the text on the cell with the description of the item that is at the
  // nth index of items, where n = row this cell will appear in on the tableview
  NSArray *items = [[BNRItemStore sharedStore] allItems];
  NSPredicate *predicate = nil;
  NSArray *filteredItems = nil;
  BNRItem *item = nil;
  switch (indexPath.section) {
  case 0: {
    predicate = [NSPredicate predicateWithFormat:@"valueInDollars > 50"];
    filteredItems = [items filteredArrayUsingPredicate:predicate];
  } break;

  case 1: {
    predicate = [NSPredicate predicateWithFormat:@"valueInDollars <= 50"];
    filteredItems = [items filteredArrayUsingPredicate:predicate];
  } break;

  default:
    break;
  }

  if (indexPath.row == [filteredItems count]) {
    cell.textLabel.text = @"No more items!";
  } else {
    item = filteredItems[indexPath.row];

    cell.textLabel.text = [item description];
  }

  return cell;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSString *)tableView:(UITableView *)tableView
    titleForHeaderInSection:(NSInteger)section {
  return self.sectionTitles[section];
}

@end
