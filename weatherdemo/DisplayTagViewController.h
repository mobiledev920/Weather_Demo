//
//  DisplayTagViewController.h
//  weatherdemo
//
//  Created by admin on 2/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayTagViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *displayTagTableView;
@end
