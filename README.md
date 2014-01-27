# CRFAQTableViewController

CRFAQTableViewController allows you to quickly and easily display a clickable interface to navigate question and answer style content. All lines automatically account for the required height to display a question or answer, and an indexed table of contents appears at the top for quick navigation.

![Demo](https://raw.github.com/camroth/CRFAQTableViewController/master/demo.gif)

![Table of contents](https://raw.github.com/camroth/CRFAQTableViewController/master/screenshot-1.png)
![Item selected example](https://raw.github.com/camroth/CRFAQTableViewController/master/screenshot-2.png)

## Usage

```objective-c
CRFAQTableViewController *faqViewController = [[CRFAQTableViewController alloc] init];
[faqViewController addQuestion:@"How Many Questions Can I Add?" withAnswer:@"As many as you want!"];
```

Optionally, an initializer exists to create an FAQ with existing data:

```objective-c
- (instancetype)initWithQuestions:(NSArray *)questions;
```

Where questions take the form of an array of 2-item arrays:

```objective-c
@[	@[ @"Question", @"Answer" ]	]
```

Once you have your CRFAQTableViewController created, you can always add more questions:

```objective-c
- (void)addQuestion:(NSString *)question withAnswer:(NSString *)answer;
```

While sane defaults have been chosen, you might want your FAQ to look and feel differently. For your convenience and customization, you can use these:

```objective-c
- (void)setHighlightedQuestionDelay:(float)highlightedQuestionDelay;
- (void)setHighlightedQuestionDuration:(float)highlightedQuestionDuration;
- (void)setHighlightedQuestionColor:(UIColor *)highlightedQuestionColor;
- (void)setIndexTitle:(NSString *)indexTitle;
- (void)setFontForQuestions:(UIFont *)fontForQuestions;
- (void)setFontForAnswers:(UIFont *)fontForAnswers;
- (void)setSectionHeadersToUppercase:(BOOL)isUppercase;
```

## Installation

CRFAQTableViewController is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

    pod "CRFAQTableViewController"
    
If you're not using CocoaPods, you'll want to place both the h/m/xib somewhere in your project.

## License

CRFAQTableViewController is available under the MIT license. See the LICENSE file for more info.

