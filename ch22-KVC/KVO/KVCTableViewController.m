//
//  KVCTableViewController.m
//  Copyright (c) 2012 Rob Napier
//
//  This code is licensed under the MIT License:
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

#import "KVCTableViewController.h"
#import "KVCTableViewCell.h"
#import "RNTimer.h"

@interface KVCTableViewController ()
@property (readwrite, strong) RNTimer *timer;
@property (readwrite, strong) NSDate *now;
@end

@implementation KVCTableViewController

- (void)updateNow {
  self.now = [NSDate date];
}

- (void)viewDidLoad {
  [self updateNow];

  __weak id weakSelf = self;
  self.timer =
      [RNTimer repeatingTimerWithTimeInterval:1
                                        block:^{
                                          [weakSelf updateNow];
                                        }];
}

- (void)viewDidUnload {
  self.timer = nil;
  self.now = nil;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"KVCTableViewCell";
  
  KVCTableViewCell *cell = [tableView
             dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    cell = [[KVCTableViewCell alloc]
            initWithReuseIdentifier:CellIdentifier];
    [cell setProperty:@"now"];
    [cell setObject:self];
  }
    
  return cell;
}

@end
