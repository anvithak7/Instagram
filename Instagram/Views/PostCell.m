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

// This is for the post cell that holds information about each post.

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

// Here, we set up all the values for the post cell, populating all of the elements.
- (void) setPost:(Post *)post {
    // These two make the user's profile picture a circle.
    self.userProfileView.layer.masksToBounds = YES;
    self.userProfileView.layer.cornerRadius = self.userProfileView.frame.size.width / 2; // This makes the profile picture a circle.
    _post = post; // We need to make sure this post cell has a post associated with it.
    /* This was an attempt at making the profilePicture clickable to go to profile tab, but unfortunately, I need to figure out how to connect the segue to the profile pic to the onTap method.
     self.userProfileView.userInteractionEnabled = YES;
    UITapGestureRecognizer *profilePicTap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    profilePicTap.numberOfTapsRequired = 1;
    [profilePicTap setDelegate:self];
    [self.userProfileView addGestureRecognizer:profilePicTap]; */
    // EDIT: A gesture recognizer is another way to do it, but I placed a button over both and made the Feed View Controller the delegate of a post cell.
    // We need to load in the data from the user, such as their username and picture.
    // Since User is a different table in Parse, we need to fetch all the information from the database with a request.
    PFUser *user = post[@"author"];
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            // Now, we can set the fields in our post cell with this information.
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
            // If the user has a profile image, we load it in. Otherwise, they get a placeholder image.
            if (user[@"profileImage"]) {
                self.userProfileView.file = user[@"profileImage"];
                [self.userProfileView loadInBackground];
            }
        }
    }];
    // We want the short time ago to be displayed on the post cell when a user sees it in their feed.
    NSDate *createdDate = post.createdAt;
    self.timeSincePostedLabel.text = createdDate.timeAgoSinceNow;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
    // We set the image of the like button depending on whether or not a user has liked the post or not.
    if ([self.post.likesArray containsObject:PFUser.currentUser.objectId]) {
        [self.likeButton setSelected:YES];
    } else if (![self.post.likesArray containsObject:PFUser.currentUser.objectId]) {
        [self.likeButton setSelected:NO];
    }
}

// Likes are kept track of in an array associated with each post which holds the users who have liked a post. If a user is not in that list, their like button will not be red.
// If they tap like or unlike, their userID will be added or removed to that array and the image for their like button updated in their view. The post's like count will also change.
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
}

// This method allows the delegate (view controller) to know when the user tapped on the button element inside the post cell.
- (IBAction) onTapProfile:(id)sender {
    [self.delegate profilePicTap:self didTap:self.postUser];
}

@end
