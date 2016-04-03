//
//  ImageViewController.h
//  TestApp
//
//  Created by ruchin somal on 03/04/16.
//  Copyright © 2016 ruchin somal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)crossButton:(id)sender;

@property (strong, nonatomic)NSString *imageUrl;
@end
