//
//  PostCell.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/8/21.
//

#import "PostCell.h"
#import "UIImageView+AFNetworking.h"
#import "Post.h"
#import <Parse/Parse.h>
#import <DateTools/DateTools.h>


@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setPost:(Post *)post {
    // These two make the user's profile picture a circle.
    self.userProfileView.layer.masksToBounds = YES;
    self.userProfileView.layer.cornerRadius = self.userProfileView.frame.size.width / 2;
    PFUser *user = post[@"author"];
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (error) {
            
        } else {
            self.usernameLabel.text = user[@"username"];
            // I wanted the username to be bold and the caption text to be normal, so I had to use NSMutableAttributedStrings, where you have to allocate each time and append doesn't return anything:
            NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0]};
            NSMutableAttributedString *username = [[NSMutableAttributedString alloc] initWithString:user[@"username"] attributes:attributes];
            NSMutableAttributedString *captionAlone = [[NSMutableAttributedString alloc] initWithString:post[@"caption"]];
            NSMutableAttributedString *captionText = [[NSMutableAttributedString alloc] init];
            [captionText appendAttributedString:username];
            [captionText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
            [captionText appendAttributedString:captionAlone];
            self.postCaptionLabel.attributedText = captionText;
        }
    }];
    NSDate *createdDate = post.createdAt;
    //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    //formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    //NSDate *date = [formatter dateFromString:createdAtOriginalString];
    // Configure output format
    //formatter.dateStyle = NSDateFormatterShortStyle;
    //formatter.timeStyle = NSDateFormatterShortStyle;
    // Convert Date to String
    self.timeSincePostedLabel.text = createdDate.timeAgoSinceNow;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
}

/* This method is a mess - I'm not able to get anything to communicate with Parse at all!
- (IBAction)onTapLike:(id)sender {
    if (_post.liked == YES) {
        PFQuery *query = [PFQuery queryWithClassName:@"Post"];
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:_post[@"objectID"]
                                     block:^(PFObject *parseObject, NSError *error) {
            parseObject[@"liked"] = @NO;
            int likeCount = [self.post.likeCount intValue] - 1;
            parseObject[@"likeCount"] = @(likeCount);
            [parseObject saveInBackground];
            NSLog(@"Updated unlike");
        }];
        [self.likeButton setImage:[UIImage systemImageNamed:@"heart"] forState:UIControlStateNormal];
    }
    else if (_post.liked == NO) {
        PFQuery *query = [PFQuery queryWithClassName:@"Post"];
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:_post[@"objectID"]
                                     block:^(PFObject *parseObject, NSError *error) {
            parseObject[@"liked"] = @YES;
            int likeCount = [self.post.likeCount intValue] + 1;
            parseObject[@"likeCount"] = @(likeCount);
            [parseObject saveInBackground];
            NSLog(@"Updated like");
        }];
        [self.post incrementKey:@"likeCount"];
        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
          if (succeeded) {
            // The score key has been incremented
              NSLog(@"Incremented");
          } else {
            // There was a problem, check error.description
              NSLog(@"Error: %@", error.localizedDescription);
          }
        }];
        [self.likeButton setImage:[UIImage systemImageNamed:@"heart.fill"] forState:UIControlStateNormal];
    }
} */

/* This method doesn't seem to work no matter what I do
- (IBAction)onTapComment:(id)sender {
    if (_post.commented == YES) {
        PFQuery *query = [PFQuery queryWithClassName:@"Post"];
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:_post[@"objectID"]
                                     block:^(PFObject *parseObject, NSError *error) {
            parseObject[@"commented"] = @NO;
            int commentCount = [self.post.commentCount intValue] - 1;
            parseObject[@"commentCount"] = @(commentCount);
            [parseObject saveInBackground];
            NSLog(@"Updated uncomment");
        }];
        [self.commentButton setImage:[UIImage systemImageNamed:@"bubble.right"] forState:UIControlStateNormal];
    }
    else if (_post.commented == NO) {
        PFQuery *query = [PFQuery queryWithClassName:@"Post"];
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:_post[@"objectID"]
                                     block:^(PFObject *parseObject, NSError *error) {
            parseObject[@"commented"] = @YES;
            int commentCount = [self.post.commentCount intValue] + 1;
            parseObject[@"commentCount"] = @(commentCount);
            [parseObject saveInBackground];
            NSLog(@"Updated comment");
        }];
        [self.commentButton setImage:[UIImage systemImageNamed:@"bubble.right.fill"] forState:UIControlStateNormal];
    }
}
 */

@end
