//
//  ViewController.m
//  HJProtocolDispatcherDemo
//
//  Created by haijiao on 16/8/8.
//  Copyright © 2016年 olinone. All rights reserved.
//

#import "ViewController.h"
#import "DelegateSource.h"
#import "ProtocolDispatcher.h"

@interface ViewController () 

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DelegateSource *delegateSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    self.delegateSource = [DelegateSource new];
    
    self.tableView.delegate = AOProtocolDispatcher(UITableViewDelegate, self, self.delegateSource);
    self.tableView.dataSource = self.delegateSource;
}

#pragma mark -

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"vc");
}

@end
