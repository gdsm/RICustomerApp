//
//  FeedbackView.h
//  ReddyIce
//
//  Created by Gagan on 27/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "ColoredButton.h"
#import "BlockUtils.h"


@interface FeedbackView : BaseView

+ (FeedbackView *) instance;

@property (weak, nonatomic) IBOutlet BaseLabel *lblQuestion;

@property (strong, nonatomic) blk_actionSender onRattingValue;

// used for refrence inside tableviews/collectionviews
@property (nonatomic, strong) NSIndexPath* indexPath;
@property (nonatomic) NSInteger feedbackValue;

@end
