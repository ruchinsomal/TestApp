//
//  ViewController.m
//  TestApp
//
//  Created by ruchin somal on 02/04/16.
//  Copyright © 2016 ruchin somal. All rights reserved.
//

#import "ViewController.h"
#import "HttpManager.h"
#import "FlowersCell.h"
#import "ImageViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
{
    HttpManager *httpManager;
    NSMutableArray *name;
    NSMutableArray *url;
    NSMutableArray *likes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    likes = [[NSMutableArray alloc] init];
    name = [[NSMutableArray alloc]init];
    url = [[NSMutableArray alloc]init];
    httpManager = [[HttpManager alloc]init];
    [self getFlowersData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// get flowers data

-(void)getFlowersData
{
    SuccessRequestBlock callback = ^(BOOL wasSuccessful, NSDictionary *dict) {
        if (wasSuccessful) {
            for(id key in dict[@"data"]) {
                [name addObject:key[@"name"]];
                [url addObject:key[@"url"]];
                [likes addObject:@"no"];
                [self.activityIndicator stopAnimating];
            }
        } else {
            [self.activityIndicator stopAnimating];UIAlertController * alert=   [UIAlertController
                                                                                 alertControllerWithTitle:@"Error"
                                                                                 message:@"Something went Wrong, Please try again"
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            // handle ok button
                                            
                                            
                                        }];
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        bool check = [userDefault boolForKey:@"check"];
        if (!check) {
            [userDefault setBool:YES forKey:@"check"];
        }
        else
        {
            likes = [[userDefault arrayForKey:@"likes"]mutableCopy];
        }
        [self.tableView reloadData];
    };
    NSDictionary *dict = @{@"parameter1" : @"NO",@"parameter2" : @"Backend",@"parameter3" : @"flower.php"};
    [httpManager getRequestWithCallBack:dict withCallback:callback];
}

// tableview delegate function
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     FlowersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell != nil) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            //Background Thread
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url[indexPath.row]]];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            cell.flowerImageView.image = [UIImage imageWithData:data];
        });
        });
        cell.flowerImageView.tag = indexPath.row;
        cell.flowerImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [cell.flowerImageView addGestureRecognizer:tap];
        cell.likeButton.tag = indexPath.row;
        cell.flowerNameLabel.text = name[indexPath.row];
        [cell.shareButton addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeButton addTarget:self action:@selector(add_deleteLike:) forControlEvents:UIControlEventTouchUpInside];
        if ([likes[indexPath.row]isEqual: @"no"]) {
            [cell.likeButton setImage:[UIImage imageNamed:@"blank_heart"] forState:UIControlStateNormal];
        } else {
            [cell.likeButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return name.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//share button

- (void)shareBtn:(UIButton *)button
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Share"
                                  message:@"Do you want to share image url and name"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    // handle yes button
                                    
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   // handle no button
                                   
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
// tap on the imageview
- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    [self performSegueWithIdentifier:@"imageSegue" sender:url[recognizer.view.tag]];
}

// add_deleter like button

-(void)add_deleteLike:(UIButton *)button
{
    if ([likes[button.tag]  isEqual: @"no"]) {
        likes[button.tag] = @"yes";
        [button setImage:[UIImage imageNamed:@"blank_heart"] forState:UIControlStateNormal];
    } else {
        likes[button.tag] = @"no";
        [button setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    }
    [[NSUserDefaults standardUserDefaults] setObject:likes forKey:@"likes"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
    
}
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([[segue identifier] isEqualToString:@"imageSegue"])
     { ImageViewController *vc = [segue destinationViewController];
         vc.imageUrl = sender;
     }
 }
@end
