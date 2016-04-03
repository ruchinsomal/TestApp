//
//  ImageViewController.m
//  TestApp
//
//  Created by ruchin somal on 03/04/16.
//  Copyright © 2016 ruchin somal. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController
@synthesize imageUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            self.imageView.image = [UIImage imageWithData:data];
            self.imageView.contentMode = UIViewContentModeCenter;
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)crossButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
