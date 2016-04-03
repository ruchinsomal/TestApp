//
//  FlowersCell.h
//  TestApp
//
//  Created by ruchin somal on 02/04/16.
//  Copyright © 2016 ruchin somal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *flowerImageView;
@property (weak, nonatomic) IBOutlet UILabel *flowerNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end
