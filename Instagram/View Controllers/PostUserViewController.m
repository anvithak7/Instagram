//
//  PostUserViewController.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/9/21.
//

#import "PostUserViewController.h"

@interface PostUserViewController ()

@end

@implementation PostUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *user = self.user;
    NSLog(@"%@", user.username);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
