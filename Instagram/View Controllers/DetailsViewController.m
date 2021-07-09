//
//  DetailsViewController.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/8/21.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.usernameLabel.text = _post.author[@"username"];
    self.postImageView.file = _post[@"image"];
    [self.postImageView loadInBackground];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]};
    NSMutableAttributedString *username = [[NSMutableAttributedString alloc] initWithString:_post.author[@"username"] attributes:attributes];
    NSMutableAttributedString *captionAlone = [[NSMutableAttributedString alloc] initWithString:_post[@"caption"]];
    NSMutableAttributedString *captionText = [[NSMutableAttributedString alloc] init];
    [captionText appendAttributedString:username];
    [captionText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
    [captionText appendAttributedString:captionAlone];
    self.captionLabel.attributedText = captionText;
    NSDate *createdDate = _post.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM d, yyyy  h:mm a";
    self.timestampLabel.text = [formatter stringFromDate:createdDate];
    [self.likeButton setTitle:[NSString stringWithFormat:@"%@", _post.likeCount] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%@", _post.commentCount] forState:UIControlStateNormal];
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
