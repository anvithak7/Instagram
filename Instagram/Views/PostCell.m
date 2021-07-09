//
//  PostCell.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/8/21.
//

#import "PostCell.h"
#import "UIImageView+AFNetworking.h"
#import "Post.h"
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

@end
