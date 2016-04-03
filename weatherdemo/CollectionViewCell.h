//
//  CollectionViewCell.h
//  weatherdemo
//
//  Created by admin on 2/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblEmotion;
@property (strong, nonatomic) IBOutlet UILabel *lblAmazed;
@property (strong, nonatomic) IBOutlet UILabel *lblSuprised;

@end
