//
//  DisplayTableViewCell.h
//  weatherdemo
//
//  Created by admin on 2/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbdateTime;
@property (weak, nonatomic) IBOutlet UILabel *lbhumidity;
@property (weak, nonatomic) IBOutlet UILabel *lbtemp;
@property (weak, nonatomic) IBOutlet UILabel *lbemotion;
@property (weak, nonatomic) IBOutlet UILabel *lbtag;
@property (weak, nonatomic) IBOutlet UILabel *lblocation;
@property (weak, nonatomic) IBOutlet UILabel *lbweather;
@property (weak, nonatomic) IBOutlet UILabel *lbMoonAge;
@property (weak, nonatomic) IBOutlet UILabel *lbSuba;
@property (weak, nonatomic) IBOutlet UILabel *lbSubb;

@end
