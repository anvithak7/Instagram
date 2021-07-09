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
#import "LoginViewController.h"


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
    _post = post;
    /* This was an attempt at making the profilePicture clickable to go to profile tab, but unfortunately, I need to figure out how to connect the segue to the profile pic to the onTap method.
     self.userProfileView.userInteractionEnabled = YES;
    UITapGestureRecognizer *profilePicTap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    profilePicTap.numberOfTapsRequired = 1;
    [profilePicTap setDelegate:self];
    [self.userProfileView addGestureRecognizer:profilePicTap]; */
    
    PFUser *user = post[@"author"];
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            self.postUser = user;
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
    self.timeSincePostedLabel.text = createdDate.timeAgoSinceNow;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
}

- (IBAction)onTapLike:(id)sender {
    if ([self.post.likesArray containsObject:PFUser.currentUser[@"objectID"]]) {
        [self.likeButton setSelected:NO];
        [self.post removeObject:PFUser.currentUser.objectId forKey:@"likesArray"];
        self.post[@"likeCount"] = [NSNumber numberWithInt:([self.post.likeCount intValue] - 1)];
        [self.post saveInBackground];
        /*PFQuery *query = [PFQuery queryWithClassName:@"Post"];
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:_post[@"objectID"]
                                     block:^(PFObject *parseObject, NSError *error) {
            int likeCount = [self.post.likeCount intValue] - 1;
            parseObject[@"likeCount"] = @(likeCount);
            parseObject[@"likesArray"] = self.post.likesArray;
            [parseObject saveInBackground];
            NSLog(@"Updated unlike");
        }]; */
    } else if (![self.post.likesArray containsObject:PFUser.currentUser[@"objectID"]]) {
        [self.likeButton setSelected:YES];
        [self.post addObject:PFUser.currentUser.objectId forKey:@"likesArray"];
        self.post[@"likeCount"] = [NSNumber numberWithInt:([self.post.likeCount intValue] + 1)];
        [self.post saveInBackground];
        /*PFQuery *query = [PFQuery queryWithClassName:@"Post"];
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:_post[@"objectID"]
                                     block:^(PFObject *parseObject, NSError *error) {
            int likeCount = [self.post.likeCount intValue] + 1;
            parseObject[@"likeCount"] = @(likeCount);
            parseObject[@"likesArray"] = self.post.likesArray;
            [parseObject saveInBackground];
            NSLog(@"Updated unlike");
        }]; */
        //[self.post incrementKey:@"likeCount"];
        /*[self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
          if (succeeded) {
            // The score key has been incremented
              NSLog(@"Incremented like count!");
          } else {
            // There was a problem, check error.description
              NSLog(@"Error: %@", error.localizedDescription);
          }
        }];*/
    }
}

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
//I don't know how to segue between a cell item and a view controller!
- (IBAction) onTapProfile:(id)sender {
    [self.delegate profilePicTap:self didTap:self.postUser];
}
 

@end
