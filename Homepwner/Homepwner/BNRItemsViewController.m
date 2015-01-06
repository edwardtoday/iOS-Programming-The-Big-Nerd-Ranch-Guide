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
#import "BNRDetailViewController.h"

@interface BNRItemsViewController ()

@property(nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

- (instancetype)init {
  // Call the superclass's designated initializer
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    //    for (int i = 0; i < 5; i++) {
    //      [[BNRItemStore sharedStore] createItem];
    //    }
  }
  return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return [[[BNRItemStore sharedStore] allItems] count] + 1;
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

  if (![self itemStoreHasItemAtIndexPath:indexPath]) {
    cell.textLabel.text = @"No more items!";
  } else {

    // Set the text on the cell with the description of the item that is at the
    // nth index of items, where n = row this cell will appear in on the
    // tableview
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];

    cell.textLabel.text = [item description];
  }

  return cell;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:@"UITableViewCell"];

  UIView *header = self.headerView;
  [self.tableView setTableHeaderView:header];
}

- (IBAction)addNewItem:(id)sender {
  // Create a new BNRItem and add it to the store
  BNRItem *newItem = [[BNRItemStore sharedStore] createItem];

  // Figure out where that item is in the array
  NSInteger lastRow =
      [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];

  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];

  // Insert this new row into the table
  [self.tableView insertRowsAtIndexPaths:@[ indexPath ]
                        withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction)toggleEditingMode:(id)sender {
  // It you are currently in editing mode...
  if (self.isEditing) {
    // Change text of button to inform user of state
    [sender setTitle:@"Edit" forState:UIControlStateNormal];
    //

    // Turn off editing mode
    [self setEditing:NO animated:YES];
  } else {
    // Change text of button to inform user of state
    [sender setTitle:@"Done" forState:UIControlStateNormal];

    // Enter editing mode
    [self setEditing:YES animated:YES];
  }
}

- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath *)indexPath {
  // If the table view is asking to commit a delete command...
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    if (item) {

      [[BNRItemStore sharedStore] removeItem:item];

      // Also remove that row from the table view with an animation
      [tableView deleteRowsAtIndexPaths:@[ indexPath ]
                       withRowAnimation:UITableViewRowAnimationFade];
    }
  }
}

- (void)tableView:(UITableView *)tableView
    moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
           toIndexPath:(NSIndexPath *)destinationIndexPath {
  [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                      toIndex:destinationIndexPath.row];
}

- (UIView *)headerView {
  // If you have not loaded the headerView yet...
  if (!_headerView) {
    // Load HeaderView.xib
    [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
  }
  return _headerView;
}

- (NSString *)tableView:(UITableView *)tableView
    titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
  return @"Remove";
}

- (NSIndexPath *)tableView:(UITableView *)tableView
    targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
                         toProposedIndexPath:
                             (NSIndexPath *)proposedDestinationIndexPath {

  if (![self itemStoreHasItemAtIndexPath:sourceIndexPath]) {
    return sourceIndexPath;
  }

  if (![self itemStoreHasItemAtIndexPath:proposedDestinationIndexPath]) {
    return [NSIndexPath
        indexPathForRow:
            [self tableView:tableView
                numberOfRowsInSection:proposedDestinationIndexPath.section] -
            1 inSection:proposedDestinationIndexPath.section];
  }
  return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (![self itemStoreHasItemAtIndexPath:indexPath]) {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    return;
  }

  BNRDetailViewController *detailViewController =
      [[BNRDetailViewController alloc] init];

  NSArray *items = [[BNRItemStore sharedStore] allItems];
  BNRItem *selectedItem = items[indexPath.row];

  // Give detail view controller a pointer to the item object in row
  detailViewController.item = selectedItem;

  // Push it onto the top of the navigation controller's stack
  [self.navigationController pushViewController:detailViewController
                                       animated:YES];
}

- (BOOL)itemStoreHasItemAtIndexPath:(NSIndexPath *)indexPath {
  NSUInteger rowsInStore = [[[BNRItemStore sharedStore] allItems] count];
  if (indexPath.row < rowsInStore) {
    return YES;
  }
  return NO;
}

@end
