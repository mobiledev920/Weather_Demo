//
//  ViewController.h
//  weatherdemo
//
//  Created by admin on 2/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWTagList.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableviewRegion;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (strong, nonatomic) IBOutlet UITextField *txtSearchTag;
@property (strong, nonatomic) IBOutlet UITableView *tableView3;

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UILabel *lbEmotion;
@property (weak, nonatomic) IBOutlet UILabel *lbAmzed;
@property (weak, nonatomic) IBOutlet UILabel *weatherInfo;
@property (weak, nonatomic) IBOutlet UILabel *currentTemp;

@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (strong, nonatomic) IBOutlet UIView *regionView;
@property (strong, nonatomic) IBOutlet DWTagList *tagListView;

@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) IBOutlet UILabel *currentTime;
@property (strong, nonatomic) IBOutlet UILabel *Today;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

