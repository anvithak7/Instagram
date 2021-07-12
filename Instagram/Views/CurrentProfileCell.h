//
//  CurrentProfileCell.h
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/9/21.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

// This file is associated with an older design for the profile view, which included a table view to add a collection view and show only a user's posts on their page.
// However, it is not currently in use since I had to cut this feature before the deadline.

@interface CurrentProfileCell : UITableViewCell
@property (strong, nonatomic) PFUser *user;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet PFImageView
*profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;

@end

NS_ASSUME_NONNULL_END
