//
//  PostCell.h
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

// We declare this a class because otherwise, PostCell used in the delegate methods will not have been declared yet.
@class PostCell;

@protocol PostCellDelegate // We want the view controller to be able to know when an element within a post cell has been tapped, or else we can't segue to another screen.
// Thus, we made a delegate protocol.

- (void) profilePicTap:(PostCell*) postCell didTap:(PFUser*) postUser;

@end

@interface PostCell : UITableViewCell

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *userProfileView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *postCaptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *timeSincePostedLabel;
@property (weak, nonatomic) IBOutlet UIButton *segueToProfileButton;
@property (weak, nonatomic) id<PostCellDelegate> delegate;
@property (nonatomic, strong) PFUser *postUser;

@end

NS_ASSUME_NONNULL_END
