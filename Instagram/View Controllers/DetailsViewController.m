//
//  DetailsViewController.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/8/21.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end

@implementation DetailsViewController

// This view controller displays the information from a post on a separate screen when a post cell is tapped, and also allows a user to add likes.

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // We want to set up the post's information - the image, username, user's profile picture, and caption.
    self.profilePictureView.layer.masksToBounds = YES;
    self.profilePictureView.layer.cornerRadius = self.profilePictureView.frame.size.width / 2;
    self.usernameLabel.text = _post.author[@"username"];
    self.postImageView.file = _post[@"image"];
    [self.postImageView loadInBackground];
    self.profilePictureView.file = _post.author[@"profileImage"];
    [self.profilePictureView loadInBackground];
    // The below lines allow the bolded username to be attached to the caption.
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]};
    NSMutableAttributedString *username = [[NSMutableAttributedString alloc] initWithString:_post.author[@"username"] attributes:attributes];
    NSMutableAttributedString *captionAlone = [[NSMutableAttributedString alloc] initWithString:_post[@"caption"]];
    NSMutableAttributedString *captionText = [[NSMutableAttributedString alloc] init];
    [captionText appendAttributedString:username];
    [captionText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
    [captionText appendAttributedString:captionAlone];
    self.captionLabel.attributedText = captionText;
    // For the creation date and time, this details view provides more details about the exact time the posts were made.
    NSDate *createdDate = _post.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM d, yyyy  h:mm a";
    self.timestampLabel.text = [formatter stringFromDate:createdDate];
    // This sets up what the like button should look like, in case the user has already liked this post.
    if ([self.post.likesArray containsObject:PFUser.currentUser.objectId]) {
        [self.likeButton setSelected:YES];
    } else if (![self.post.likesArray containsObject:PFUser.currentUser.objectId]) {
        [self.likeButton setSelected:NO];
    }
    // Finally, the number of likes a post has should be displayed in the details view.
    self.likeCountLabel.text = [NSString stringWithFormat:@"%@", self.post[@"likeCount"]];
}

// This is similar to the method associated with PostCell, where a user can click on the like button to like a post and send that information to the database.
- (IBAction)onTapLike:(id)sender {
    if ([self.post.likesArray containsObject:PFUser.currentUser.objectId]) {
        [self.likeButton setSelected:NO];
        [self.post removeObject:PFUser.currentUser.objectId forKey:@"likesArray"];
        self.post[@"likeCount"] = [NSNumber numberWithInt:([self.post.likeCount intValue] - 1)];
        [self.post saveInBackground];
    } else if (![self.post.likesArray containsObject:PFUser.currentUser.objectId]) {
        [self.likeButton setSelected:YES];
        [self.post addObject:PFUser.currentUser.objectId forKey:@"likesArray"];
        self.post[@"likeCount"] = [NSNumber numberWithInt:([self.post.likeCount intValue] + 1)];
        [self.post saveInBackground];
    }
    self.likeCountLabel.text = [NSString stringWithFormat:@"%@", self.post[@"likeCount"]];
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
