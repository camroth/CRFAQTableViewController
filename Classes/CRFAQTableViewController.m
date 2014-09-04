//
//  CRFAQTableViewController.m
//
//  Created by Cam Roth on 2014-01-04.
//
//

#import "CRFAQTableViewController.h"

typedef enum kCRQuestion {
	kCRQuestionQuestion,
	kCRQuestionAnswer,
	kNumberOfCRQuestionParts
} kCRQuestion;

static NSString *kCellIdentifierForTableOfContents	= @"TableOfContentsCell";
static NSString *kCellIdentifierForAnswer			= @"AnswerCell";

@interface CRFAQTableViewController ()
- (UITableViewCell *)tableOfContentsCellWithTitle:(NSString *)title forIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)answerCellWithTitle:(NSString *)title forIndexPath:(NSIndexPath *)indexPath;
@end

@implementation CRFAQTableViewController

#pragma mark - Lifecycle

- (instancetype)initWithQuestions:(NSArray *)questions
{
	self = [[CRFAQTableViewController alloc] init];
	
	if (self) {
		_questions = [questions mutableCopy];
	}
	
	return self;
}

- (instancetype)init
{
	self = [super init];
	
	if (self) {
		_questions = [@[] mutableCopy];
		
		// Customization defaults
		// pale yellow
		_highlightedQuestionColor = [UIColor colorWithRed:248/255.0 green:241/255.0 blue:222/255.0 alpha:1.0];
		_highlightedQuestionDelay = 0.5;
		_highlightedQuestionDuration = 0.75;
		_indexTitle = @"Table of Contents";
		_questionsAreUppercase = YES;
		_fontForAnswers = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
		_fontForQuestions = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.edgesForExtendedLayout = UIRectEdgeAll;
	self.selectedRow = -1;
	
	[self.answersTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifierForAnswer];
	[self.indexTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifierForTableOfContents];
}

- (void)viewWillAppear:(BOOL)animated
{
	float height = 56.0f;
	for (int i = 0; i < [self numberOfQuestions]; i++) {
		height += [self tableView:self.indexTableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
	}

	self.answersTableView.tableHeaderView.frame = CGRectMake(CGRectGetMinX(self.indexTableView.frame), CGRectGetMinY(self.indexTableView.frame), CGRectGetWidth(self.indexTableView.frame), height);
	self.answersTableView.tableHeaderView = self.answersTableView.tableHeaderView;
	[self.answersTableView reloadData];
}

#pragma mark - Questions

- (void)addQuestion:(NSArray *)question
{
	if (question && [question count] == kNumberOfCRQuestionParts) {
		[self.questions addObject:question];
	}
}

- (void)addQuestion:(NSString *)question withAnswer:(NSString *)answer
{
	[self addQuestion:@[question, answer]];
}

- (int)numberOfQuestions
{
	return (int)[self.questions count];
}

- (NSString *)questionTextForQuestion:(NSArray *)question
{
	return question[kCRQuestionQuestion];
}

- (NSString *)answerTextForQuestion:(NSArray *)question
{
	return question[kCRQuestionAnswer];
}

#pragma mark - Tableview Stuff
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	int numberOfSections = 1;
	
	if (tableView == self.answersTableView) {
		numberOfSections = [self numberOfQuestions];
	}
	
	return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int numberOfRows = 1;
	
	if (tableView == self.indexTableView) {
		numberOfRows = [self numberOfQuestions];
	}
	
	return numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	float width = CGRectGetWidth(tableView.frame) - (2 * 15); // don't forget the margins
	NSString *text;
	UIFont *font;
	
	if (tableView == self.answersTableView) {
		text = [self answerTextForQuestion:self.questions[indexPath.section]];
		font = self.fontForAnswers;
	} else if (tableView == self.indexTableView) {
		text = [self questionTextForQuestion:self.questions[indexPath.row]];
		font = self.fontForQuestions;
		width -= 14; // the accessory view
	}
	
	float height = [text boundingRectWithSize:CGSizeMake(width, INT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
	height += 24.0f; // some breathing room
	
	return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 20;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *title;
	
	if (tableView == self.indexTableView) {
		title = self.indexTitle;
	}
	
	if (tableView == self.answersTableView) {
		return [self questionTextForQuestion:self.questions[section]];
	}
	
	if (self.questionsAreUppercase) {
		title = [title uppercaseString];
	}
	
	return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	
	if (tableView == self.answersTableView) {
		NSString *title = [self answerTextForQuestion:self.questions[indexPath.section]];
		cell = [self answerCellWithTitle:title forIndexPath:indexPath];
	} else {
		NSString *question = [self questionTextForQuestion:self.questions[indexPath.row]];
		cell = [self tableOfContentsCellWithTitle:question forIndexPath:indexPath];
	}
	
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.textLabel.numberOfLines = 0;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}

- (UITableViewCell *)answerCellWithTitle:(NSString *)title forIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.answersTableView dequeueReusableCellWithIdentifier:kCellIdentifierForAnswer forIndexPath:indexPath];
	
	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.font = self.fontForAnswers;
	cell.textLabel.text = title;
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.backgroundColor = [UIColor whiteColor];
	if (self.selectedRow == indexPath.section) {
		cell.backgroundColor = self.highlightedQuestionColor;
		[UIView animateWithDuration:self.highlightedQuestionDuration delay:self.highlightedQuestionDelay options:UIViewAnimationOptionCurveLinear animations:^{
			cell.backgroundColor = [UIColor whiteColor];
		} completion:^(BOOL finished) {
			self.selectedRow = -1;
		}];
	}
	
	return cell;
}

- (UITableViewCell *)tableOfContentsCellWithTitle:(NSString *)title forIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.indexTableView dequeueReusableCellWithIdentifier:kCellIdentifierForTableOfContents forIndexPath:indexPath];
	
	cell.backgroundColor = [UIColor whiteColor];
	cell.textLabel.textColor = [UIColor colorWithRed:0 green:122/255.0 blue:1.0 alpha:1.0];
	cell.textLabel.font = self.fontForQuestions;
	cell.textLabel.text = title;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.indexTableView) {
		self.selectedRow = (int)indexPath.row;
		NSIndexPath *indexPathForAnswer = [NSIndexPath indexPathForRow:0 inSection:self.selectedRow];
		[self.answersTableView scrollToRowAtIndexPath:indexPathForAnswer atScrollPosition:UITableViewScrollPositionTop animated:YES];
		[self.answersTableView reloadData];
	}
}

#pragma mark - Customization Methods

- (void)setSectionHeadersToUppercase:(BOOL)isUppercase
{
	_questionsAreUppercase = isUppercase;
}

@end
