//
//  CRFAQTableViewController.h
//
//  Created by Cam Roth on 2014-01-04.
//
//

#import <UIKit/UIKit.h>

@interface CRFAQTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *answersTableView;
@property (nonatomic, strong) IBOutlet UITableView *indexTableView;
@property (nonatomic, strong) NSMutableArray *questions;

@property (assign) int selectedRow;

@property (assign) float highlightedQuestionDelay;
@property (assign) float highlightedQuestionDuration;
@property (assign) BOOL questionsAreUppercase;
@property (nonatomic, strong) NSString *indexTitle;
@property (nonatomic, strong) UIColor *highlightedQuestionColor;
@property (nonatomic, strong) UIFont *fontForQuestions;
@property (nonatomic, strong) UIFont *fontForAnswers;

- (instancetype)initWithQuestions:(NSArray *)questions;
- (void)addQuestion:(NSString *)question withAnswer:(NSString *)answer;
- (int)numberOfQuestions;
- (NSString *)questionTextForQuestion:(NSArray *)question;
- (NSString *)answerTextForQuestion:(NSArray *)question;

#pragma mark - Customization
- (void)setSectionHeadersToUppercase:(BOOL)isUppercase;

@end
