//
//  ProfileViewController.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/8/21.
//

#import "ProfileViewController.h"
#import "EditProfileViewController.h"
#import "CurrentProfileCell.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = PFUser.currentUser;
    // Do any additional setup after loading the view.
    self.profilePictureView.layer.masksToBounds = YES;
    self.profilePictureView.layer.cornerRadius = self.profilePictureView.frame.size.width / 2;
    self.usernameLabel.text = self.user.username;
    self.fullNameLabel.text = self.user[@"fullName"];
    self.bioLabel.text = self.user[@"bioText"];
    self.numberOfPostsLabel.text = [NSString stringWithFormat:@"%@", self.user[@"userPostsCount"]];
    self.profilePictureView.file = self.user[@"profileImage"];
    [self.profilePictureView loadInBackground];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"editProfile"]) {
        EditProfileViewController *editprofilecontroller = [segue destinationViewController];
        editprofilecontroller.user = self.user; // Passing over user to next view controller.
    }
}

- (void)viewDidAppear:(BOOL)animated {
    self.user = PFUser.currentUser;
    // Do any additional setup after loading the view.
    self.profilePictureView.layer.masksToBounds = YES;
    self.profilePictureView.layer.cornerRadius = self.profilePictureView.frame.size.width / 2;
    self.usernameLabel.text = self.user.username;
    self.fullNameLabel.text = self.user[@"fullName"];
    self.bioLabel.text = self.user[@"bioText"];
    self.numberOfPostsLabel.text = [NSString stringWithFormat:@"%@", self.user[@"userPostsCount"]];
    self.profilePictureView.file = self.user[@"profileImage"];
    [self.profilePictureView loadInBackground];
}



@end
