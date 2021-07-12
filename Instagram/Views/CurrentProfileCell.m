//
//  CurrentProfileCell.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/9/21.
//

#import "CurrentProfileCell.h"

@implementation CurrentProfileCell

// This file is associated with an older design for the profile view, which included a table view to add a collection view and show only a user's posts on their page.
// However, it is not currently in use since I had to cut this feature before the deadline.

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(PFUser *)user {
    self.profilePictureView.layer.masksToBounds = YES;
    self.profilePictureView.layer.cornerRadius = self.profilePictureView.frame.size.width / 2;
    _user = user;
    self.usernameLabel.text = user.username;
    self.fullNameLabel.text = user[@"fullName"];
    self.bioLabel.text = user[@"bioText"];
    self.numberOfPostsLabel.text = user[@"userPostsCount"];
    self.profilePictureView.file = user[@"image"];
    [self.profilePictureView loadInBackground];
}

@end
